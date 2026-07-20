import 'package:flutter/material.dart';
import 'package:todo_app/features/auth/presentation/components/continue_with_google_button.dart';
import 'package:todo_app/features/auth/presentation/components/custom_divider.dart';
import 'package:todo_app/features/auth/presentation/components/my_button.dart';
import 'package:todo_app/features/auth/presentation/components/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? togglepages;
  const LoginScreen({super.key, this.togglepages});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController resetEmailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    resetEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, size: 200,color: Colors.blue,),
              SizedBox(height: 10,),
              Text(
                "Hey, Welcome Back",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              const SizedBox(height: 20.0),
          
              MyTextfield(controller: emailController, hintText: "Email"),
              const SizedBox(height: 20.0),
              MyTextfield(
                controller: pwController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 10.0),
              Align(
                alignment: AlignmentGeometry.centerEnd,
                child: Padding(
                  padding: EdgeInsetsGeometry.only(right: 25.0),
                  child: GestureDetector(
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
                                  onPressed: () async {
                                  },
                                  child: Text("Send Reset Link"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text("Forget password?"),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
             MyButton(
                    buttonText: "L o g i n",
                    onTap: () {
                    },
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have any Account? "),
                  GestureDetector(
                    onTap: widget.togglepages,
                    child: Text(
                      "Sign Up",
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
              ContinueWithGoogle(
                    onTap: () {
                    },
                    text: "Continue with Google",
                  ),
            ],
          ),
        ),
      );
  }
}