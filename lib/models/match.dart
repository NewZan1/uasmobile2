import 'package:cloud_firestore/cloud_firestore.dart';

class Matches {
  String match;
  String score;
  bool isDone;
  Timestamp date;

  Matches(
      {required this.match,
      required this.score,
      required this.isDone,
      required this.date});

  Matches.fromJson(Map<String, Object?> json)
      : this(
            match: json['match']! as String,
            score: json['score']! as String,
            isDone: json['isDone']! as bool,
            date: json['date']! as Timestamp);

  Matches copyWith({
    String? match,
    String? score,
    bool? isDone,
    Timestamp? date,
  }) {
    return Matches(
        match: match ?? this.match,
        score: score ?? this.score,
        isDone: isDone ?? this.isDone,
        date: date ?? this.date);
  }

  Map<String, Object?> toJson() {
    return {
      'match': match,
      'score': score,
      'isDone': isDone,
      'date': date,
    };
  }
}
