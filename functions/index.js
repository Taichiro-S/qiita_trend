const admin = require('firebase-admin')
const functions = require('firebase-functions')
const axios = require('axios')

const QIITA_API_V2_TAGS =
  'https://qiita.com/api/v2/tags?per_page=100&sort=count&page='

admin.initializeApp()

// 毎日6時にQiitaのタグ情報を取得してFirestoreに保存する

exports.fetchQiitaTags = functions
  .runWith({ timeoutSeconds: 300 })
  .pubsub.schedule('0 6,18 * * *') // Scheduled for 6:00 am and 6:00 pm
  .timeZone('Asia/Tokyo')
  .onRun(async (context) => {
    try {
      let allTags = []
      for (let page = 1; page <= 10; page++) {
        const response = await axios.get(QIITA_API_V2_TAGS + page)
        allTags = allTags.concat(response.data.topics)
      }

      const today = new Date()
      const yesterday = new Date(today)
      yesterday.setDate(today.getDate() - 1)
      const db = admin.firestore()

      for (const tag of allTags) {
        const tagRef = db.collection('tags').doc(tag.id.toString())
        const tagDoc = await tagRef.get()

        if (tagDoc.exists) {
          const oldData = tagDoc.data()
          const historyRef = tagRef
            .collection('history')
            .doc(yesterday.toISOString())
          const historyDoc = await historyRef.get()
          const historyData = {
            items_change: tag.items_count - oldData.items_count,
            followers_change: tag.followers_count - oldData.followers_count,
            date: today,
          }

          if (historyDoc.exists) {
            // Update the existing history document with the new changes
            await historyRef.update(historyData)
          } else {
            // Create a new history document with the changes
            await historyRef.set(historyData)
          }

          // Update the main tag document with the new counts
          await tagRef.update({
            items_count: tag.items_count,
            followers_count: tag.followers_count,
          })
        } else {
          // If tagDoc doesn't exist, save all data.
          await tagRef.set(tag)
          await tagRef.collection('history').doc(today.toISOString()).set({
            items_count: tag.items_count,
            followers_count: tag.followers_count,
            date: today,
          })
        }
        // If tagDoc doesn't exist, save all data.
        await tagRef.set(tag)
        await tagRef.collection('history').doc(today.toISOString()).set({
          items_count: tag.items_count,
          followers_count: tag.followers_count,
          date: today,
        })
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
  .pubsub.schedule('0 10 1 * *')
  .timeZone('Asia/Tokyo')
  .onRun(async (context) => {
    try {
      const db = admin.firestore()

      // 全てのトピックのドキュメントを取得
      const topicsSnapshot = await db.collection('tags').get()

      const now = new Date()
      const cutoffDate = new Date(
        now.getFullYear() - 5,
        now.getMonth(),
        now.getDate(),
      )

      const promises = []

      topicsSnapshot.docs.forEach((doc) => {
        const topicId = doc.id

        // 特定の日付よりも前のhistoryドキュメントを取得
        const oldHistoriesQuery = db
          .collection('tags')
          .doc(topicId)
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
