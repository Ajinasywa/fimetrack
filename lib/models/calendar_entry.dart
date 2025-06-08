class CalendarEntry {
  final int? id;
  final String firebaseUserId;  // Menggunakan Firebase UID
  final String date;
  final String? mood;
  final String? note;
  final String? symptom;
  final bool isMenstruation;

  CalendarEntry({
    this.id,
    required this.firebaseUserId,
    required this.date,
    this.mood,
    this.note,
    this.symptom,
    this.isMenstruation = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firebase_user_id': firebaseUserId,
      'date': date,
      'mood': mood,
      'note': note,
      'symptom': symptom,
      'is_menstruation': isMenstruation ? 1 : 0,
    };
  }

  factory CalendarEntry.fromMap(Map<String, dynamic> map) {
    return CalendarEntry(
      id: map['id'],
      firebaseUserId: map['firebase_user_id'],
      date: map['date'],
      mood: map['mood'],
      note: map['note'],
      symptom: map['symptom'],
      isMenstruation: map['is_menstruation'] == 1,
    );
  }
} 