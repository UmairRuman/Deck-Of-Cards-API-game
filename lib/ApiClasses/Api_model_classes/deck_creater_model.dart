// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewDeckCreater {
  bool? success;
  String? deck_id;
  bool? shuffled;
  int? remaining;
  NewDeckCreater({
    this.success,
    this.deck_id,
    this.shuffled,
    this.remaining,
  });

  NewDeckCreater copyWith({
    bool? success,
    String? deck_id,
    bool? shuffled,
    int? remaining,
  }) {
    return NewDeckCreater(
      success: success ?? this.success,
      deck_id: deck_id ?? this.deck_id,
      shuffled: shuffled ?? this.shuffled,
      remaining: remaining ?? this.remaining,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'deck_id': deck_id,
      'shuffled': shuffled,
      'remaining': remaining,
    };
  }

  factory NewDeckCreater.fromMap(Map<String, dynamic> map) {
    return NewDeckCreater(
      success: map['success'] != null ? map['success'] as bool : null,
      deck_id: map['deck_id'] != null ? map['deck_id'] as String : null,
      shuffled: map['shuffled'] != null ? map['shuffled'] as bool : null,
      remaining: map['remaining'] != null ? map['remaining'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewDeckCreater.fromJson(String source) =>
      NewDeckCreater.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Card(success: $success, deck_id: $deck_id, shuffled: $shuffled, remaining: $remaining)';
  }

  @override
  bool operator ==(covariant NewDeckCreater other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.deck_id == deck_id &&
        other.shuffled == shuffled &&
        other.remaining == remaining;
  }

  @override
  int get hashCode {
    return success.hashCode ^
        deck_id.hashCode ^
        shuffled.hashCode ^
        remaining.hashCode;
  }
}
