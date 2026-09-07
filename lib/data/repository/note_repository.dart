import 'package:to_do_app/data/entity/note.dart';
import 'package:to_do_app/data/sqlite/database_helper.dart';

/// CRUD operations for the `toDos` table.
class NoteRepository {
  static const String _table = "toDos";

  Future<List<Note>> getAll() async {
    final db = await DatabaseHelper.open();
    final rows = await db.query(_table);
    return rows.map(Note.fromMap).toList();
  }

  Future<List<Note>> search(String query) async {
    final db = await DatabaseHelper.open();
    final rows = await db.query(
      _table,
      where: "name LIKE ?",
      whereArgs: ["%$query%"],
    );
    return rows.map(Note.fromMap).toList();
  }

  Future<void> add(String name) async {
    final db = await DatabaseHelper.open();
    await db.insert(_table, {"name": name});
  }

  Future<void> update(int id, String name) async {
    final db = await DatabaseHelper.open();
    await db.update(_table, {"name": name}, where: "id = ?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final db = await DatabaseHelper.open();
    await db.delete(_table, where: "id = ?", whereArgs: [id]);
  }
}
