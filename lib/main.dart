import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/data/repo/firebase_auth_repo.dart';
import 'package:todo_app/features/auth/domain/repo/auth_repo.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:todo_app/features/auth/presentation/screens/tooglePage.dart';
import 'package:todo_app/features/todo/data/repo/firebase_todo_repo.dart';
import 'package:todo_app/features/todo/domain/repo/todo_repo.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_event.dart';
import 'package:todo_app/features/todo/presentation/screens/todo_home_screen.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/shared/my_circle_progress_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  TodoApp({super.key});
  final AuthRepo firebaseAuthRepo = FirebaseAuthRepo();
  final TodoRepo todoRepo = FirebaseTodoRepo();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(firebaseAuthRepo)..checkAuth(),
        ),
        BlocProvider(create: (context) => TodoBloc(todoRepo)..add(TodoLoadEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
          },
          builder: (context, state) {
            if (state is Authenticate) {
              return TodoPage();
            } else if (state is AuthLoading) {
              return Center(child: MyCircleProgressIndicator());
            } else {
              return Tooglepage();
            }
          },
        ),
      ),
    );
  }
}
