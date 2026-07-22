import 'package:flutter/material.dart';

class MyCircleProgressIndicator extends StatelessWidget {
  const MyCircleProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.pink,
          strokeWidth: 2,
        ),
      ),
    );
  }
}