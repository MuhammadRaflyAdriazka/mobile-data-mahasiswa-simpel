import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/mahasiswa.dart';

class DBHelper {
  static Database? _db;

  // Inisialisasi database jika belum ada
  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mahasiswa.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE mahasiswa(
            id INTEGER PRIMARY KEY,
            nim TEXT NOT NULL,
            nama TEXT NOT NULL,
            prodi TEXT NOT NULL,
            jeniskelamin TEXT NOT NULL,
            alamat TEXT NOT NULL,
            tanggallahir TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Getter untuk database
  static Future<Database> get _database async {
    return _db ??= await _initDb();
  }

  // Ambil semua data
  static Future<List<Mahasiswa>> getAll() async {
    final db = await _database;
    final res = await db.query('mahasiswa', orderBy: 'id');
    return res.map((e) => Mahasiswa.fromMap(e)).toList();
  }

  // Insert data
  static Future<int> insert(Mahasiswa data) async {
    final db = await _database;
    return await db.insert('mahasiswa', data.toMap());
  }

  // Update data
  static Future<int> update(Mahasiswa data) async {
    final db = await _database;
    return await db.update('mahasiswa', data.toMap(), where: 'id = ?', whereArgs: [data.id]);
  }

  // Delete data
  static Future<int> delete(int id) async {
    final db = await _database;
    return await db.delete('mahasiswa', where: 'id = ?', whereArgs: [id]);
  }

  // Cek apakah NIM sudah terdaftar, kecuali pada ID yang sedang diedit (jika ada)
  static Future<bool> isNimExist(String nim, {int? excludeId}) async {
    final db = await _database;
    final res = await db.query(
      'mahasiswa',
      where: excludeId == null ? 'nim = ?' : 'nim = ? AND id != ?',
      whereArgs: excludeId == null ? [nim] : [nim, excludeId],
    );
    return res.isNotEmpty;
  }

  // Reset database (hapus semua data)
  static Future<void> resetDatabase() async {
    final db = await _database;
    await db.delete('mahasiswa');
    
  }
}
