import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // Singleton instance
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  // Get database instance (or initialize it)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Initialize the database file in the app's document directory
  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "user.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create tables: users and timers
  Future _createDB(Database db, int version) async {
    // Create the users table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        gender TEXT,
        disability TEXT,
        language TEXT,
        notificationTime TEXT
      )
    ''');

    // Create the timers table (each user can have multiple timers)
    await db.execute('''
      CREATE TABLE timers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        timer_time TEXT NOT NULL,
        description TEXT,
        video_url TEXT,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // USER CRUD OPERATIONS
  // ─────────────────────────────────────────────────────────────────────────────

  Future<int> insertUser(Map<String, dynamic> user) async {
    final dbClient = await database;
    return await dbClient.insert("users", user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final dbClient = await database;
    return await dbClient.query("users");
  }

  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final dbClient = await database;
    return await dbClient
        .update("users", user, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    final dbClient = await database;
    return await dbClient.delete("users", where: 'id = ?', whereArgs: [id]);
  }

// In lib/db_helper.dart, add this method inside your DBHelper class:
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final dbClient = await database;
    List<Map<String, dynamic>> results = await dbClient.query(
      "users",
      where: "email = ?",
      whereArgs: [email],
    );
    if (results.isNotEmpty) return results.first;
    return null;
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // TIMERS CRUD OPERATIONS
  // ─────────────────────────────────────────────────────────────────────────────

  // Insert a new timer record
  Future<int> insertTimer(Map<String, dynamic> timer) async {
    final dbClient = await database;
    return await dbClient.insert("timers", timer);
  }

  // Get all timers for a given user
  Future<List<Map<String, dynamic>>> getTimersByUser(int userId) async {
    final dbClient = await database;
    return await dbClient
        .query("timers", where: 'user_id = ?', whereArgs: [userId]);
  }

  // Update an existing timer record
  Future<int> updateTimer(int id, Map<String, dynamic> timer) async {
    final dbClient = await database;
    return await dbClient
        .update("timers", timer, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a timer record
  Future<int> deleteTimer(int id) async {
    final dbClient = await database;
    return await dbClient.delete("timers", where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final dbClient = await database;
    dbClient.close();
  }
}
