importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');


  const firebaseConfig = {
      apiKey: "AIzaSyCM17_z7KV6QHjUNHRtnUO4x7jnHEF4UiI",
      authDomain: "spectrumspeak2024.firebaseapp.com",
      projectId: "spectrumspeak2024",
      storageBucket: "spectrumspeak2024.appspot.com",
      messagingSenderId: "915405090420",
      appId: "1:915405090420:web:aaf0bf6d56c116c54ceb21",
      measurementId: "G-NXP6YFRRT6"
    };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();


  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });