import 'package:flutter/material.dart';
import 'package:todo_app/features/auth/presentation/components/continue_with_google_button.dart';
import 'package:todo_app/features/auth/presentation/components/custom_divider.dart';
import 'package:todo_app/features/auth/presentation/components/my_button.dart';
import 'package:todo_app/features/auth/presentation/components/my_textfield.dart';

class SignupScreen extends StatefulWidget {
  final void Function()? togglepages;
  const SignupScreen({super.key, this.togglepages});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_open, size: 150),
            Text(
              "S i g n  U p  H e r e",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            const SizedBox(height: 20.0),

            MyTextfield(controller: nameController, hintText: "Name"),
            const SizedBox(height: 15.0),

            MyTextfield(controller: emailController, hintText: "Email"),
            const SizedBox(height: 15.0),

            MyTextfield(
              controller: pwController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 15.0),

            MyTextfield(
              controller: confirmPwController,
              hintText: "Confirm Password",
              obscureText: true,
            ),
            const SizedBox(height: 25.0),

            MyButton(buttonText: "Sign Up", onTap: () {}),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an Account? "),
                GestureDetector(
                  onTap: widget.togglepages,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            CustomDivider("Or"),

            ContinueWithGoogle(onTap: () {}, text: "Continue With Google"),
          ],
        ),
      ),
    );
  }
}
