import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/presentation/components/continue_with_google_button.dart';
import 'package:todo_app/features/auth/presentation/components/custom_divider.dart';
import 'package:todo_app/features/auth/presentation/components/my_button.dart';
import 'package:todo_app/shared/my_snacbar.dart';
import 'package:todo_app/features/auth/presentation/components/my_textfield.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_state.dart';

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

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  void register() {
    final String email = emailController.text.trim();
    final String pw = pwController.text.trim();
    final String cpw = confirmPwController.text.trim();
    final authCubit = context.read<AuthCubit>();
    if (email.isNotEmpty && pw.isNotEmpty && cpw.isNotEmpty) {
      if (cpw == pw) {
        authCubit.register(email, pw);
      } else {
        mySnacBar(context, "Confirm Password doesn't match");
      }
    } else {
      mySnacBar(context, "Fields are empty!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            mySnacBar(context, state.errorMsg);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.create, size: 200, color: Colors.blueAccent),
              Text(
                "Create an account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              const SizedBox(height: 20.0),

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

          
              MyButton(
                    buttonText: "Sign Up",
                    onTap: () {
                      register();
                    },
                  ),
              
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
      ),
    );
  }
}
