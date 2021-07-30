import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FlashChat());
}

class FlashChat extends StatefulWidget {
  @override
  _FlashChatState createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return ErrorScreen();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            initialRoute: WelcomeScreen.routeID,
            routes: {
              WelcomeScreen.routeID: (context) => WelcomeScreen(),
              LoginScreen.routeID: (context) => LoginScreen(),
              RegistrationScreen.routeID: (context) => RegistrationScreen(),
              ChatScreen.routeID: (context) => ChatScreen(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return ErrorScreen();
      },
    );
  }
}
