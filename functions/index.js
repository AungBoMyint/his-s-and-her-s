/* eslint-disable */

const admin = require("firebase-admin");
admin.initializeApp();
const functions = require("firebase-functions");

exports.sendNotification = functions.region("asia-southeast2").https.onCall(async (data, context) => {
    const message = {
        notification: {
            title: data.title,
            content: data.content,
        },
        data: {
            click_action: "FLUTTER_NOTIFICATION_CLICK",
            route: data.route,
        },
        topic: data.topic,
    };

    return admin
        .messaging()
        .send(message)
        .then((response) => {
            console.log("Successfully sent message:", response);
        })
        .catch((error) => {
            console.log("Error sending message:", error);
        });
});
