const QIITA_API_V2_TAGS =
  'https://qiita.com/api/v2/tags?per_page=100&sort=count&page='
const TIME_TO_FETCH_TAGS = '0 0,6,12,18 * * *'
const TIME_TO_CALC_RANKING = '30 11 * * *'
const WEEKLY_ITEMS_COUNT_CUTOFF = 7
const MONTHLY_ITEMS_COUNT_CUTOFF = 30
const WEEKLY_FOLLOWERS_COUNT_CUTOFF = 7
const MONTHLY_FOLLOWERS_COUNT_CUTOFF = 30
const admin = require('firebase-admin')
const functions = require('firebase-functions')
const axios = require('axios')

admin.initializeApp()
const db = admin.firestore()

// 毎日0,6,12,18時にQiitaの上位1000個分のタグ情報を取得してFirestoreに保存する
exports.fetchQiitaTags = functions
  .runWith({ timeoutSeconds: 540 })
  .pubsub.schedule(TIME_TO_FETCH_TAGS)
  .timeZone('Asia/Tokyo')
  .onRun(async (context) => {
    try {
      let allTags = []
      for (let page = 1; page <= 5; page++) {
        const response = await axios.get(QIITA_API_V2_TAGS + page)
        allTags = allTags.concat(response.data)
      }

      const now = new Date()
      const start = new Date(now)
      start.setHours(start.getHours() - 7)
      const end = new Date(now)
      end.setHours(end.getHours() - 1)
      const tagsRef = db.collection('tags')
      for (const tag of allTags) {
        const tagRef = tagsRef.doc(tag.id)
        const tagDoc = await tagRef.get()
        if (tagDoc.exists) {
          const historyPreviousRef = tagRef
            .collection('history')
            .where('date', '<', end)
            .where('date', '>', start)
            .limit(1)
          const historyCurrentRef = tagRef
            .collection('history')
            .doc(now.toISOString())
          const historyPreviousDoc = await historyPreviousRef.get()
          if (!historyPreviousDoc.empty) {
            // If previous history document exists, calculate the changes
            const historyData = {
              items_change:
                tag.items_count - historyPreviousDoc.docs[0].data().items_count,
              followers_change:
                tag.followers_count -
                historyPreviousDoc.docs[0].data().followers_count,
              items_count: tag.items_count,
              followers_count: tag.followers_count,
              date: now,
            }
            await historyCurrentRef.set(historyData)
          } else {
            // If previous history document doesn't exist, 
            // calculate change from recent data.
            const historyRecentPreviousRef = tagRef
              .collection('history')
              .where('date', '<', end)
              .orderBy('date', 'desc')
              .limit(1)
            const historyRecentPreviousDoc =
              await historyRecentPreviousRef.get()
            const historyData = {
              items_change:
                tag.items_count -
                historyRecentPreviousDoc.docs[0].data().items_count,
              followers_change:
                tag.followers_count -
                historyRecentPreviousDoc.docs[0].data().followers_count,
              items_count: tag.items_count,
              followers_count: tag.followers_count,
              date: now,
            }
            await historyCurrentRef.set(historyData)
          }
          // Update the main tag document with the new counts
          await tagRef.update({
            items_count: tag.items_count,
            followers_count: tag.followers_count,
          })
        } else {
          // If tagDoc doesn't exist, save all data.
          await tagRef.set(tag)
          await tagRef.collection('history').doc(now.toISOString()).set({
            items_count: tag.items_count,
            followers_count: tag.followers_count,
            date: now,
          })
        }
      }
      return null
    } catch (error) {
      console.error('Error fetching data:', error.message)
      throw new functions.https.HttpsError(
        'internal',
        'Failed to fetch and store data.',
      )
    }
  })

