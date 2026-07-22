import 'package:flutter/material.dart';

class DeleteAccountdailog extends StatelessWidget {
 final void Function()? onPressed;
  const DeleteAccountdailog({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text("Do You want to delete Your account?"),
            actions: [
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
                    onPressed: onPressed,
                    child: Text("Confirm"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      child: Row(
        children: [
          Icon(Icons.delete),
          Text("Delete Account"),
        ],
      ),
    );
  }
}