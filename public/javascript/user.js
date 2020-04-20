export let uid;

firebase.auth().onAuthStateChanged(function (user) {
  //Pulling values from our db
  if (user) {
    uid = user.uid;
    console.log(uid);
  } else {
    uid = null;
    console.log(uid);
  }
});