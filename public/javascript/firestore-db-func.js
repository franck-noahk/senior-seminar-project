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
