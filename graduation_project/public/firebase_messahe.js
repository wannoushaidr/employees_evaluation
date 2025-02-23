// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAQzVQ1XmLhvPWYtORJ8Yhvxvl2ybk0oqM",
  authDomain: "clothes-store-main.firebaseapp.com",
  databaseURL: "https://clothes-store-main-default-rtdb.firebaseio.com",
  projectId: "clothes-store-main",
  storageBucket: "clothes-store-main.firebasestorage.app",
  messagingSenderId: "89908349367",
  appId: "1:89908349367:web:b10450ce5b65ede8884032",
  measurementId: "G-125XL42HNF"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);