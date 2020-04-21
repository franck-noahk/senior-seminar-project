import { getInputVal } from './getInputValue.js';
let db = firebase.firestore();

let uid = null;

async function getAdminPriv() {
	var db = firebase.firestore();
	if (uid != null) {
		let docref = db.collection('users').doc(uid);
		docref.get().then(function(doc) {
			let toReturn = doc.data().isAdmin;
			return toReturn;
		});
	} else {
		return false;
	}
}
firebase.auth().onAuthStateChanged(function(user) {
	//Pulling values from our db
	if (user) {
		uid = user.uid;
		console.log('Uid = ' + uid);
		verify();
	} else {
		uid = null;
		console.log('Uid = ' + uid);
		verify();
	}
});

function verify() {
	console.log(window.location.pathname);
	console.log(getAdminPriv());
	if (uid && getAdminPriv()) {
		console.log('Is Admin');
		creatSignOutButton();
	} else if (uid) {
		console.log('is user');
		//TODO: build sign-out button

		if (
			window.location.pathname == 'my-club.html' ||
			window.location.pathname == 'create-events.html' ||
			window.location.pathname == 'my-club.html'
		) {
			window.location.href = 'https://senior-seminar-project-dev.web.app/';
		}

		let toRemove = document.getElementsByClassName('admin');
		for (var i = toRemove.length - 1; i >= 0; --i) {
			toRemove[i].remove();
		}
		creatSignOutButton();
	} else {
		console.log('normy');

		if (
			window.location.pathname == 'my-club.html' ||
			window.location.pathname == 'create-events.html' ||
			window.location.pathname == 'my-club.html'
		) {
			window.location.href = 'https://senior-seminar-project-dev.web.app/login.html';
		}
		let toRemove = document.getElementsByClassName('admin');
		if (toRemove)
			for (var i = toRemove.length - 1; i >= 0; --i) {
				toRemove[i].remove();
			}
		toRemove = document.getElementsByClassName('logged-in');
		if (toRemove)
			for (var i = toRemove.length - 1; i >= 0; --i) {
				toRemove[i].remove();
			}
	}
	// verify();
}

function creatSignOutButton() {
	let nav = document.getElementsByClassName('navbar-nav');
	for (let index = 0; index < nav.length; index++) {
		const element = nav[index];
		let login = document.getElementById('login-button');
		let signOut = document.createElement('li');
		let link = document.createElement('a');
		link.setAttribute('href', './signOut.html');
		link.setAttribute('class', 'nav-link');
		link.innerText = 'Sign Out';
		signOut.appendChild(link);

		element.replaceChild(signOut, login);
	}
}

function getEventsForFollowing(userUid) {
	//Should print data out to the screen or return some list of predefined objects that can be looped over easily to display on screen. active
	/*
    location in db:
    /users/{user}
        -isFollowing:array of strings

    /events/{event}
        -organizer: string of who made the event

    should display in feed if the two strings are idential


    */
}

function getAllEvents() {
	//Function to get all of the events
	/*
    location in DB:
    /events
  
    */
}

function displayEventCards(resultNum) {
	for (count = 0; count < resultNum; count++) {
		document.write(
			`<div class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title event-title` +
				count +
				`"></h5>
                <h6 class="card-subtitle mb-2 text-muted event-host` +
				count +
				`"></h6>
                <p class="card-text event-description` +
				count +
				`"></p>
                <p class="card-date event-date` +
				count +
				`"></p>
            </div>
        </div>`
		);
	}
}
//TODO: Fix this function.
// function fillEventCards(resultNum) {
//   for (count = 0; count < resultNum; count++) {
//     document.getElementsByClassName("event-title" + count).innerHTML = ;
//     document.getElementsByClassName("event-host" + count).innerHTML = ;
//     document.getElementsByClassName("event-description" + count).innerHTML = ;
//     document.getElementsByClassName("event-date" + count).innerHTML = ;
//   }
// }

function getAllUserInfo() {
	//Function to get all of the user's information
	/*
    location in DB:
    /users/{uid}
  
    */
}

function getRSVPData(eventUid) {
	//Function to get all of the RSVP data
	//eventUid is a string
	/*
      location in DB:
      /events/{event}/response/rsvp
  
      on the document rsvp each user's uid is there and says "isComming" or "isNotComming", and if there UID isn't on document they haven't confirmed or denied
  
      */
}

function getOrgData(orgUid) {
	//function to get all of the orginization's data
	//orgUid is considered a string
}

if (document.getElementById('register') != null)
	document.getElementById('register').addEventListener('submit', createAccount);

if (document.getElementById('login-form') != null)
	document.getElementById('login-form').addEventListener('submit', signin);

async function signin(e) {
	e.preventDefault();

	let email = getInputVal('login-user-name');
	let password = getInputVal('login-user-password');

	await firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
		// Handle Errors here.

		let errorMessage = error.message;

		if (errorMessage != null) alert(errorMessage);
		else window.location.replace('index.html');
	});
	window.location.href = 'http://127.0.0.1:5500/public/index.html';
}

function createAccount(e) {
	e.preventDefault();

	let email = getInputVal('emailCreate');
	let password = getInputVal('passwordCreate');
	let passwordCopy = getInputVal('passwordCopy');
	if (password === passwordCopy)
		firebase.auth().createUserWithEmailAndPassword(email, password).catch(function(error) {
			// Handle Errors here.
			let errorCode = error.code;
			let errorMessage = error.message;
			// [START_EXCLUDE]
			if (errorCode == 'auth/weak-password') alert('The password is too weak.');
			else alert(errorMessage);

			console.log(error);
			// [END_EXCLUDE]
		});
	else window.alert('Your passwords must be identical.');
}
