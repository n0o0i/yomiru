import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  final String id;
 
  final String title;
  final String author;
 
  @JsonKey(name: 'publisher')
  final String? publisher;

  @JsonKey(name: 'isbn')
  final String? isbn;

  @JsonKey(name: 'cover_url')
  final String? coverUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.publisher,
    this.isbn,
    this.coverUrl,
  });

  // JSONデシリアライズ（JSON -> Dartオブジェクト）
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  
  // JSONシリアライズ（Dartオブジェクト -> JSON）
  Map<String, dynamic> toJson() => _$BookToJson(this);
}