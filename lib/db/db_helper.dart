import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../model/mahasiswa.dart';

class DBHelper {
  // Fungsi untuk reset database (drop dan create ulang tabel mahasiswa)
  static Future<void> resetDatabase() async {
    final db = await database;
    await db.execute('DROP TABLE IF EXISTS mahasiswa');
    await db.execute('''
      CREATE TABLE mahasiswa (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nim TEXT,
        nama TEXT,
        prodi TEXT,
        jeniskelamin TEXT
      )
    ''');
  }
  static Database? _db;

  static Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'mahasiswa.db');

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE mahasiswa (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nim TEXT,
          nama TEXT,
          prodi TEXT,
          jeniskelamin TEXT
        )
      ''');
    });
  }

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<int> insert(Mahasiswa m) async {
    final db = await database;
    return await db.insert('mahasiswa', m.toMap());
  }

  static Future<List<Mahasiswa>> getAll() async {
    final db = await database;
    final res = await db.query('mahasiswa');
    return res.map((e) => Mahasiswa.fromMap(e)).toList();
  }

  static Future<int> update(Mahasiswa m) async {
    final db = await database;
    return await db.update('mahasiswa', m.toMap(), where: 'id = ?', whereArgs: [m.id]);
  }

  static Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('mahasiswa', where: 'id = ?', whereArgs: [id]);
  }
}