// 毎日6:30に、Firestoreに保存されているタグ情報を元に、ランキングを作成する
exports.calculateWeeklyRanking = functions
  .runWith({ timeoutSeconds: 540 })
  .pubsub.schedule(TIME_TO_CALC_RANKING)
  .timeZone('Asia/Tokyo')
  .onRun(async (context) => {
    try {
      console.log(QIITA_API_V2_TAGS, TIME_TO_FETCH_TAGS, TIME_TO_CALC_RANKING)
      // const getDayRange = (date) => {
      //   const startOfDay = new Date(date)
      //   startOfDay.setHours(0, 0, 0, 0)
      //   const endOfDay = new Date(date)
      //   endOfDay.setHours(23, 59, 59, 999)
      //   return { startOfDay, endOfDay }
      // }
      const getOneDayRange = (date) => {
        const startOfDay = new Date(date)
        startOfDay.setHours(startOfDay.getHours() - 24)
        const endOfDay = new Date(date)
        return { startOfDay, endOfDay }
      }
      const now = new Date()
      const oneWeekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000)
      const thisWeek = []
      for (let i = 0; i < 7; i++) {
        const date = new Date(now.getTime() - i * 24 * 60 * 60 * 1000)
        const { startOfDay, endOfDay } = getOneDayRange(date)
        thisWeek.push({ startOfDay, endOfDay })
      }
      const { startOfDay: startOfToday, endOfDay: endOfToday } =
      getOneDayRange(now)
      const { startOfDay: startOfOneWeekAgo, endOfDay: endOfOneWeekAgo } =
      getOneDayRange(oneWeekAgo)

      const tagsRef = db.collection('tags')
      const tagsSnapshot = await tagsRef.get()
      console.log(startOfOneWeekAgo, endOfOneWeekAgo, startOfToday, endOfToday)
      const weeklyRankRef = db
        .collection('weeklyRanking')
        .doc(now.toISOString())
      await weeklyRankRef.set({ date: now })
      for (const tagDoc of tagsSnapshot.docs) {
        const tagId = tagDoc.id
        const weeklyTagRef = weeklyRankRef.collection('tags').doc(tagId)
        // 全タグについて1週間前と現在の記事数とフォロワー数の差分を取得
        let weeklyItemsCountChange = 0
        let weeklyFollowersCountChange = 0
        const historyRef = tagsRef.doc(tagId).collection('history')
        const currentSnapshot = await historyRef
          .where('date', '>=', startOfToday)
          .where('date', '<=', endOfToday)
          .orderBy('date', 'desc')
          .limit(1)
          .get()
        const oneWeekAgoSnapshot = await historyRef
          .where('date', '>=', startOfOneWeekAgo)
          .where('date', '<=', endOfOneWeekAgo)
          .orderBy('date', 'desc')
          .limit(1)
          .get()

        if (!currentSnapshot.empty && !oneWeekAgoSnapshot.empty) {
          weeklyItemsCountChange =
            currentSnapshot.docs[0].data().items_count -
            oneWeekAgoSnapshot.docs[0].data().items_count
        }
        if (!currentSnapshot.empty && !oneWeekAgoSnapshot.empty) {
          weeklyFollowersCountChange =
            currentSnapshot.docs[0].data().followers_count -
            oneWeekAgoSnapshot.docs[0].data().followers_count
        }
        if (
          weeklyFollowersCountChange < WEEKLY_FOLLOWERS_COUNT_CUTOFF &&
          weeklyItemsCountChange < WEEKLY_ITEMS_COUNT_CUTOFF
        ) {
          continue
        }

        // 一週間分の変化を取得
        let weeklyItemsCountHistory = []
        let weeklyFollowersCountHistory = []
        for (const day of thisWeek) {
          const daySnapshot = await historyRef
            .where('date', '>=', day.startOfDay)
            .where('date', '<=', day.endOfDay)
            .orderBy('date', 'desc')
            .limit(4)
            .get()

          if (daySnapshot.docs.length < 4) {
            weeklyItemsCountHistory = []
            weeklyFollowersCountHistory = []
            break
          }
          let itemsCountChange = 0
          for (let i = 0; i < 4; i++) {
            itemsCountChange += daySnapshot.docs[i].data().items_change
          }
          let followersCountChange = 0
          for (let i = 0; i < 4; i++) {
            followersCountChange += daySnapshot.docs[i].data().followers_change
          }
          // if (weeklyItemsCountChange > weeklyItemsCountCutoff) {
          //   const weeklyItemsCountHistoryRef = weeklyTagRef
          //   .collection('items_count_history')
          //   .doc(day.endOfDay.toISOString())
          //   await weeklyItemsCountHistoryRef.set({
          //     day: day.endOfDay,
          //     item_count_change: itemsCountChange,
          //   })
          // }
          // if (weeklyFollowersCountChange > weeklyFollowersCountCutoff) {
          //   const weeklyFollowersCountHistoryRef = weeklyTagRef
          //   .collection('followers_count_history')
          //   .doc(day.endOfDay.toISOString())
          //   await weeklyFollowersCountHistoryRef.set({
          //     day: day.endOfDay,
          //     followers_count_change: followersCountChange,
          //   })
          // }
          weeklyItemsCountHistory.push({
            day: day.endOfDay,
            change: itemsCountChange,
          })
          weeklyFollowersCountHistory.push({
            day: day.endOfDay,
            change: followersCountChange,
          })
        }
        if (weeklyFollowersCountHistory.length < 7) {
          weeklyItemsCountHistory = []
        }
        if (weeklyItemsCountHistory.length < 7) {
          weeklyFollowersCountHistory = []
        }
        const weeklyFollowersCountHistoryJson = weeklyFollowersCountHistory.reduce((acc, item) => {
          acc[item.day.toISOString()] = item.change;
          return acc;
        }, {});
        const weeklyItemsCountHistoryJson = weeklyItemsCountHistory.reduce((acc, item) => {
          acc[item.day.toISOString()] = item.change;
          return acc;
        }, {});
        weeklyTagRef.set({
          id: tagId,
          icon_url: tagDoc.data().icon_url,
          items_count: currentSnapshot.docs[0].data().items_count,
          followers_count: currentSnapshot.docs[0].data().followers_count,
          items_count_change: weeklyItemsCountChange,
          followers_count_change: weeklyFollowersCountChange,
          items_count_history: weeklyItemsCountHistoryJson,
          followers_count_history: weeklyFollowersCountHistoryJson,
          date: now,
        })
      }

      return null
    } catch (error) {
      console.error('Error calculating ranking:', error.message)
      throw new functions.https.HttpsError(
        'internal',
        'Failed to calculate and store ranking.',
      )
    }
  })

