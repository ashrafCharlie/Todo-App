import 'package:flutter/material.dart';

class ResetpasswordBox extends StatelessWidget {
  final void Function()? onPressed;
  final TextEditingController resetEmailController;
  const ResetpasswordBox({super.key, required this.resetEmailController,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text("Reset Your Password"),
            actions: [
              TextField(
                controller: resetEmailController,
                decoration: InputDecoration(
                  hintText: "Enter Your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("cancel"),
                  ),
                  TextButton(
                    onPressed: onPressed,
                    child: Text("Send Reset Link"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      child: Text("Forget password?"),
    );
  }
}
