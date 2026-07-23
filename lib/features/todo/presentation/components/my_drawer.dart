
import 'package:flutter/material.dart';
import 'package:todo_app/features/todo/presentation/components/delete_accountdailog.dart';

class MyDrawer extends StatelessWidget {
 final void Function()? onPressed;
 final void Function()? onPressedDelete;
   const MyDrawer({super.key,  this.onPressed, this.onPressedDelete});

  @override
  Widget build(BuildContext context) {
  return  Drawer(
        backgroundColor: Colors.blueGrey[200],

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: DeleteAccountdailog(onPressed: onPressedDelete,),
            ),
             ListTile(
              title: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(Icons.logout),
                label: Text("Logout"),
              ),
                         ),
          ],
        ),
      );
  }
}