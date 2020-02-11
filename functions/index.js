const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.addUserToDB = functions.auth.user().onCreate((user) => {
	//TODO: set up the teacher/authorized users.

	db.doc('users/' + user.uid).set({
		email       : user.email,
		uid         : user.uid,
		name        : user.displayName,
		isAdmin     : false,
		isFollowing : [],
	});
});
