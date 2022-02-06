importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyBst2CWEUfNuaHh9OA3XW3JdZ3vpLGPMcg",
  authDomain: "dart-job.firebaseapp.com",
  projectId: "dart-job",
  storageBucket: "dart-job.appspot.com",
  messagingSenderId: "174403318860",
  appId: "1:174403318860:web:d8f54a5b305667d08230e9",
  measurementId: "G-BYS0GKHDNS"
});

// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});