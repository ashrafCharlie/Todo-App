import 'package:flutter/material.dart';
import 'package:todo_app/features/todo/domain/entities/todo_model.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback? onTap;
  final ValueChanged<bool?>? onChanged;

  const TodoCard({
    super.key,
    required this.todo,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: onChanged,
        ),

        title: Center(
          child: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
        ),

      ),
    );
  }
}