# E Bulletin

This repository uses [Firebase](https://firebase.google.com/) to handel the backend, and [Flutter](https://flutter.dev) to compile code to iOS & Android.

## Getting Started

__If you want to take this as a starting point__
 - Install flutter [Follow these steps](https://flutter.dev/docs/get-started/install)
 - After you fork the repo continue by removing /.firebaserc and /firebase.json 
 - Install Firebase Command Line Tools through npm [Detailed instructions](https://firebase.google.com/docs/cli#mac-linux-npm)
 - In the commandline / terminal navigate to this repository
 - run ``` firebase login ``` and go through the steps to sign in
 - run ``` Firebase init ``` You need to select hosting, firestore, & functions
 - Then select make new project
 - This project uses default locations for Hosting, and Firestore, & we wrote our functions in Javascript, but Typescript is prefered.
 - run ``` firebase Deploy``` to push everything up to the cloud and your ready to go. 

## Resources that are usefull

### Flutter

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Flutter for Visual Studio Code](https://flutter.dev/docs/development/tools/vs-code)
- [Bracket Extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer-2)

### Firebase -- Firestore

 - [Structure Data](https://firebase.google.com/docs/firestore/manage-data/structure-data) 
 - [Adding data](https://firebase.google.com/docs/firestore/quickstart#add_data)
 - [Getting data once](https://firebase.google.com/docs/firestore/query-data/get-data)
 - [Real Time Updates](https://firebase.google.com/docs/firestore/query-data/listen)

### How Flutter Lib is layed out
.
├── backend
│   └── firebase.dart
├── constants.dart
├── main.dart
├── models
│   └── user.dart
└── widgets
    ├── layout
    │   ├── SettingsLayout.dart
    │   ├── UpCommingEventsList.dart
    │   └── loading.dart
    └── pages
        ├── SignIn.dart
        ├── eventDetailPage.dart
        ├── makeEvent.dart
        └── register.dart
		
#### Firestore data layout

├── events
│   └── ex_event
│   	├── event_time:DateTime
│   	├── location:string
│   	├── name:string
│       └────response (SubCollection of each event)
│            └── rsvp
│               └── {Users_uid: String}: isComming | isNotComming | if null default to isNotComming
├── orginazations
│   └── ex_org
│   	├── adminUsers:{users_uuid}
│   	├── facultySponsor:String
│   	├── facultySponsorEmail:String
│   	├── name:string
│       └── full_name: String
└── users
     └── ex_usr
    	├── displayName:string
    	├── email:string
    	├── following:String array
    	├── isAdmin:bool
    	└── isAdminOf:String

### Firebase -- Functions

 - [Call function on Database change](https://firebase.google.com/docs/functions/firestore-events)
 - [Trigger based on new user or deleting user](https://firebase.google.com/docs/functions/auth-events)
 - [Write Functions in Typescript](https://firebase.google.com/docs/functions/typescript)
 - [Setting up Enviornment variables for API Keys](https://firebase.google.com/docs/functions/config-env)
