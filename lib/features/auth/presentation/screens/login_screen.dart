import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/presentation/components/continue_with_google_button.dart';
import 'package:todo_app/features/auth/presentation/components/custom_divider.dart';
import 'package:todo_app/features/auth/presentation/components/my_button.dart';
import 'package:todo_app/features/auth/presentation/components/resetPassword_box.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:todo_app/shared/my_snacbar.dart';
import 'package:todo_app/features/auth/presentation/components/my_textfield.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? togglepages;
  const LoginScreen({super.key, this.togglepages});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final authcubit = context.read<AuthCubit>();
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

  void forgetPassword() async {
    final resetEmail = resetEmailController.text.trim();
    if (resetEmail.isNotEmpty) {
      final msg = await authcubit.forgetPassword(resetEmail);
      if (msg == "Reset link send succesful") {
        mySnacBar(context, msg);
        resetEmailController.clear();
      } else {
        mySnacBar(context, msg);
      }
    } else {
      mySnacBar(context, "Enter an email...");
    }
  }

  void login() {
    final email = emailController.text.trim();
    final password = pwController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      authcubit.login(email, password);
    } else {
      mySnacBar(context, "Fields are empty..!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, size: 150, color: Colors.blue),
              SizedBox(height: 10),
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
                  child: ResetpasswordBox(
                    resetEmailController: resetEmailController,
                    onPressed: () {
                      forgetPassword();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              MyButton(
                buttonText: "L o g i n",
                onTap: () {
                  login();
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
                  context.read<AuthCubit>().googleLogin();
                },
                text: "Continue with Google",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
