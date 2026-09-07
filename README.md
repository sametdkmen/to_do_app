# To Do App

Flutter ile geliştirilmiş, notların **yerel SQLite veritabanında** saklandığı ve
durum yönetiminin **BLoC (Cubit)** deseniyle yapıldığı bir yapılacaklar listesi
uygulamasıdır.

## Özellikler

- Not ekleme, düzenleme ve silme (silme işlemi SnackBar üzerinden onaylanır)
- Not adına göre canlı arama (`LIKE` sorgusu)
- Uygulama ilk açılışta paketle gelen `todo_db.sqlite` dosyasını cihaza
  kopyalar; sonraki açılışlarda mevcut veritabanını kullanır
- Notlar ana ekranda yatay kaydırılabilir gradyan kartlar olarak listelenir

## Mimari

Uygulama üç katmandan oluşur:

| Katman | Sorumluluk |
| --- | --- |
| `data/sqlite` | Veritabanı dosyasını kopyalama ve açma (`DatabaseHelper`) |
| `data/repository` | `toDos` tablosu üzerinde CRUD işlemleri (`NoteRepository`) |
| `ui/cubit` | Ekran başına bir Cubit: `HomeCubit`, `AddNoteCubit`, `NoteDetailCubit` |
| `ui/screens` | Ana ekran, not ekleme ve not detay ekranları |

Cubit'ler `MultiBlocProvider` ile `main.dart` içinde sağlanır; ekranlar
`context.read<...>()` ile repository'ye dolaylı olarak erişir, doğrudan
veritabanına dokunmaz.

## Proje yapısı

```
lib/
├── main.dart
├── data/
│   ├── entity/note.dart
│   ├── repository/note_repository.dart
│   └── sqlite/database_helper.dart
└── ui/
    ├── cubit/
    │   ├── home_cubit.dart
    │   ├── add_note_cubit.dart
    │   └── note_detail_cubit.dart
    ├── screens/
    │   ├── home_screen.dart
    │   ├── add_note_screen.dart
    │   └── note_detail_screen.dart
    └── widgets/note_editor_card.dart   # Ekle/Güncelle ekranlarının ortak kartı
assets/
├── database/todo_db.sqlite             # Başlangıç veritabanı
└── images/gradient2.png                # Kart arka planı
```

## Kullanılan paketler

- `flutter_bloc` — Cubit tabanlı durum yönetimi
- `sqflite` — SQLite erişimi
- `path` — Veritabanı dosya yolu birleştirme

## Çalıştırma

```bash
flutter pub get
flutter run
```
