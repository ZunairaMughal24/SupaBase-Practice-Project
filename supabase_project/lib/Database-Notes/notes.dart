
//Model class
class Note {
  int? id;
  String? content;
  Note({this.id, this.content});

/*
map <---> note
{
"id"=1,
"content"="Hello"
}
 Note{
"id"=1,
"content"="Hello"
}

fromMap() -	Map → Note object (used in reading)
toMap() -	Note object → Map (used in writing)

*/

//*map <---> note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["id"] as int,
      content: map["content"]?? "" as String,
    );
  }
//* Note <---> map
  Map<String, dynamic> toMap() {
    return {
      "content": content,
    };
  }
}
