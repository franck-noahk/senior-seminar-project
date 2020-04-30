import { getInputVal } from "./getInputValue.js";

let db = firebase.firestore();

let uid = null;

async function getAdminPriv() {
  var db = firebase.firestore();
  if (uid != null) {
    let docref = db.collection("users").doc(uid);
    docref.get().then(function (doc) {
      let toReturn = doc.data().isAdmin;
      return toReturn;
    });
  } else {
    return false;
  }
}
firebase.auth().onAuthStateChanged(function (user) {
  firebase.auth().onAuthStateChanged(function (user) {
    //Pulling values from our db
    if (user) {
      uid = user.uid;
      console.log("Uid = " + uid);
      verify();
    } else {
      uid = null;
      console.log("Uid = " + uid);
      verify();
    }
  });
});

function verify() {
  console.log(window.location.pathname);
  console.log(getAdminPriv());
  if (uid && getAdminPriv()) {
    console.log("Is Admin");
    creatSignOutButton();
  } else if (uid) {
    console.log("is user");
    //TODO: build sign-out button

    if (
      window.location.pathname.includes("my-club.html") ||
      window.location.pathname.includes("create-events.html") ||
      window.location.pathname.includes("my-club.html")
    ) {
      window.location.href = "https://senior-seminar-project-dev.web.app/";
    }

    let toRemove = document.getElementsByClassName("admin");
    for (var i = toRemove.length - 1; i >= 0; --i) {
      toRemove[i].remove();
    }
    creatSignOutButton();
  } else {
    console.log("normy");

    if (
      window.location.pathname == "my-club.html" ||
      window.location.pathname == "create-events.html" ||
      window.location.pathname == "my-club.html"
    ) {
      window.location.href =
        "https://senior-seminar-project-dev.web.app/login.html";
    }
    let toRemove = document.getElementsByClassName("admin");
    if (toRemove)
      for (var i = toRemove.length - 1; i >= 0; --i) {
        toRemove[i].remove();
      }
    toRemove = document.getElementsByClassName("logged-in");
    if (toRemove)
      for (var i = toRemove.length - 1; i >= 0; --i) {
        toRemove[i].remove();
      }
  }
  // verify();
}

function creatSignOutButton() {
  let nav = document.getElementsByClassName("navbar-nav");
  for (let index = 0; index < nav.length; index++) {
    const element = nav[index];
    let login = document.getElementById("login-button");
    let signOut = document.createElement("li");
    let link = document.createElement("a");
    link.setAttribute("href", "./signOut.html");
    link.setAttribute("class", "nav-link");
    link.innerText = "Sign Out";
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

async function getAllEvents() {
  //pulls events for the my bulletin page
  db.collection("events")
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        // doc.data() is never undefined for query doc snapshots
        console.log(doc.data());
        console.log(doc.data().name);
        createEventCard(
          doc.data().name,
          doc.data().organizer,
          doc.data().location,
          doc.data().event_time,
          doc.data().description
        );
      });
    });
}
if (document.getElementById("bulletin-content-div")) {
  document.getElementById("bulletin-content-div").onload = getAllEvents();
}

function createEventCard(title, eHost, locate, date, descript) {
  let root = document.getElementById("bulletin-content-div");
  if (root) {
    let card = document.createElement("div");
    card.setAttribute("class", "card");

    let cardBody = document.createElement("div");
    cardBody.setAttribute("class", "card-body");
    card.appendChild(cardBody);

    let cardTitle = document.createElement("h5");
    cardTitle.setAttribute("class", "card-title event-title");
    cardTitle.innerText = title;
    cardBody.appendChild(cardTitle);

    let host = document.createElement("h6");
    host.setAttribute("class", "card-host mb-2 text-muted event-host");
    host.innerText = eHost;
    cardBody.appendChild(host);

    let desc = document.createElement("p");
    desc.setAttribute("class", "card-text event-description");
    desc.innerText = descript;
    cardBody.appendChild(desc);

    let location = document.createElement("p");
    location.setAttribute("class", "card-location event-location");
    location.innerText = locate;
    cardBody.appendChild(location);

    let eventDate = document.createElement("p");
    eventDate.setAttribute("class", "card-date event-date");
    eventDate.innerText = date.toDate();
    cardBody.appendChild(eventDate);

    let rsvp = document.createElement("button");
    rsvp.setAttribute("class", "card-button rsvp-button");
    rsvp.innerText = "RSVP";
    cardBody.appendChild(rsvp);

    root.appendChild(card);
  }
}

