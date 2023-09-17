// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnimAnwserModel {
  final String? isSucces;
  final String? adim1;
  final String? adim2;
  final String? adim3;
  final String? adim4;
  final String? adim5;
  final String? adim6;
  final String? adim7;
  final String? adim8;
  final String? adim9;
  final String? adim10;
  final String? adim11;
  final String? adim12;
  final String? adim13;

  AnimAnwserModel(
    this.adim1,
    this.adim2,
    this.adim3,
    this.adim4,
    this.adim5,
    this.adim6,
    this.adim7,
    this.adim8,
    this.adim9,
    this.adim10,
    this.adim11,
    this.adim12,
    this.adim13,
    this.isSucces,
  );

  AnimAnwserModel copyWith({
    String? adim1,
    int? age,
  }) {
    return AnimAnwserModel(
      isSucces ?? this.isSucces,
      adim1 ?? this.adim1,
      adim2 ?? this.adim2,
      adim3 ?? this.adim3,
      adim4 ?? this.adim4,
      adim5 ?? this.adim5,
      adim6 ?? this.adim6,
      adim7 ?? this.adim7,
      adim8 ?? this.adim8,
      adim9 ?? this.adim9,
      adim10 ?? this.adim10,
      adim11 ?? this.adim11,
      adim12 ?? this.adim12,
      adim13 ?? this.adim13,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSucces': isSucces,
      'adim1': adim1,
      'adim2': adim2,
      'adim3': adim3,
      'adim4': adim4,
      'adim5': adim5,
      'adim6': adim6,
      'adim7': adim7,
      'adim8': adim8,
      'adim9': adim9,
      'adim10': adim10,
      'adim11': adim11,
      'adim12': adim12,
      'adim13': adim13,
    };
  }

  factory AnimAnwserModel.fromMap(Map<String, dynamic> map) {
    return AnimAnwserModel(
      map['isSucces'] as String,
      map['adim1'] as String,
      map['adim2'] as String,
      map['adim3'] as String,
      map['adim4'] as String,
      map['adim5'] as String,
      map['adim6'] as String,
      map['adim7'] as String,
      map['adim8'] as String,
      map['adim9'] as String,
      map['adim10'] as String,
      map['adim11'] as String,
      map['adim12'] as String,
      map['adim13'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimAnwserModel.fromJson(String source) =>
      AnimAnwserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AnimAnwserModel(adim1: $adim1, )';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnimAnwserModel && other.adim1 == adim1;
  }

  @override
  int get hashCode => adim1.hashCode;
}
