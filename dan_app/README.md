# dan_app

##### Run code generator
flutter packages pub run build_runner build

##### Publish web app to Firebase Hosting

###### Local setup
npm install -g firebase-tools
firebase login

###### Build and publish
flutter build web
firebase deploy

###### Details
https://medium.com/flutter/must-try-use-firebase-to-host-your-flutter-app-on-the-web-852ee533a469
