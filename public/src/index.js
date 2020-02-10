import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';
import firebase from 'firebase/app';
// import { connect } from 'react-firebase';
let config = {
	apiKey            : 'AIzaSyBUdXfY8lmHANQTx9RuBu5rBym-aij1JoY',
	authDomain        : 'senior-seminar-project-dev.firebaseapp.com',
	databaseURL       : 'https://senior-seminar-project-dev.firebaseio.com',
	projectId         : 'senior-seminar-project-dev',
	storageBucket     : 'senior-seminar-project-dev.appspot.com',
	messagingSenderId : '320382771706',
	appId             : '1:320382771706:web:c8b53363d4f6152cc80443',
};
firebase.initializeApp(config);
ReactDOM.render(<App />, document.getElementById('root'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
