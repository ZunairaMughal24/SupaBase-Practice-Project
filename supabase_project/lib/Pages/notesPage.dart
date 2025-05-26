import 'package:flutter/material.dart';
import 'package:supabase_project/Database-Notes/notes.dart';
import 'package:supabase_project/Database-Notes/notesDatabase.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final noteDatabase = Database();
//text Controller
  TextEditingController noteController = TextEditingController();
  //user wants to add note
  void addNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add note"),
              content: TextField(
                controller: noteController,
              ),
              actions: [
                //save button
                TextButton(
                    onPressed: () {
                      //create a new note
                      final newNote = Note(content: noteController.text);
                      //save in the database
                      noteDatabase.createNote(newNote);

                      Navigator.pop(context);
                      noteController.clear();
                    },
                    child: const Text("save")),
                //cancel button
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      noteController.clear();
                    },
                    child: const Text("cancel")),
              ],
            ));
  }

  //user want to update note
  void updateNote(Note note) {
    noteController.text = note.content!;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Update Note"),
              content: TextField(
                controller: noteController,
              ),
              actions: [
                //save button
                TextButton(
                    onPressed: () {
                      //save in the database
                      noteDatabase.updateNote(note, noteController.text);

                      Navigator.pop(context);
                      noteController.clear();
                    },
                    child: const Text("update")),
                //cancel button
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      noteController.clear();
                    },
                    child: const Text("cancel")),
              ],
            ));
  }

  //user want to delete note
  void deleteNote(Note note) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Delete note?"),
              actions: [
                //save button
                TextButton(
                    onPressed: () {
                      //delete note
                      noteDatabase.deleteNote(note);

                      Navigator.pop(context);
                      noteController.clear();
                    },
                    child: const Text("Delete")),
                //cancel button
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      noteController.clear();
                    },
                    child: const Text("cancel")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote();
        },
        child: const Icon(Icons.add),
      ),
      //to read notes we are going to ue a streamBuilder
      body: StreamBuilder(
        //listen to this stream
        stream: noteDatabase.stream,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          //loaded

          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              //get each note
              final note = notes[index];
              // Ui
              return ListTile(
                  // title: Text(note.content),
                  title:
                      // to prevent null crash
                      Text(note.content ?? "no content"),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        //update button
                        IconButton(
                            onPressed: () {
                              updateNote(note);
                            },
                            icon: const Icon(Icons.edit)),
                        //delete button
                        IconButton(
                            onPressed: () {
                              deleteNote(note);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
