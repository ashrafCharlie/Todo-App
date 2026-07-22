import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_app/features/todo/domain/entities/todo_model.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_event.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_state.dart';
import 'package:todo_app/features/todo/presentation/components/add_todo_box.dart';
import 'package:todo_app/features/todo/presentation/components/my_drawer.dart';
import 'package:todo_app/features/todo/presentation/components/todo_card.dart';
import 'package:todo_app/shared/my_snacbar.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoErrorState) {
          mySnacBar(context, state.errorMsg);
        }
        if (state is TodoSuccessState) {
          mySnacBar(context, "Todo add success");
          todoController.clear();
        }
      },
      child: Scaffold(
        floatingActionButton: AddTodoBox(
          todoController: todoController,
          onPressed: () {
            if (todoController.text.isEmpty) {
              return mySnacBar(context, "Must add a todo!");
            }
            context.read<TodoBloc>().add(
              TodoAddEvent(todoTitle: todoController.text),
            );
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[100],
        appBar: AppBar(backgroundColor: Colors.transparent),
        drawer: MyDrawer(
          onPressed: () {
            context.read<AuthCubit>().logout();
          },
          onPressedDelete: () {
            context.read<AuthCubit>().deleteAccount();
            Navigator.pop(context);
          },
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                  strokeWidth: 3,
                ),
              );
            } else if (state is TodoLoadedState) {
              final todos = state.todos;
              if (todos.isEmpty) {
                return Center(child: Text("No todo Found!!"));
              }

              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return TodoCard(
                    todo: todo,
                    onChanged: (value) {
                      context.read<TodoBloc>().add(TodoUpdateEvent(todo: todo.copyWith(
                        isCompleted: value!,
                      )));
                    },
                  );
                },
              );
            }
            return Center(child: Text("welcome Home!"));
          },
        ),
      ),
    );
  }
}
