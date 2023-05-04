// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class SqlDB {
//   static Database? _db;
//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await initialDB();
//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   initialDB() async {
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'reyath.db');
//     Database mydb = await openDatabase(path, onCreate: _oncreate);
//     return mydb;
//   }

//   _oncreate(Database db, int version) async {
//     db.execute('''
// CREATE TABLE "notes"{
// id INTEGER AUTOINCREMENT NOT NULL PRIMARY KEY,
// notes TEXT NOT NULL
// }
// ''');
//   }

//   insertDb(String sql) async {
//     Database? mydb = await db;
//     return await mydb!.rawInsert(sql);
//   }
//    readtDb(String sql) async {
//     Database? mydb = await db;
//     return await mydb!.rawQuery(sql);
//   }
//    deletetDb(String sql) async {
//     Database? mydb = await db;
//     return await mydb!.rawDelete(sql);
//   }
//    updateDb(String sql) async {
//     Database? mydb = await db;
//     return await mydb!.rawUpdate(sql);
//   }
// }
