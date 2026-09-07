/// A single to-do note stored in the local SQLite database.
class Note {
  final int id;
  final String name;

  const Note({required this.id, required this.name});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(id: map["id"] as int, name: map["name"] as String);
  }
}
