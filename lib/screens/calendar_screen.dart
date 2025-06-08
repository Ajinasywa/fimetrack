import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/menstrual_cycle_provider.dart';
import '../repositories/calendar_repository.dart';
import '../models/calendar_entry.dart';
import '../database/database_helper.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _periodStartDay;
  DateTime? _periodEndDay;
  final _formKey = GlobalKey<FormState>();
  final _symptomsController = TextEditingController();
  final _notesController = TextEditingController();
  MoodType? _selectedMood;
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  final CalendarRepository _repository = CalendarRepository();
  CalendarEntry? currentEntry;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<MenstrualCycleProvider>(context, listen: false);
      await provider.loadFromDatabase();
      // Jika tidak ada data, tetap gunakan hari ini
      if (provider.periodStartDate != null) {
        _periodStartDay = provider.periodStartDate;
        _focusedDay = provider.periodStartDate!;
      } else {
        _periodStartDay = null;
        _focusedDay = DateTime.now();
      }
      _periodEndDay = provider.periodEndDate;
      _symptomsController.text = provider.symptoms;
      _notesController.text = provider.notes;
      _selectedMood = provider.selectedMood;
      loadDayData(_focusedDay);
    });
  }

  Future<void> _initializeDatabase() async {
    try {
      final dbHelper = DatabaseHelper();
      final exists = await dbHelper.isTableExists('calendar_entries');
      if (!exists) {
        await dbHelper.resetDatabase();
      }
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  @override
  void dispose() {
    _symptomsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Color _getPhaseColor(DateTime day, MenstrualCycleProvider provider) {
    // Jika hari ini adalah hari menstruasi
    if (provider.menstruationDates.contains(DateTime(day.year, day.month, day.day))) {
      return const Color(0xFFFF7B9C).withAlpha(77); // Pink
    }
    // Jika belum ada data menstruasi, tidak diwarnai
    if (provider.periodEndDate == null || provider.periodStartDate == null) {
      return Colors.transparent;
    }
    // Hitung urutan fase setelah menstruasi
    final sorted = provider.menstruationDates.toList()..sort();
    if (sorted.isEmpty) return Colors.transparent;
    final lastMenstruation = sorted.last;
    final dayDiff = day.difference(lastMenstruation).inDays;
    if (day.isAfter(lastMenstruation)) {
      if (dayDiff <= 11) {
        return Colors.blue.withAlpha(77); // Folikular (11 hari setelah menstruasi)
      } else if (dayDiff == 12) {
        return Colors.green.withAlpha(77); // Ovulasi (hari ke-12 setelah menstruasi)
      } else if (dayDiff <= 23) {
        return Colors.purple.withAlpha(77); // Luteal (hari ke-13 sampai ke-23 setelah menstruasi)
      }
    }
    return Colors.transparent;
  }

  Future<void> loadDayData(DateTime date) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final entry = await _repository.getEntry(
        userId,
        date.toString().split(' ')[0],
      );
      if (!mounted) return;
      setState(() {
        currentEntry = entry;
        if (entry != null) {
          _symptomsController.text = entry.symptom ?? '';
          _notesController.text = entry.note ?? '';
        } else {
          _symptomsController.clear();
          _notesController.clear();
        }
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading data')),
      );
    }
  }

  Future<void> saveData() async {
    if (_symptomsController.text.isEmpty && _notesController.text.isEmpty && _selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon isi minimal satu data')),
      );
      return;
    }
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      // Jika user memilih range, simpan ke semua tanggal dalam range
      if (_periodStartDay != null && _periodEndDay != null && _periodStartDay != _periodEndDay) {
        DateTime d = _periodStartDay!;
        while (!d.isAfter(_periodEndDay!)) {
          final entry = CalendarEntry(
            firebaseUserId: userId,
            date: d.toString().split(' ')[0],
            mood: _selectedMood?.toString(),
            note: _notesController.text,
            symptom: _symptomsController.text,
            isMenstruation: true,
          );
          await _repository.saveEntry(entry);
          d = d.add(const Duration(days: 1));
        }
      } else {
        // Simpan hanya untuk satu tanggal
        final entry = CalendarEntry(
          firebaseUserId: userId,
          date: _focusedDay.toString().split(' ')[0],
          mood: _selectedMood?.toString(),
          note: _notesController.text,
          symptom: _symptomsController.text,
        );
        await _repository.saveEntry(entry);
      }
      if (!mounted) return;
      final provider = Provider.of<MenstrualCycleProvider>(context, listen: false);
      await provider.loadFromDatabase();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil disimpan'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      await loadDayData(_focusedDay);
    } catch (e) {
      print('Error saving data: $e');
      if (!mounted) return;
      String errorMessage = 'Gagal menyimpan data';
      if (e is DatabaseException) {
        errorMessage = 'Database error: ${e.toString()}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalender'),
        backgroundColor: const Color(0xFFFF7B9C),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<MenstrualCycleProvider>(
              builder: (context, provider, child) {
                return TableCalendar(
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => provider.menstruationDates.contains(DateTime(day.year, day.month, day.day)),
                  rangeStartDay: _periodStartDay,
                  rangeEndDay: _periodEndDay,
                  rangeSelectionMode: _rangeSelectionMode,
                  calendarFormat: CalendarFormat.month,
                  onFormatChanged: (format) {},
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFFF7B9C),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFFFF7B9C).withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    rangeHighlightColor: const Color(0xFFFF7B9C).withAlpha(51),
                    rangeStartDecoration: const BoxDecoration(
                      color: Color(0xFFFF7B9C),
                      shape: BoxShape.circle,
                    ),
                    rangeEndDecoration: const BoxDecoration(
                      color: Color(0xFFFF7B9C),
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _periodStartDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onRangeSelected: (start, end, focusedDay) async {
                    setState(() {
                      _periodStartDay = start;
                      _periodEndDay = end;
                      _focusedDay = focusedDay;
                    });
                    if (start != null && end != null) {
                      final provider = Provider.of<MenstrualCycleProvider>(context, listen: false);
                      await provider.saveMenstruationRange(start, end);
                    }
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      final isMenstruation = provider.menstruationDates.contains(DateTime(day.year, day.month, day.day));
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isMenstruation ? const Color(0xFFFF7B9C).withAlpha(77) : _getPhaseColor(day, provider),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Penjelasan Kalender:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _PhaseLegend(
                    color: const Color(0xFFFF7B9C).withAlpha(77),  // Perbaikan di sini
                    label: 'Fase Menstruasi',
                  ),
                  _PhaseLegend(
                    color: Colors.blue.withAlpha(77),  // Perbaikan di sini
                    label: 'Fase Folikular',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _PhaseLegend(
                    color: Colors.green.withAlpha(77),  // Perbaikan di sini
                    label: 'Fase Ovulasi',
                  ),
                  _PhaseLegend(
                    color: Colors.purple.withAlpha(77),  // Perbaikan di sini
                    label: 'Fase Luteal',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Track Mood',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: MoodType.values.map((mood) {
                final isSelected = _selectedMood == mood;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMood = mood;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFFF7B9C) : const Color(0xFFFFF0F3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          mood == MoodType.happy ? Icons.sentiment_very_satisfied :
                          mood == MoodType.sad ? Icons.sentiment_very_dissatisfied :
                          mood == MoodType.anxious ? Icons.mood_bad :
                          Icons.sentiment_very_dissatisfied,
                          color: isSelected ? Colors.white : const Color(0xFFFF7B9C),
                        ),
                        Text(
                          mood.toString().split('.').last,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Catatan Menstruasi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _symptomsController,
                      decoration: const InputDecoration(
                        labelText: 'Gejala',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        labelText: 'Catatan tambahan',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: saveData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7B9C),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhaseLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _PhaseLegend({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
