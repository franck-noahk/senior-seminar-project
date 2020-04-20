import { uid } from "./user.js";
var db = firebase.firestore();

export function getAdminPriv() {
  if (uid != null) {
    let docref = db.collection("users").document(uid);
    docref.get().then(function (doc) {
      let toReturn = doc.data().isAdmin;
      return toReturn;
    });
  } else {
    return false;
  }
}

export function getAllEvents() {
  //Function to get all of the events
  /*
  location in DB:
  /events

  */
}

export function getAllUserInfo() {
  //Function to get all of the user's information
  /*
  location in DB:
  /users/{uid}

  */
}

export function getRSVPData(eventUid) {
  //Function to get all of the RSVP data
  //eventUid is a string 
  /*
    location in DB:
    /events/{event}/response/rsvp

    on the document rsvp each user's uid is there and says "isComming" or "isNotComming", and if there UID isn't on document they haven't confirmed or denied

    */
}

export function getOrgData(orgUid) {
  //function to get all of the orginization's data
  //orgUid is considered a string 
}