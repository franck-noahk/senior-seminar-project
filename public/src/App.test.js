import React from 'react';
import { render } from '@testing-library/react';
import App from './App';
import * as firebase from 'firebase/app';

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

test('renders learn react link', () => {
	const { getByText } = render(<App />);
	const linkElement = getByText(/learn react/i);
	expect(linkElement).toBeInTheDocument();
});
