import 'dart:io' as io;

import 'package:assigment/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseHelper {
  static final _tableName = "myData";
  static final columnId = "id";
  static final columnName = "name";
  static final columnEmail = "email";
  static final columnPh = "ph";
  static final columnPhoto = "img";
  static final columnPass = "pass";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "assignment.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  String qry =
      "CREATE TABLE $_tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnName TEXT NULL,$columnEmail TEXT NULL,$columnPass TEXT NULL,$columnPh TEXT NULL,$columnPhoto TEXT NULL)";
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(qry);
    print("Created tables");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await this.db;
    int result = await db.insert(_tableName, row);
    print(row);
    return result;
  }

  Future<void> getLogin(String email, String pass, BuildContext context) async {
    var dbClient = await this.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM $_tableName WHERE email = '$email' and pass = '$pass'");

    String userName = res[0][columnName];
    String userEmail = res[0][columnEmail];
    String userImgPath = res[0][columnPhoto];
    String userPh = res[0][columnPh];
    int userId = res[0][columnId];

    if (res.isEmpty) {
      Fluttertoast.showToast(msg: "Enter Currect Email and Password");
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => home(res)));
      Fluttertoast.showToast(msg: "Wlcome Back $userName");
    }
  }
}
