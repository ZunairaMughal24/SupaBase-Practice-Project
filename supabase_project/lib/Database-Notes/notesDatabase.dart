import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_project/Database-Notes/notes.dart';

class Database {
  final database = Supabase.instance.client.from('testing table');
  //Create
  Future createNote(Note newNote) async {
    await database.insert(newNote.toMap());
  }

//Read
//*The stream emits events over time, below the complete explanation....
/*
Each event is actually a List of maps (each map is a row/item from the database).

You call that event data in your .map((data) => ...) because you’re giving it a name to work with.

Then, on that List called data, you do another .map(...) to go through each map (each item in the list)
and convert it into your model object (e.g., Note.fromMap).

Finally, you convert all those model objects back into a List with .toList().

So it’s like:
Stream emits List of maps → For each event (called data), 
transform each map inside it to a model object → Return a List of models.

*/
//* Convert each map from stream to a Note object
final stream = Supabase.instance.client
      .from("testing table")
      .stream(primaryKey: ["id"]).map(
          (data) => data.map((noteMap) => Note.fromMap(noteMap)).toList());
  // Stream<List<Note>> get stream => Supabase.instance.client
  //         .from('testing table')
  //         .stream(primaryKey: ['id']).map((data) {
  //       print("📥 Stream Data: $data");
  //       return data.map((noteMap) => Note.fromMap(noteMap)).toList();
  //     });
  //Update
  Future updateNote(Note oldNote, String newContent) async {
    await database.update({"content": newContent}).eq("id", oldNote.id!);
  }

  //Delete
  //*eq("id", note.id!); explanation below;
  /*
.eq(...)
→ Means: “equal to”
→ It’s used to filter the data in Supabase (like a WHERE clause in SQL).

"id"
→ This is the column name in the Supabase table.

oldNote.id!
→ This gets the ID value from the oldNote object.
→ The ! means: “I’m sure this is not null.”

  */
  Future deleteNote(Note note) async {
    await database.delete().eq("id", note.id!);
  }
}
