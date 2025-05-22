import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyHomeScreen extends StatelessWidget {
  MyHomeScreen({super.key});
//* Create - a note and store in supabase

  TextEditingController textController = TextEditingController();
  void addNewNote(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                //save button
                TextButton(
                  child: Text("save"),
                  onPressed: () {
                    saveNote();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  void saveNote() async {
    await Supabase.instance.client
        .from("testing table")
        .insert({"body": textController.text});
  }

//* Read - notes from supabase in our app

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addNewNote(context);
          },
          child: Icon(Icons.add)),
    );
  }
}
