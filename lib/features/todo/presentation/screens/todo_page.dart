import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_app/features/todo/presentation/components/my_drawer.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  void logout() {
    final authCubit = context.read<AuthCubit>();
    authCubit.logout();
  }

  void deleteAccount() {
    context.read<AuthCubit>().deleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(backgroundColor: Colors.transparent),
      drawer: MyDrawer(
        onPressed: () => logout(),
        onPressedDelete: () {
          deleteAccount();
          Navigator.pop(context);
        },
      ),
      body: Center(child: Text("welcome Home!")),
    );
  }
}
