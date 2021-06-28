import 'dart:async';

import 'disciplina.dart';
import 'atividade.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'usuario.dart';

// a classe Db contem todos os metodos para ler e escrever no banco de dados
//local da aplicação
class dbController {
  String createTableUsuario = 'CREATE TABLE usuarios (nome TEXT,expericencia INTEGER,id INTEGER PRIMARY KEY AUTOINCREMENT)';

  String createTableDisciplina = 'CREATE TABLE disciplinas (nome TEXT,codDisciplina INTEGER PRIMARY KEY AUTOINCREMENT)';

  String createTableAtividade =
      'CREATE TABLE atividades (dataDeEntrega INTEGER,'
      'titulo TEXT,idUsuario INTEGER,status TEXT,idDisciplina INTEGER,prioridade INTEGER,id '
      'INTEGER PRIMARY KEY AUTOINCREMENT,notaAtividade REAL,notaAlcancada REAL)';


  /*=========================TABELAS USUARIOS==============================*/
  Future<void> insereUsuario(Usuario usuario) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(

      join(await getDatabasesPath(), 'usuarios.db'),
      onCreate: (db, version) {
        return db.execute(createTableUsuario,);
      },
      version: 1,

    );

    final db = await database;

    await db.insert(
      'usuarios',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Usuario>> getUsuarios() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'usuarios.db'),
      onCreate: (db, version) {
        return db.execute(createTableUsuario,);
      },
      version: 1,
    );
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('usarios');

    return List.generate(maps.length, (i) {
      return Usuario(
        nome: maps[i]['nome'],
        experiencia: maps[i]['experiencia'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateUsuario(Usuario usuario) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(

      join(await getDatabasesPath(), 'usuarios.db'),

      onCreate: (db, version) {
        return db.execute(createTableUsuario,);
      },

      version: 1,
    );

    final db = await database;

    await db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<void> deleteUsuario(int id) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(

      join(await getDatabasesPath(), 'usuarios.db'),

      onCreate: (db, version) {
        return db.execute(createTableUsuario,);
      },

      version: 1,
    );

    final db = await database;

    await db.delete(
      'usuario',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /*======================================================================*/

  /*=========================TABELAS DISCIPLINAS==============================*/
  Future<void> insereDisciplina(Disciplina disciplina) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(

      join(await getDatabasesPath(), 'disciplinas.db'),
      onCreate: (db, version) {
        return db.execute(createTableDisciplina,);
      },
      version: 1,

    );

    final db = await database;

    await db.insert(
      'disciplinas',
      disciplina.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Disciplina>> getDisciplinas() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'disciplinas.db'),
      onCreate: (db, version) {
        return db.execute(createTableDisciplina,);
      },
      version: 1,
    );
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('disciplinas');

    return List.generate(maps.length, (i) {
      return Disciplina(
        nome: maps[i]['nome'],
        codDisciplina: maps[i]['codDisciplina'],
      );
    });
  }

  Future<void> updateDisciplinas(Disciplina disciplina) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(

      join(await getDatabasesPath(), 'disciplinas.db'),

      onCreate: (db, version) {
        return db.execute(createTableDisciplina,);
      },

      version: 1,
    );

    final db = await database;

    await db.update(
      'disciplinas',
      disciplina.toMap(),
      where: 'id = ?',
      whereArgs: [disciplina.codDisciplina],
    );
  }

  Future<void> deleteDisciplinas(int id) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(

      join(await getDatabasesPath(), 'disciplinas.db'),

      onCreate: (db, version) {
        return db.execute(createTableDisciplina,);
      },

      version: 1,
    );

    final db = await database;

    await db.delete(
      'disciplinas',
      where: 'codDisciplina = ?',
      whereArgs: [id],
    );
  }

  /*======================================================================*/


  /*=========================TABELAS ATIVIDADE==============================*/
  Future<void> insereAtividade(Atividade atividade) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(

      join(await getDatabasesPath(), 'atividades.db'),
      onCreate: (db, version) {
        return db.execute(createTableAtividade,);
      },
      version: 1,

    );

    final db = await database;

    await db.insert(
      'atividades',
      atividade.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Atividade>> getAtividades() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'atividades.db'),
      onCreate: (db, version) {
        return db.execute(createTableAtividade,);
      },
      version: 1,
    );
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('atividades');

    return List.generate(maps.length, (i) {
      return Atividade(
        dataDeEntrega: maps[i]['dataDeEntrega'],
        titulo: maps[i]['titulo'],
        idUsuario: maps[i]['idUsuario'],
        prioridade: maps[i]['prioridade'],
        idDisciplina: maps[i]['idDisciplina'],
        id: maps[i]['id'],
        status: maps[i]['status'],
        notaAlcancada: maps[i]['notaAlcancada'],
        notaAtividade: maps[i]['notaAtividade'],
      );
    });
  }

  Future<void> updateAtividades(Atividade atividade) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(

      join(await getDatabasesPath(), 'atividades.db'),

      onCreate: (db, version) {
        return db.execute(createTableAtividade,);
      },

      version: 1,
    );

    final db = await database;

    await db.update(
      'atividades',
      atividade.toMap(),
      where: 'id = ?',
      whereArgs: [atividade.id],
    );
  }

  Future<void> deleteAtividades(int id) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(

      join(await getDatabasesPath(), 'atividades.db'),

      onCreate: (db, version) {
        return db.execute(createTableAtividade,);
      },

      version: 1,
    );

    final db = await database;

    await db.delete(
      'atividades',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
/*======================================================================*/
}

// /*=========================TABELAS HIGHSCORE==============================*/
// Future<void> insereHighScore(NovoEvento evento) async {
//
// }
// Future<List<String>> getHighScores() async{
//
// }
// Future<void> updateHighScore(NovoEvento evento) async {
//
// }
// Future<void> deleteHighScore(NovoEvento evento) async {
//
// }
// /*======================================================================*/
//
//
// /*=========================TABELAS CONQUISTAS==============================*/
// Future<void> insereConquistas(NovoEvento evento) async {
//
// }
// Future<List<String>> getConquistas() async{
//
// }
//
// Future<void> updateConquistas(NovoEvento evento) async {
//
// }
// Future<void> deleteConquistas(NovoEvento evento) async {
//
// }
//
// /*======================================================================*/

