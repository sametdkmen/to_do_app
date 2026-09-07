import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repository/note_repository.dart';

class AddNoteCubit extends Cubit<void> {
  AddNoteCubit() : super(null);

  final NoteRepository _repository = NoteRepository();

  Future<void> add(String name) async {
    await _repository.add(name);
  }
}
