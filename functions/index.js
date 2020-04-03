const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.addUserToDB = functions.auth.user().onCreate((user) => {
	//TODO: set up the teacher/authorized users.

	db.doc('users/' + user.uid).set({
		email: user.email,
		uid: user.uid,
		name: user.displayName,
		isAdmin: false,
		isAdminOf: '',
		isFollowing: [],
	});
});

exports.sendNotificationToTopic = functions.firestore.document('/events/{eventID}').onCreate(async snapshot => {
	let eventData = snapshot.data();
	let orginizaer = await db.doc(eventData.orginizaer).get();
	let orginizerData = organizer.data();
	let payLoad = {
		notification: {
			title: "New Event Created",
			body: `${organizerData.name} created an event ${eventData.name}`,
			clickAction: 'FLUTTER_NOTIFICATION_CLICK'
		}
	};

	fcm.sendNotificationToTopic(orginizerData.name, payLoad).then((response) => {
		return console.log("Successfully sent message" + response);
	}).catch((error) => {
		return console.log('Error sending message:', error);
	});

})