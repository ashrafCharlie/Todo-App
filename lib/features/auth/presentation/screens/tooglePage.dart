import 'package:flutter/material.dart';
import 'package:todo_app/features/auth/presentation/screens/login_screen.dart';
import 'package:todo_app/features/auth/presentation/screens/signup_sceen.dart';

class Tooglepage extends StatefulWidget {
  const Tooglepage({super.key});

  @override
  State<Tooglepage> createState() => _TooglepageState();
}

class _TooglepageState extends State<Tooglepage> {
  bool isLogedIn = true;
  void togglePage() {
      setState(() {
        isLogedIn = !isLogedIn;
      });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogedIn) {
      return LoginScreen(togglepages: togglePage,);
    } else {
      return SignupScreen(togglepages: togglePage,);
    }
  }
}
