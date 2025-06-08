import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'fimetrack.db');
    
    // Delete existing database if it exists
    await deleteDatabase(path);
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    print('Creating calendar_entries table...'); // Debug log
    await db.execute('''
      CREATE TABLE IF NOT EXISTS calendar_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firebase_user_id TEXT NOT NULL,
        date TEXT NOT NULL,
        mood TEXT,
        note TEXT,
        symptom TEXT,
        is_menstruation INTEGER DEFAULT 0,
        UNIQUE(firebase_user_id, date)
      )
    ''');
    print('Table created successfully'); // Debug log
  }

  // Method to check if table exists
  Future<bool> isTableExists(String tableName) async {
    final db = await database;
    var tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );
    return tables.isNotEmpty;
  }

  // Method to reset database
  Future<void> resetDatabase() async {
    String path = join(await getDatabasesPath(), 'fimetrack.db');
    _database = null;
    await deleteDatabase(path);
    await initDatabase();
  }
} 