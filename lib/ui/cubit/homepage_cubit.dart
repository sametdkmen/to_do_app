import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repo/notlar_repository.dart';
import '../../data/entity/notlar.dart';

class HomepageCubit extends Cubit<List<Notlar>> {
  HomepageCubit(): super(<Notlar>[]);

  var notrepo = NotlarRepository();

  Future<void> notlariGetir() async {
    var liste = await notrepo.notlariGetir();
    emit(liste);
  }

  Future<void> sil(int name) async{
    await notrepo.sil(name);
    await notlariGetir();
  }

  Future <void> ara(String aramaSonucu) async {
    var liste = await notrepo.ara(aramaSonucu);
    emit(liste);
  }
}