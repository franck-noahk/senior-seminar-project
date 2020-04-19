export let uid;

firebase.auth().onAuthStateChanged(function (user) {
  //Pulling values from our db
  if (user) {
    uid = user.uid;
  } else {
    uid = null;
  }
});
