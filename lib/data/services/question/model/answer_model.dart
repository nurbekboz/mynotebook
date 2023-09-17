// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnwserModel {
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;
  final String? question6;
  final String? question7;
  final String? question8;
  final String? question9;
  final String? question10;

  AnwserModel(
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
    this.question6,
    this.question7,
    this.question8,
    this.question9,
    this.question10,
  );

  AnwserModel copyWith({
    String? question1,
    int? age,
  }) {
    return AnwserModel(
      question1 ?? this.question1,
      question2 ?? this.question2,
      question3 ?? this.question3,
      question4 ?? this.question4,
      question5 ?? this.question5,
      question6 ?? this.question6,
      question7 ?? this.question7,
      question8 ?? this.question8,
      question9 ?? this.question9,
      question10 ?? this.question10,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question1': question1,
      'question2': question2,
      'question3': question3,
      'question4': question4,
      'question5': question5,
      'question6': question6,
      'question7': question7,
      'question8': question8,
      'question9': question9,
      'question10': question10,
    };
  }

  factory AnwserModel.fromMap(Map<String, dynamic> map) {
    return AnwserModel(
      map['question1'] as String,
      map['question2'] as String,
      map['question3'] as String,
      map['question4'] as String,
      map['question5'] as String,
      map['question6'] as String,
      map['question7'] as String,
      map['question8'] as String,
      map['question9'] as String,
      map['question10'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnwserModel.fromJson(String source) =>
      AnwserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AnwserModel(question1: $question1, )';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnwserModel && other.question1 == question1;
  }

  @override
  int get hashCode => question1.hashCode;
}
