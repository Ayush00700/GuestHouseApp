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
      theme: ThemeData.dark().copyWith(accentColor: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        // '/newUserScreen': (context) => NewUser()
      },
    );
  }
}
