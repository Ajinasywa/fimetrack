import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/menstrual_cycle_provider.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MenstrualCycleProvider>(context, listen: false);
      _periodStartDay = provider.periodStartDate;
      _periodEndDay = provider.periodEndDate;
      _symptomsController.text = provider.symptoms;
      _notesController.text = provider.notes;
      _selectedMood = provider.selectedMood;
    });
  }

  @override
  void dispose() {
    _symptomsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Color _getPhaseColor(DateTime day, MenstrualCycleProvider provider) {
    if (provider.periodStartDate == null) return Colors.transparent;

    // Check if the day is within the selected menstruation period
    if (provider.periodEndDate != null &&
        day.isAfter(provider.periodStartDate!.subtract(const Duration(days: 1))) &&
        day.isBefore(provider.periodEndDate!.add(const Duration(days: 1)))) {
      return const Color(0xFFFF7B9C).withAlpha(77);  // Perbaikan di sini
    }

    // Get the phase for this day
    final phase = provider.getPhaseForDate(day);
    switch (phase) {
      case CyclePhase.menstruation:
        return const Color(0xFFFF7B9C).withAlpha(77);  // Perbaikan di sini
      case CyclePhase.follicular:
        return Colors.blue.withAlpha(77);  // Perbaikan di sini
      case CyclePhase.ovulation:
        return Colors.green.withAlpha(77);  // Perbaikan di sini
      case CyclePhase.luteal:
        return Colors.purple.withAlpha(77);  // Perbaikan di sini
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
                  selectedDayPredicate: (day) => isSameDay(_periodStartDay, day),
                  rangeStartDay: _periodStartDay,
                  rangeEndDay: _periodEndDay,
                  rangeSelectionMode: _rangeSelectionMode,
                  calendarFormat: CalendarFormat.month,
                  onFormatChanged: (format) {
                    // No need to change format as we want to keep it fixed to month view
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFFF7B9C),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFFFF7B9C).withAlpha(128),  // Perbaikan di sini
                      shape: BoxShape.circle,
                    ),
                    rangeHighlightColor: const Color(0xFFFF7B9C).withAlpha(51),  // Perbaikan di sini
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
                  onRangeSelected: (start, end, focusedDay) {
                    setState(() {
                      _periodStartDay = start;
                      _periodEndDay = end;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getPhaseColor(day, provider),
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
                        onPressed: () {
                          if (_periodStartDay != null && _periodEndDay != null && _formKey.currentState!.validate()) {
                            final provider = Provider.of<MenstrualCycleProvider>(
                              context,
                              listen: false,
                            );
                            provider.setPeriodDates(_periodStartDay!, _periodEndDay!);
                            provider.setSymptoms(_symptomsController.text);
                            provider.setNotes(_notesController.text);
                            if (_selectedMood != null) {
                              provider.setMood(_selectedMood!);
                            }
                            provider.saveData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Data berhasil disimpan'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pilih tanggal awal dan akhir menstruasi'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
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
