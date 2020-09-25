import 'dart:async';
import 'dart:io';

import 'package:flutter_unit_test_acazia/models/model_user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String tableUser = "User";

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE $tableUser ("
              "id TEXT PRIMARY KEY,"
              "first_name TEXT,"
              "last_name TEXT,"
              "gender TEXT,"
              "street TEXT,"
              "email TEXT,"
              "phone TEXT,"
              "cell TEXT,"
              "username TEXT,"
              "registered TEXT,"
              "large TEXT"
              ")");
        });
  }

  addUser(UserInfo newUser) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into $tableUser (id, first_name, last_name, gender, street, email, phone, cell, username, registered, large)"
            " VALUES (?,?,?,?,?,?,?,?,?,?,?)",
        [newUser.id.value, newUser.name.first, newUser.name.last, newUser.gender, newUser.location.street, newUser.email, newUser.phone, newUser.cell, newUser.login.username, newUser.registered, newUser.picture.large]);
    print("add success ${newUser.name.last}");
    return raw;
  }

  isUserExit(String id) async {
    final db = await database;
    var res = await db.query(tableUser, where: "id = ?", whereArgs: [id]);
    if(res.isNotEmpty)
      return true;
    else return false;
  }

  Future<List<UserInfo>> getAllUser() async {
    final db = await database;
    var res = await db.query(tableUser);
    List<UserInfo> list = res.isNotEmpty ? res.map((c) => UserInfo.fromMap(c)).toList() : [];
    return list;
  }

  deleteUser(String id) async {
    final db = await database;
    return db.delete(tableUser, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from $tableUser");
  }
}
