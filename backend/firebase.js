const firebase = require("firebase/compat/app");
require("firebase/compat/storage");
require('dotenv').config();

const apiKey = process.env.FIREBASE_API_KEY;

const firebaseConfig = {
  apiKey: apiKey,
  authDomain: "thozhil-mobile-app.firebaseapp.com",
  projectId: "thozhil-mobile-app",
  storageBucket: "thozhil-mobile-app.appspot.com",
  messagingSenderId: "210682683783",
  appId: "1:210682683783:web:0804b8c4e61077d2057322",
  measurementId: "G-BBXN1TZ9GY"
};

const app = firebase.initializeApp(firebaseConfig);
const storageApp = firebase.storage().ref()

module.exports = storageApp;