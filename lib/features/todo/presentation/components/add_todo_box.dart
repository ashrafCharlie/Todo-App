import 'package:flutter/material.dart';

class AddTodoBox extends StatelessWidget {
  final TextEditingController todoController;
  final void Function()? onPressed;
  const AddTodoBox({super.key, required this.todoController,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add a New Todo!"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: todoController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: onPressed,
                    child: Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[400],
          borderRadius: BorderRadius.circular(15.0),
        ),
        height: 100,
        width: 150,
        child: Center(
          child: Text(
            "Add Todo",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
