import 'package:flutter/material.dart';

// Firebase core initialization
import 'package:firebase_core/firebase_core.dart';

// If using the file generated by `flutterfire configure`:
import 'firebase_options.dart';

// Import Firebase Messaging for push notifications
import 'package:firebase_messaging/firebase_messaging.dart';

// Example start screen
import 'package:joke_app/screens/types_list_screen.dart';

/// A top-level function to handle background messages on Android/iOS.
///
/// This won't be used on the web unless we specifically set up a service
/// worker (firebase-messaging-sw.js).
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handle the background message, e.g., parse data/payload.
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Firebase for all platforms (including the web).
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 2. (Optional) Handle background push on iOS/Android
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 3. Request notifications permission (this is especially important on iOS).
  //    On the web, this will prompt the user if you also have
  //    a firebase-messaging-sw.js file in /web.
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission();
  print('User granted permission: ${settings.authorizationStatus}');

  // 4. (Optional) Get the token for push messaging
  //    On Android/iOS, this is the device token.
  //    On web, this only works if we also have the service worker configured.
  String? token = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $token');

  // 5. Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green,
          secondary: Colors.orange,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade600,
        ),
      ),
      home: const TypesListScreen(),
    );
  }
}
