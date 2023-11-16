// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyA4iIgxF2yPha4AE7TwM8acjTVKkj2v4uc",
    authDomain: "smartparking-d063e.firebaseapp.com",
    databaseURL: "https://smartparking-d063e-default-rtdb.firebaseio.com",
    projectId: "smartparking-d063e",
    storageBucket: "smartparking-d063e.appspot.com",
    messagingSenderId: "367859712693",
    appId: "1:367859712693:web:67a0d8695466d075aef4fc"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const db = getFirestore(app);