async function getMyEvents() {
  //pulls events for the my events admin page
  db.collection("events")
    .where("organizer", "==", "")
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        // doc.data() is never undefined for query doc snapshots
        console.log(doc.data());
        console.log(doc.data().name);
        createMyEventCard(
          doc.data().name,
          doc.data().organizer,
          doc.data().location,
          doc.data().event_time,
          doc.data().description
        );
      });
    });
}
if (document.getElementById("events-content-div")) {
  document.getElementById("events-content-div").onload = getMyEvents();
}

function createMyEventCard(title, eHost, locate, date, descript) {
  let root = document.getElementById("events-content-div");
  if (root) {
    let card = document.createElement("div");
    card.setAttribute("class", "card");

    let cardBody = document.createElement("div");
    cardBody.setAttribute("class", "card-body");
    card.appendChild(cardBody);

    let cardTitle = document.createElement("h5");
    cardTitle.setAttribute("class", "card-title event-title");
    cardTitle.innerText = title;
    cardBody.appendChild(cardTitle);

    let host = document.createElement("h6");
    host.setAttribute("class", "card-host mb-2 text-muted event-host");
    host.innerText = eHost;
    cardBody.appendChild(host);

    let desc = document.createElement("p");
    desc.setAttribute("class", "card-text event-description");
    desc.innerText = descript;
    cardBody.appendChild(desc);

    let location = document.createElement("p");
    location.setAttribute("class", "card-location event-location");
    location.innerText = locate;
    cardBody.appendChild(location);

    let eventDate = document.createElement("p");
    eventDate.setAttribute("class", "card-date event-date");
    eventDate.innerText = date.toDate();
    cardBody.appendChild(eventDate);

    let edit = document.createElement("button");
    edit.setAttribute("class", "card-button edit-button");
    edit.innerText = "Edit";
    cardBody.appendChild(edit);

    root.appendChild(card);
  }
}

async function getClubs() {
  // pulls the organizations for the find clubs page
  db.collection("orginizations")
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        // doc.data() is never undefined for query doc snapshots
        console.log(doc.data());
        console.log(doc.data().name);
        createClubCard(
          doc.data().name
          //doc.data().description
        );
      });
    });
}
if (document.getElementById("club-content-div")) {
  document.getElementById("club-content-div").onload = getClubs();
}

function createClubCard(club, descript) {
  let root = document.getElementById("club-content-div");
  if (root) {
    let card = document.createElement("div");
    card.setAttribute("class", "card");

    let cardBody = document.createElement("div");
    cardBody.setAttribute("class", "card-body");
    card.appendChild(cardBody);

    let cardTitle = document.createElement("h5");
    cardTitle.setAttribute("class", "card-title club-title");
    cardTitle.innerText = club;
    cardBody.appendChild(cardTitle);

    let desc = document.createElement("p");
    desc.setAttribute("class", "card-text club-description");
    desc.innerText = descript;
    cardBody.appendChild(desc);

    let sub = document.createElement("button");
    sub.setAttribute("class", "card-text sub-button");
    sub.innerText = "Subscribe";
    cardBody.appendChild(sub);

    root.appendChild(card);
  }
}

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

if (document.getElementById("register") != null)
  document.getElementById("register").addEventListener("submit", createAccount);

if (document.getElementById("login-form") != null)
  document.getElementById("login-form").addEventListener("submit", signin);

async function signin(e) {
  e.preventDefault();

  let email = getInputVal("login-user-name");
  let password = getInputVal("login-user-password");

  await firebase
    .auth()
    .signInWithEmailAndPassword(email, password)
    .catch(function (error) {
      // Handle Errors here.

      let errorMessage = error.message;

      if (errorMessage != null) alert(errorMessage);
      else window.location.assign("index.html");
    });
  window.location.assign("index.html");
}

async function createAccount(e) {
  e.preventDefault();

  let email = getInputVal("emailCreate");
  let password = getInputVal("passwordCreate");
  let passwordCopy = getInputVal("passwordCopy");
  if (password === passwordCopy)
    await firebase
      .auth()
      .createUserWithEmailAndPassword(email, password)
      .catch(function (error) {
        // Handle Errors here.
        let errorCode = error.code;
        let errorMessage = error.message;
        // [START_EXCLUDE]
        if (errorCode == "auth/weak-password")
          alert("The password is too weak.");
        else alert(errorMessage);

        console.log(error);
        // [END_EXCLUDE]
      });
  else window.alert("Your passwords must be identical.");
}
