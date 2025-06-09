import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/calendar_entry.dart';

class CalendarRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Tambah atau update entri
  Future<void> saveEntry(CalendarEntry entry) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'calendar_entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Ambil entri berdasarkan tanggal
  Future<CalendarEntry?> getEntry(String firebaseUserId, String date) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'calendar_entries',
      where: 'firebase_user_id = ? AND date = ?',
      whereArgs: [firebaseUserId, date],
    );

    if (maps.isEmpty) return null;
    return CalendarEntry.fromMap(maps.first);
  }

  // Ambil semua entri dalam rentang bulan
  Future<List<CalendarEntry>> getEntriesInRange(
    String firebaseUserId,
    String startDate,
    String endDate,
  ) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'calendar_entries',
      where: 'firebase_user_id = ? AND date BETWEEN ? AND ?',
      whereArgs: [firebaseUserId, startDate, endDate],
      orderBy: 'date ASC',
    );

    return maps.map((map) => CalendarEntry.fromMap(map)).toList();
  }

  // Update entri
  Future<void> updateEntry(CalendarEntry entry) async {
    final db = await _databaseHelper.database;
    await db.update(
      'calendar_entries',
      entry.toMap(),
      where: 'firebase_user_id = ? AND date = ?',
      whereArgs: [entry.firebaseUserId, entry.date],
    );
  }

  // Hapus entri
  Future<void> deleteEntry(String firebaseUserId, String date) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'calendar_entries',
      where: 'firebase_user_id = ? AND date = ?',
      whereArgs: [firebaseUserId, date],
    );
  }

  // Simpan range tanggal menstruasi
  Future<void> saveMenstruationRange(String userId, DateTime start, DateTime end) async {
    final db = await _databaseHelper.database;
    final batch = db.batch();
    for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      final entry = CalendarEntry(
        firebaseUserId: userId,
        date: d.toString().split(' ')[0],
        isMenstruation: true,
      );
      batch.insert(
        'calendar_entries',
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // Ambil semua tanggal menstruasi untuk user
  Future<List<DateTime>> getMenstruationDates(String userId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'calendar_entries',
      where: 'firebase_user_id = ? AND is_menstruation = 1',
      whereArgs: [userId],
    );
    return maps.map((map) => DateTime.parse(map['date'])).toList();
  }

  // Hapus semua entri menstruasi untuk user
  Future<void> deleteAllMenstruationEntries(String userId) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'calendar_entries',
      where: 'firebase_user_id = ? AND is_menstruation = 1',
      whereArgs: [userId],
    );
  }
} 