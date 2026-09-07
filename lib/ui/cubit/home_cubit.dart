import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/note.dart';
import 'package:to_do_app/data/repository/note_repository.dart';

/// Holds the list of notes shown on the home screen.
class HomeCubit extends Cubit<List<Note>> {
  HomeCubit() : super(const <Note>[]);

  final NoteRepository _repository = NoteRepository();

  Future<void> loadNotes() async {
    emit(await _repository.getAll());
  }

  Future<void> search(String query) async {
    emit(await _repository.search(query));
  }

  Future<void> delete(int id) async {
    await _repository.delete(id);
    await loadNotes();
  }
}
