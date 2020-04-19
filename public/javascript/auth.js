import { getInputVal } from "./getInputValue.js";

// let firebaseConfig = {
//     apiKey: "AIzaSyBUdXfY8lmHANQTx9RuBu5rBym-aij1JoY",
//     authDomain: "senior-seminar-project-dev.firebaseapp.com",
//     databaseURL: "https://senior-seminar-project-dev.firebaseio.com",
//     projectId: "senior-seminar-project-dev",
//     storageBucket: "senior-seminar-project-dev.appspot.com",
//     messagingSenderId: "320382771706",
//     appId: "1:320382771706:web:c8b53363d4f6152cc80443",
//     measurementId: "G-P8LZ1XEWFJ"
// };

// // Initialize Firebase
// firebase.initializeApp(firebaseConfig);
// // firebase.analytics();
// firebase.performance();
// firebase.firestore();

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
}
var db = firebase.firestore();

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
