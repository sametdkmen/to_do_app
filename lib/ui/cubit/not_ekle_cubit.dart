import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repo/notlar_repository.dart';

class NotEkleCubit extends Cubit<void> {
  NotEkleCubit():super(0);

  var notrepo = NotlarRepository();

  Future<void> ekle (String name) async {
    await notrepo.ekle(name);
  }
}