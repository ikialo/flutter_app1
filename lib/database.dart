import 'dart:async';
import 'dart:io' as io;
import 'package:flutter_app1/accountSave.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "save_acc.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Employee with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE AccountSave(id INTEGER PRIMARY KEY, name TEXT, savedAccount TEXT)");
    print("Created tables");
  }

  // Retrieving employees from Employee Tables
  Future<List<AccountSave>> getEmployees() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM AccountSave');
    List<AccountSave> employees = new List();
    for (int i = 0; i < list.length; i++) {
      employees.add(new AccountSave(list[i]["name"], list[i]["savedAccount"]));
    }
    print(employees.length);
    return employees;
  }

  void saveEmployee(AccountSave employee) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO AccountSave(name, savedAccount) VALUES(' +
              '\'' +
              employee.name +
              '\'' +
              ',' +
              '\'' +
              employee.savedAccount +
              '\'' +
              ')');
    });
  }


}