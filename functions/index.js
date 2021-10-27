const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.notifyNewMessage = functions.firestore
  // firestore path I have built in this project, dont forget to modify
  .document("conversations/{conversationId}/messages/{message}")
  .onCreate(async (snapshot) => {
    // get the users from their uid
    const sender = await admin
      .firestore()
      .collection("users")
      .doc(snapshot.data().from)
      .get();

    const receiver = await admin
      .firestore()
      .collection("users")
      .doc(snapshot.data().to)
      .get();

    return admin
      .messaging()
      .sendToDevice(
        // one token with a string or multiple with a list of string
        receiver.data().notificationToken,
        {
          // if you only want to send a notification, only use the notification object
          notification: {
            title: `Nouveau message de ${sender.data().name}`,
            body: snapshot.data().data,
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
          // if you want to send data, its a key-value pairs form with a 4KB total, so convert objects to JSON
          data: {
            type: "chat",
            // this way you can get the FirestoreUser model from
            // this data with its .fromMap() method
            // but you should only get the data you need beforehand
            fullSenderObjectData: JSON.stringify(sender.data()),
          },
        },
        {
          // If you send data only messages (so no notification), you need the two lines below
          // Required for background/quit data-only messages on iOS
          contentAvailable: true,
          // Required for background/quit data-only messages on Android
          priority: "high",
        }
      )
      .then((response) => {
        console.log("Successfully sent message:", response);
        console.log(response.results[0].error);
      })
      .catch((error) => {
        console.log("Error sending message:", error);
      });
  });
