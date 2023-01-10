import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repo/notlar_repository.dart';

class NotDetayCubit extends Cubit<void> {
  NotDetayCubit():super(0);

  var notrepo = NotlarRepository();

  Future<void> guncelle (int id, String name )async {
    await notrepo.guncelle(id, name);
  }
}