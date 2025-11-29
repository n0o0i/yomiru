import 'package:json_annotation/json_annotation.dart';
import 'book.dart';

part 'book_relation.g.dart';

@JsonSerializable()
class BookRelation {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'book_id')
  final String bookId;
  final String status;
  final double? rating;
  final String? notes;

  final Book? books;

  BookRelation({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.status,
    this.rating,
    this.notes,
    this.books,
  });

  factory BookRelation.fromJson(Map<String, dynamic> json) => _$BookRelationFromJson(json);
  Map<String, dynamic> toJson() => _$BookRelationToJson(this);
}
