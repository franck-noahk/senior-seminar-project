import React from 'react';
import logo from './logo.svg';
import './App.css';

import * as firebase from 'firebase';
function App(){
	var provider = new firebase.auth.OAuthProvider('microsoft.com');
	provider.setCustomParameters({
		// Force re-consent.
		prompt     : 'consent',
		// Target specific email with login hint.
		login_hint : 'user@my.uu.edu',
	});
	provider.setCustomParameters({
		tenant : '2620262b-515e-4e57-81c2-c600c946f102',
	});
	firebase
		.auth()
		.signInWithPopup(provider)
		.then(function(result){
			// User is signed in.
			// IdP data available in result.additionalUserInfo.profile.
			// OAuth access token can also be retrieved:
			// result.credential.accessToken
			// OAuth ID token can also be retrieved:
			// result.credential.idToken

			console.log('resutl' + result);
		})
		.catch(function(error){
			console.log('catch err.' + error);
		});

	return (
		<div className='App'>
			<header className='App-header'>
				<img src={logo} className='App-logo' alt='logo' />
				<p>
					Edit <code>src/App.js</code> and save to reload.
				</p>
				<a
					className='App-link'
					href='https://reactjs.org'
					target='_blank'
					rel='noopener noreferrer'
				>
					Learn React
				</a>
			</header>
		</div>
	);
}

export default App;
