import {
    getInputVal
} from "./getInputValue.js";
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


function verify() {

    console.log(window.location.pathname);
    console.log(getAdminPriv());
    if (uid && getAdminPriv()) {
        //TODO: they are admin
        console.log("Is Admin");
    } else if (uid) {
        console.log("is user");
        //TODO: They are logedin
        if (window.location.pathname == 'my-club.html' || window.location.pathname == 'create-events.html' || window.location.pathname == 'my-club.html') {
            window.location.href = "https://senior-seminar-project-dev.web.app/";
        }

        let toRemove = document.getElementsByClassName("admin");
        for (var i = toRemove.length - 1; i >= 0; --i) {
            toRemove[i].remove();
        }


    } else {
        console.log("normy");
        //TODO: normal user
        if (window.location.pathname == 'my-club.html' || window.location.pathname == 'create-events.html' || window.location.pathname == 'my-club.html') {
            window.location.href = "https://senior-seminar-project-dev.web.app/login.html";
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


function getAllEvents() {
    //Function to get all of the events
    /*
    location in DB:
    /events
  
    */
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

function signin(e) {
    e.preventDefault();

    let email = getInputVal("login-user-name");
    let password = getInputVal("login-user-password");

    firebase
        .auth()
        .signInWithEmailAndPassword(email, password)
        .catch(function (error) {
            // Handle Errors here.

            let errorMessage = error.message;

            if (errorMessage != null) alert(errorMessage);
            else window.location.replace("index.html");
        });
    window.location.href = "http://127.0.0.1:5500/public/index.html"
}


function createAccount(e) {
    e.preventDefault();

    let email = getInputVal("emailCreate");
    let password = getInputVal("passwordCreate");
    let passwordCopy = getInputVal("passwordCopy");
    if (password === passwordCopy)
        firebase
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