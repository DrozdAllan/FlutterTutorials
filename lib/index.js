const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.notifyNewMessage = functions.firestore
  // firestore path I have built in this project, dont forget to modify
  .document("conversations/{conversationId}/messages/{message}")
  .onCreate(async (snapshot) => {
    const database = admin.firestore();
    const messaging = admin.messaging();
    const message = snapshot.data();

    // get the users from their uid
    const receiver = await database.collection("users").doc(message.to).get();

    const sender = await database.collection("users").doc(message.from).get();

    const token = receiver.data().token;

    const payload = {
      notification: {
        title: `Nouveau message de ${sender.data().name}`,
        body: message.data,
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    };
    return messaging.sendToDevice(token, payload);
  });
