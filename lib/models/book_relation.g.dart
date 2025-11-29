// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookRelation _$BookRelationFromJson(Map<String, dynamic> json) => BookRelation(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      bookId: json['book_id'] as String,
      status: json['status'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      books: json['books'] == null
          ? null
          : Book.fromJson(json['books'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookRelationToJson(BookRelation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'book_id': instance.bookId,
      'status': instance.status,
      'rating': instance.rating,
      'notes': instance.notes,
      'books': instance.books,
    };
