import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repository/note_repository.dart';

class NoteDetailCubit extends Cubit<void> {
  NoteDetailCubit() : super(null);

  final NoteRepository _repository = NoteRepository();

  Future<void> update(int id, String name) async {
    await _repository.update(id, name);
  }
}
