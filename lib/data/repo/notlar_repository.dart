import '../entity/notlar.dart';
import '../sqlite/veritabani.dart';

class NotlarRepository {

  Future<List<Notlar>> notlariGetir() async {
    var db = await Veritabani.veritabaniErisimi();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM toDos");

    return List.generate(
        maps.length, (index) { //indexe göre veriler gelecek 0, 1 diye
      var satir = maps [index];
      return Notlar(id: satir["id"], name: satir["name"]);
    });
  }

  Future<void> ekle(String name) async {
    var db = await Veritabani.veritabaniErisimi(); //veritabanına eriştik.
    var bilgiler = Map<String, dynamic>(); //map yapısı ile key value alacak şekilde altyapı oluşturuyoruz.
    bilgiler["name"] = name;
    await db.insert("toDos", bilgiler); //
  }

  Future<void> sil(int id) async {
    var db = await Veritabani.veritabaniErisimi();
    await db.delete("toDos", where: "id=?", whereArgs: [id]);
  }

  Future<List<Notlar>> ara(String aramaSonucu) async {
    var db = await Veritabani
        .veritabaniErisimi(); //sqlite da like keywordu kullanıp isteğimize göre harf içeren arama yapmıştık onun gibi burada da kullanıcaz.
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM toDos WHERE name like '%$aramaSonucu%'");

    return List.generate(maps.length, (
        index) { //arama sonucu oluşan sorguyu listeye çevirip döndürüyoruz.
      var satir = maps[index];
      return Notlar(id: satir["id"], name: satir["name"]);
    });
  }
  
  Future<void> guncelle (int id, String name) async {
    var db = await Veritabani.veritabaniErisimi();
    var bilgiler = Map<String,dynamic>();

    bilgiler["name"] = name;

    await db.update("toDos", bilgiler, where: "id=?",whereArgs: [id]);
  }

}