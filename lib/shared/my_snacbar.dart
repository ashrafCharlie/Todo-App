import 'package:flutter/material.dart';

void mySnacBar(BuildContext context, String msg) {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
