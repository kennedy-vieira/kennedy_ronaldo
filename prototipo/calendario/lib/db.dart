import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'evento.dart';

// a classe Db contem todos os metodos para ler e escrever no banco de dados
//local da aplicação
class Db {
  String createTableComando = 'CREATE TABLE eventos (date INTEGER,'
      'title TEXT,icon TEXT,dot TEXT,disciplina TEXT,prioridade INTEGER,id '
      'INTEGER PRIMARY KEY AUTOINCREMENT)';

  Future<void> insereEvento(NovoEvento evento) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'informacoes.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(createTableComando,);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'eventos',
      evento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<String>> disciplinas() async{
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'informacoes.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(createTableComando,);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('eventos');
    List<String> tmp = [];
    for(var i =0; i < maps.length;i++){
      tmp.add(maps[i]['disciplina']);
    }


    return [...{...tmp}];
}
  Future<List<NovoEvento>> eventos() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'informacoes.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(createTableComando,);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('eventos');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return NovoEvento(
        date: DateTime.fromMillisecondsSinceEpoch(maps[i]['date']),
        title : maps[i]['title'],
        icon : maps[i]['icon'],
        dot : maps[i]['dot'],
        id: maps[i]['id'],
        disciplina: maps[i]['disciplina'],
        prioridade: maps[i]['prioridade'],
      );
    });
  }

  Future<void> updateEvento(NovoEvento evento) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'informacoes.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(createTableComando,);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'eventos',
      evento.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [evento.id],
    );
  }

  Future<void> deleteEvento(int id) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'informacoes.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(createTableComando,);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'eventos',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}