exports.calculateMonthlyRanking = functions
  .runWith({ timeoutSeconds: 540 })
  .pubsub.schedule(TIME_TO_CALC_RANKING)
  .timeZone('Asia/Tokyo')
  .onRun(async (context) => {
    try {
      const getDayRange = (date) => {
        const startOfDay = new Date(date)
        startOfDay.setHours(0, 0, 0, 0)
        const endOfDay = new Date(date)
        endOfDay.setHours(23, 59, 59, 999)
        return { startOfDay, endOfDay }
      }
      const now = new Date()
      const oneMonthAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000)
      const thisMonth = []
      for (let i = 0; i < 30; i++) {
        const date = new Date(now.getTime() - i * 24 * 60 * 60 * 1000)
        const { startOfDay, endOfDay } = getDayRange(date)
        thisMonth.push({ startOfDay, endOfDay })
      }
      const { startOfDay: startOfToday, endOfDay: endOfToday } =
        getDayRange(now)
      const { startOfDay: startOfOneMonthAgo, endOfDay: endOfOneMonthAgo } =
        getDayRange(oneMonthAgo)

      const tagsRef = db.collection('tags')
      const tagsSnapshot = await tagsRef.get()

      const monthlyRankRef = db
        .collection('monthlyRanking')
        .doc(now.toISOString())
      await monthlyRankRef.set({ date: now })
      for (const tagDoc of tagsSnapshot.docs) {
        const tagId = tagDoc.id
        const monthlyTagRef = monthlyRankRef.collection('tags').doc(tagId)
        // 全タグについて1ヶ月と現在の記事数とフォロワー数の差分を取得
        let monthlyItemsCountChange = 0
        let monthlyFollowersCountChange = 0
        const historyRef = tagsRef.doc(tagId).collection('history')
        const currentSnapshot = await historyRef
          .where('date', '>=', startOfToday)
          .where('date', '<=', endOfToday)
          .orderBy('date', 'desc')
          .limit(1)
          .get()
        const oneMonthAgoSnapshot = await historyRef
          .where('date', '>=', startOfOneMonthAgo)
          .where('date', '<=', endOfOneMonthAgo)
          .orderBy('date', 'desc')
          .limit(1)
          .get()
        if (!currentSnapshot.empty && !oneMonthAgoSnapshot.empty) {
          monthlyItemsCountChange =
            currentSnapshot.docs[0].data().items_count -
            oneMonthAgoSnapshot.docs[0].data().items_count
        }
        if (!currentSnapshot.empty && !oneMonthAgoSnapshot.empty) {
          monthlyFollowersCountChange =
            currentSnapshot.docs[0].data().followers_count -
            oneMonthAgoSnapshot.docs[0].data().followers_count
        }
        if (
          monthlyFollowersCountChange < MONTHLY_FOLLOWERS_COUNT_CUTOFF &&
          monthlyItemsCountChange < MONTHLY_ITEMS_COUNT_CUTOFF
        ) {
          continue
        }
        monthlyTagRef.set({
          id: tagId,
          icon_url: tagDoc.data().icon_url,
          items_count: currentSnapshot.docs[0].data().items_count,
          followers_count: currentSnapshot.docs[0].data().followers_count,
          items_count_change: monthlyItemsCountChange,
          followers_count_change: monthlyFollowersCountChange,
          date: now,
        })

        // 一ヶ月分の変化を取得
        // let monthlyItemsCountChanges = []
        // let monthlyFollowersCountChanges = []
        for (const day of thisMonth) {
          const daySnapshot = await historyRef
            .where('date', '>=', day.startOfDay)
            .where('date', '<=', day.endOfDay)
            .orderBy('date', 'desc')
            .limit(4)
            .get()
          if (daySnapshot.docs.length < 4) {
            // monthlyItemsCountChanges = []
            // monthlyFollowersCountChanges = []
            break
          }
          let itemsCountChange = 0
          for (let i = 0; i < 4; i++) {
            itemsCountChange += daySnapshot.docs[i].data().items_change
          }
          let followersCountChange = 0
          for (let i = 0; i < 4; i++) {
            followersCountChange += daySnapshot.docs[i].data().followers_change
          }
          if (monthlyItemsCountChange > MONTHLY_ITEMS_COUNT_CUTOFF) {
            const monthlyItemsCountHistoryRef = monthlyTagRef
              .collection('items_count_history')
              .doc(day.endOfDay.toISOString())
            await monthlyItemsCountHistoryRef.set({
              day: day.endOfDay,
              items_count: itemsCountChange,
            })
          }
          if (monthlyFollowersCountChange > MONTHLY_FOLLOWERS_COUNT_CUTOFF) {
            const monthlyFollowersCountHistoryRef = monthlyTagRef
              .collection('followers_count_history')
              .doc(day.endOfDay.toISOString())
            await monthlyFollowersCountHistoryRef.set({
              day: day.endOfDay,
              followers_count: followersCountChange,
            })
          }
        }
      }
      return null
    } catch (error) {
      console.error('Error calculating ranking:', error.message)
      throw new functions.https.HttpsError(
        'internal',
        'Failed to calculate and store ranking.',
      )
    }
  })

