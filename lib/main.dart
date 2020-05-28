import 'package:flutter/material.dart';
import 'package:guesthouseapp/screens/welcome_screen.dart';

// import 'package:guesthouseapp/screens/newUser.dart';
void main() {
  runApp(SelectUser());
}

class SelectUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(accentColor: Colors.teal),
      theme: ThemeData(
        accentColor: Colors.deepPurpleAccent,
        primaryColor: Colors.deepPurpleAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        // '/newUserScreen': (context) => NewUser()
      },
    );
  }
}
