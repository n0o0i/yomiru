// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      id: fields[0] as String,
      title: fields[1] as String,
      author: fields[2] as String,
      publisher: fields[3] as String?,
      publishedDate: fields[4] as String?,
      description: fields[5] as String?,
      isbn: fields[6] as String?,
      pageCount: fields[7] as int?,
      categories: (fields[8] as List).cast<String>(),
      averageRating: fields[9] as double?,
      ratingsCount: fields[10] as int?,
      imageUrl: fields[11] as String?,
      language: fields[12] as String?,
      previewLink: fields[13] as String?,
      infoLink: fields[14] as String?,
      googleBooksId: fields[15] as String?,
      subtitle: fields[16] as String?,
      authors: (fields[17] as List).cast<String>(),
      status: fields[18] as String,
      rating: fields[19] as double?,
      memo: fields[20] as String?,
      tags: (fields[21] as List).cast<String>(),
      dateAdded: fields[22] as String,
      dateRead: fields[23] as String?,
      createdAt: fields[24] as String,
      updatedAt: fields[25] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.publisher)
      ..writeByte(4)
      ..write(obj.publishedDate)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.isbn)
      ..writeByte(7)
      ..write(obj.pageCount)
      ..writeByte(8)
      ..write(obj.categories)
      ..writeByte(9)
      ..write(obj.averageRating)
      ..writeByte(10)
      ..write(obj.ratingsCount)
      ..writeByte(11)
      ..write(obj.imageUrl)
      ..writeByte(12)
      ..write(obj.language)
      ..writeByte(13)
      ..write(obj.previewLink)
      ..writeByte(14)
      ..write(obj.infoLink)
      ..writeByte(15)
      ..write(obj.googleBooksId)
      ..writeByte(16)
      ..write(obj.subtitle)
      ..writeByte(17)
      ..write(obj.authors)
      ..writeByte(18)
      ..write(obj.status)
      ..writeByte(19)
      ..write(obj.rating)
      ..writeByte(20)
      ..write(obj.memo)
      ..writeByte(21)
      ..write(obj.tags)
      ..writeByte(22)
      ..write(obj.dateAdded)
      ..writeByte(23)
      ..write(obj.dateRead)
      ..writeByte(24)
      ..write(obj.createdAt)
      ..writeByte(25)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
