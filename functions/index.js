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

exports.sendNotificationToTopic = functions.firestore.document('/events/{eventID}').onCreate(async (snapshot, context) => {
	let eventData = snapshot.data();
	let payLoad = {

		data: {
			title: "New Event Created",
			body: `${eventData.name} is taking place at ${eventData.location} at ${eventData.event_time} `,
			clickAction: 'FLUTTER_NOTIFICATION_CLICK'
		},

		topic: `orginizations${eventData.organizer}`,
	};

	admin.messaging().send(payLoad)
		.then((response) => {
			console.log(eventData.organizer);
			return console.log('Successfully sent message:', response);
		}).catch((error) => {
			console.log('Error sending message:', error);
		});

});

exports.deleteOldItems = functions.firestore.document('events/{eventId}')
	.onWrite((change, context) => {
		// var ref = change.after.ref.parent; // reference to the items

		var now = Date.now();
		var cutoff = now - 365 * 24 * 60 * 60 * 1000;
		db.collection('events').where('event_time', '<', cutoff).get().then((querySnapshot) => {
			if (querySnapshot.empty) {
				return console.log("no Documents to delete");
			}
			querySnapshot.forEach(function (doc) {
				// doc.data() is never undefined for query doc snapshots
				doc.delete();
			});
		}).catch((reason) => {
			console.log(reason);
		});
		// oldItemsQuery.((snapshot) {
		// 	// create a map with all children that need to be removed
		// 	var updates = {};
		// 	snapshot.forEach(function (child) {
		// 		updates[child.key] = null
		// 	});
		// 	// execute all updates in one go and return the result to end the function
		// 	return ref.update(updates);
		// });
	});