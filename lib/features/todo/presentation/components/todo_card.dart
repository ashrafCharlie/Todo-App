import 'package:flutter/material.dart';
import 'package:todo_app/features/todo/domain/entities/todo_model.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todo;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final TextEditingController editTodoController;

  const TodoCard({
    super.key,
    required this.todo,
    required this.editTodoController,
    this.onEdit,
    this.onChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[50],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(value: todo.isCompleted, onChanged: onChanged),
        title: Text(
          todo.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) =>
                              TodoEditDailog(onEditTodo: onEdit,editTodoController: editTodoController,),
                        );
                      },
                      icon: Icon(Icons.edit),
                      label: Text('Edit'),
                    ),
                    ElevatedButton.icon(
                      onPressed: onDelete,
                      icon: Icon(Icons.delete),
                      label: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TodoEditDailog extends StatelessWidget {
  final TextEditingController editTodoController;
  final Function()? onEditTodo;
  const TodoEditDailog({super.key, required this.onEditTodo, required this.editTodoController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Todo"),
      content: TextField(
        controller: editTodoController,
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(onPressed: onEditTodo, child: Text("Edit")),
          ],
        ),
      ],
    );
  }
}
