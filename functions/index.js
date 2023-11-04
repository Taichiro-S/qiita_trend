const admin = require('firebase-admin')
const functions = require('firebase-functions')
const axios = require('axios')

const QIITA_API_V2_TAGS =
  'https://qiita.com/api/v2/tags?per_page=1&sort=count&page='
const timeToFetch = '0 0,6,12,18 * * *'
admin.initializeApp()

// 毎日6時にQiitaの上位1000個分のタグ情報を取得してFirestoreに保存する

exports.fetchQiitaTags = functions
  .runWith({ timeoutSeconds: 300 })
  .pubsub.schedule(timeToFetch)
  .timeZone('Asia/Tokyo')
  .onRun(async (context) => {
    try {
      let allTags = []
      for (let page = 1; page <= 1; page++) {
        const response = await axios.get(QIITA_API_V2_TAGS + page)
        allTags = allTags.concat(response.data)
      }

      const now = new Date()
      const start = new Date(now)
      start.setHours(start.getHours() - 7)
      const end = new Date(now)
      end.setHours(end.getHours() - 1)
      const db = admin.firestore()
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
            // If previous history document doesn't exist, save all data.
            const historyData = {
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

// 取得から5年以上経過したhistoryドキュメントを削除する

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
