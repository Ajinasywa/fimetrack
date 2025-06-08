import 'package:flutter/material.dart';
import '../repositories/calendar_repository.dart';
import '../models/calendar_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum CyclePhase {
  menstruation,
  follicular,
  ovulation,
  luteal,
}

enum MoodType {
  happy,
  sad,
  anxious,
  angry,
}

class MenstrualCycleProvider with ChangeNotifier {
  DateTime? _periodStartDate;
  DateTime? _periodEndDate;
  CyclePhase _currentPhase = CyclePhase.menstruation;
  MoodType? _selectedMood;
  String _symptoms = '';
  String _notes = '';
  Set<DateTime> menstruationDates = {};
  final int _averageCycleLength = 28;
  final CalendarRepository _repository = CalendarRepository();

  DateTime? get periodStartDate => _periodStartDate;
  DateTime? get periodEndDate => _periodEndDate;
  CyclePhase get currentPhase => _currentPhase;
  MoodType? get selectedMood => _selectedMood;
  String get symptoms => _symptoms;
  String get notes => _notes;
  int get averageCycleLength => _averageCycleLength;

  String getTip() {
    switch (_currentPhase) {
      case CyclePhase.menstruation:
        return "Minum air putih yang cukup dan istirahat yang cukup hari ini ya!";
      case CyclePhase.follicular:
        return "Energi mulai meningkat, lakukan aktivitas yang menyenangkan!";
      case CyclePhase.ovulation:
        return "Ini masa subur, jaga kesehatan dengan baik!";
      case CyclePhase.luteal:
        return "Perhatikan asupan nutrisi dan hindari stres berlebihan!";
    }
  }

  void setPeriodDates(DateTime startDate, DateTime endDate) {
    _periodStartDate = startDate;
    _periodEndDate = endDate;
    _updatePhase();
    notifyListeners();
  }

  void setMood(MoodType mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  void setSymptoms(String symptoms) {
    _symptoms = symptoms;
    notifyListeners();
  }

  void setNotes(String notes) {
    _notes = notes;
    notifyListeners();
  }

  CyclePhase getPhaseForDate(DateTime date) {
    if (menstruationDates.contains(DateTime(date.year, date.month, date.day))) {
      return CyclePhase.menstruation;
    }
    // Logika fase lain bisa dikembangkan sesuai kebutuhan
    // Sementara: setelah menstruasi, masuk ke fase folikular
    if (_periodEndDate != null && date.isAfter(_periodEndDate!)) {
      return CyclePhase.follicular;
    }
    return CyclePhase.menstruation;
  }

  void _updatePhase() {
    _currentPhase = getPhaseForDate(DateTime.now());
  }

  DateTime? getNextPeriodStart() {
    if (_periodStartDate == null) return null;
    return _periodStartDate!.add(Duration(days: _averageCycleLength));
  }

  void resetData() {
    _periodStartDate = null;
    _periodEndDate = null;
    _currentPhase = CyclePhase.menstruation;
    _selectedMood = null;
    _symptoms = '';
    _notes = '';
    menstruationDates.clear();
    notifyListeners();
  }

  Future<void> loadFromDatabase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    menstruationDates = (await _repository.getMenstruationDates(user.uid)).toSet();
    if (menstruationDates.isNotEmpty) {
      final sorted = menstruationDates.toList()..sort();
      _periodStartDate = sorted.first;
      _periodEndDate = sorted.last;
    } else {
      _periodStartDate = null;
      _periodEndDate = null;
    }
    _updatePhase();
    notifyListeners();
  }

  Future<void> saveMenstruationRange(DateTime start, DateTime end) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await _repository.saveMenstruationRange(user.uid, start, end);
    await loadFromDatabase();
  }

  Future<void> saveToDatabase(DateTime date) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final entry = CalendarEntry(
      firebaseUserId: user.uid,
      date: date.toString().split(' ')[0],
      mood: _selectedMood?.toString(),
      note: _symptoms.isNotEmpty ? _symptoms : _notes,
    );
    await _repository.saveEntry(entry);
  }
} 