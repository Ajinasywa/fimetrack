import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  
  // Average cycle lengths
  final int _averageCycleLength = 28;
  final int _averageMenstruationDays = 5;
  final int _averageFollicularDays = 11;
  final int _averageOvulationDays = 1;
  final int _averageLutealDays = 11;

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
    if (_periodStartDate == null) return CyclePhase.menstruation;

    final daysSinceStart = date.difference(_periodStartDate!).inDays;
    
    // If date is within menstruation period
    if (_periodEndDate != null && 
        date.isAfter(_periodStartDate!.subtract(const Duration(days: 1))) && 
        date.isBefore(_periodEndDate!.add(const Duration(days: 1)))) {
      return CyclePhase.menstruation;
    }

    // Calculate phase based on cycle day
    final cycleDay = daysSinceStart % _averageCycleLength;
    
    if (cycleDay < _averageMenstruationDays) {
      return CyclePhase.menstruation;
    } else if (cycleDay < _averageMenstruationDays + _averageFollicularDays) {
      return CyclePhase.follicular;
    } else if (cycleDay < _averageMenstruationDays + _averageFollicularDays + _averageOvulationDays) {
      return CyclePhase.ovulation;
    } else if (cycleDay < _averageMenstruationDays + _averageFollicularDays + _averageOvulationDays + _averageLutealDays) {
      return CyclePhase.luteal;
    } else {
      return CyclePhase.menstruation; // Start of new cycle
    }
  }

  void _updatePhase() {
    if (_periodStartDate == null) return;
    _currentPhase = getPhaseForDate(DateTime.now());
  }

  DateTime? getNextPeriodStart() {
    if (_periodStartDate == null) return null;
    return _periodStartDate!.add(Duration(days: _averageCycleLength));
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    if (_periodStartDate != null) {
      await prefs.setString('periodStartDate', _periodStartDate!.toIso8601String());
    }
    if (_periodEndDate != null) {
      await prefs.setString('periodEndDate', _periodEndDate!.toIso8601String());
    }
    await prefs.setString('symptoms', _symptoms);
    await prefs.setString('notes', _notes);
    if (_selectedMood != null) {
      await prefs.setString('mood', _selectedMood.toString());
    }
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final startDateStr = prefs.getString('periodStartDate');
    final endDateStr = prefs.getString('periodEndDate');
    
    if (startDateStr != null) {
      _periodStartDate = DateTime.parse(startDateStr);
    }
    if (endDateStr != null) {
      _periodEndDate = DateTime.parse(endDateStr);
    }
    
    _updatePhase();
    _symptoms = prefs.getString('symptoms') ?? '';
    _notes = prefs.getString('notes') ?? '';
    final moodStr = prefs.getString('mood');
    if (moodStr != null) {
      _selectedMood = MoodType.values.firstWhere(
        (e) => e.toString() == moodStr,
        orElse: () => MoodType.happy,
      );
    }
    notifyListeners();
  }
} 