// 取得から1年以上経過したhistoryドキュメントを削除する

exports.deleteOldHistories = functions
  .runWith({ timeoutSeconds: 300 })
  .pubsub.schedule('0 7 * * *')
  .timeZone('Asia/Tokyo')
  .onRun(async (context) => {
    try {
      const db = admin.firestore()
      // 全てのトピックのドキュメントを取得
      const tagsSnapshot = await db.collection('tags').get()
      const now = new Date()
      const cutoffDate = new Date(
        now.getFullYear() - 5,
        now.getMonth(),
        now.getDate(),
      )

      const promises = []

      tagsSnapshot.docs.forEach((doc) => {
        const tagId = doc.id

        // 特定の日付よりも前のhistoryドキュメントを取得
        const oldHistoriesQuery = db
          .collection('tags')
          .doc(tagId)
          .collection('history')
          .where('date', '<', cutoffDate)

        // 古いhistoryドキュメントを削除
        const promise = oldHistoriesQuery.get().then((snapshot) => {
          const deletePromises = []
          snapshot.docs.forEach((doc) => {
            deletePromises.push(doc.ref.delete())
          })
          return Promise.all(deletePromises)
        })

        promises.push(promise)
      })

      await Promise.all(promises)
      return null
    } catch (error) {
      console.error('Error deleting data:', error.message)
      throw new functions.https.HttpsError('internal', 'Failed to delete data.')
    }
  })
