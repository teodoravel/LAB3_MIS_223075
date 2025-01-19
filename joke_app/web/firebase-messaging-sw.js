importScripts(
  "https://www.gstatic.com/firebasejs/9.19.0/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/9.19.0/firebase-messaging-compat.js"
);

// Initialize Firebase app using web config:
firebase.initializeApp({
  apiKey: "YOUR_API_KEY_HERE",
  authDomain: "YOUR_APP.firebaseapp.com",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_APP.appspot.com",
  messagingSenderId: "YOUR_SENDER_ID",
  appId: "YOUR_APP_ID",
});

// Retrieve an instance of Firebase Messaging to handle background messages:
const messaging = firebase.messaging();

// (Optional) can override messaging.onBackgroundMessage here if needed.
