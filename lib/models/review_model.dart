// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReviewModel {
  String by;
  String msg;
  ReviewModel({
    required this.by,
    required this.msg,
  });

  ReviewModel copyWith({
    String? by,
    String? msg,
  }) {
    return ReviewModel(
      by: by ?? this.by,
      msg: msg ?? this.msg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'by': by,
      'msg': msg,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      by: map['by'] as String,
      msg: map['msg'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReviewModel(by: $by, msg: $msg)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewModel && other.by == by && other.msg == msg;
  }

  @override
  int get hashCode => by.hashCode ^ msg.hashCode;
}
