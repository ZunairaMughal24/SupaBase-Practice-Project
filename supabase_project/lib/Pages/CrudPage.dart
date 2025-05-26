import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class CrudScreen extends StatelessWidget {
  CrudScreen({super.key});
//* Create - a note and store in supabase

  TextEditingController textController = TextEditingController();
  void addNewNote(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 167, 243, 253),
              content: TextField(
                controller: textController,
              ),
              actions: [
                //save button
                TextButton(
                  child: const Text("save"),
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
  final _noteStream = Supabase.instance.client
      .from("testing table")
      .stream(primaryKey: (["id"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              addNewNote(context);
            },
            backgroundColor: Colors.cyan,
            child: const Icon(Icons.add)),
        body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: _noteStream,
            builder: (context, snapshot) {
              //in case of loading
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              //loaded
              final notes = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: notes?.length,
                  itemBuilder: (BuildContext context, int index) {
                    //get individual notes
                    final note = notes?[index];
                    //get notes by column
                    final noteText = note?["body"];
                    // return as ui
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 50,
                          width: 180,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.cyan,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(child: Text(noteText))),
                    );
                  },
                ),
              );
            }));
  }
}
