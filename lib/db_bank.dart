import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'account_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE accounts(id INTEGER PRIMARY KEY, name TEXT, acc INTEGER)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertDog(Account dog) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'accounts',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Account>> dogs() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('accounts');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Account(
        id: maps[i]['id'],
        name: maps[i]['name'],
        acc: maps[i]['acc'],
      );
    });
  }

  Future<void> updateDog(Account dog) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'accounts',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'accounts',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

//  var fido = Dog(
//    id: 0,
//    name: 'Fido',
//    age: 35,
//  );
//
//  // Insert a dog into the database.
//  await insertDog(fido);
//
//  // Print the list of dogs (only Fido for now).
//  print(await dogs());

  // Update Fido's age and save it to the database.
//  fido = Dog(
//    id: fido.id,
//    name: fido.name,
//    age: fido.age + 7,
//  );
//  await updateDog(fido);
//
//  // Print Fido's updated information.
//  print(await dogs());
//
//  // Delete Fido from the database.
//  await deleteDog(fido.id);
//
//  // Print the list of dogs (empty).
//  print(await dogs());
}

class Account {
  final int id;
  final String name;
  final String acc;

  Account({this.id, this.name, this.acc});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'acc': acc,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $acc}';
  }
}