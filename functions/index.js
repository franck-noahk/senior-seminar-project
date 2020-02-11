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
	if (user.email.contains('@my.uu.edu')) {
		//TODO: set up the teacher/authorized users.
		db.doc('admins/' + user.uid).set({
			email        : user.email,
			name         : user.displayName,
			uid          : user.uid,
			orginization : '',
		});
	} else if (user.email.contains('@uu.edu')) {
		db.doc('users/' + user.uid).set({
			email       : user.email,
			uid         : user.uid,
			name        : user.displayName,
			isAdmin     : false,
			isFollowing : [],
		});
	} else {
		//TODO: Catch all for unknown user

		db.doc('randomUsers' + user.uid).set({
			email : user.email,
			name  : user.displayName,
			date  : user.uid,
		});
	}
});
