import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String author;
  @HiveField(3)
  final String? publisher;
  @HiveField(4)
  final String? publishedDate;
  @HiveField(5)
  final String? description;
  @HiveField(6)
  final String? isbn;
  @HiveField(7)
  final int? pageCount;
  @HiveField(8)
  final List<String> categories;
  @HiveField(9)
  final double? averageRating;
  @HiveField(10)
  final int? ratingsCount;
  @HiveField(11)
  final String? imageUrl;
  @HiveField(12)
  final String? language;
  @HiveField(13)
  final String? previewLink;
  @HiveField(14)
  final String? infoLink;
  @HiveField(15)
  final String? googleBooksId;
  @HiveField(16)
  final String? subtitle;
  @HiveField(17)
  final List<String> authors;
  @HiveField(18)
  final String status;
  @HiveField(19)
  final double? rating;
  @HiveField(20)
  final String? memo;
  @HiveField(21)
  final List<String> tags;
  @HiveField(22)
  final String dateAdded;
  @HiveField(23)
  final String? dateRead;
  @HiveField(24)
  final String createdAt;
  @HiveField(25)
  final String updatedAt;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    this.publisher,
    this.publishedDate,
    this.description,
    this.isbn,
    this.pageCount,
    this.categories = const [],
    this.averageRating,
    this.ratingsCount,
    this.imageUrl,
    this.language,
    this.previewLink,
    this.infoLink,
    this.googleBooksId,
    this.subtitle,
    this.authors = const [],
    this.status = 'to_read',
    this.rating,
    this.memo,
    this.tags = const [],
    required this.dateAdded,
    this.dateRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      publisher: json['publisher'],
      publishedDate: json['publishedDate'],
      description: json['description'],
      isbn: json['isbn'],
      pageCount: json['pageCount'],
      categories: List<String>.from(json['categories'] ?? []),
      averageRating: json['averageRating']?.toDouble(),
      ratingsCount: json['ratingsCount'],
      imageUrl: json['imageUrl'],
      language: json['language'],
      previewLink: json['previewLink'],
      infoLink: json['infoLink'],
      googleBooksId: json['googleBooksId'],
      subtitle: json['subtitle'],
      authors: List<String>.from(json['authors'] ?? []),
      status: json['status'] ?? 'to_read',
      rating: json['rating']?.toDouble(),
      memo: json['memo'],
      tags: List<String>.from(json['tags'] ?? []),
      dateAdded: json['dateAdded'] ?? DateTime.now().toIso8601String(),
      dateRead: json['dateRead'],
      createdAt: json['createdAt'] ?? DateTime.now().toIso8601String(),
      updatedAt: json['updatedAt'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publisher': publisher,
      'publishedDate': publishedDate,
      'description': description,
      'isbn': isbn,
      'pageCount': pageCount,
      'categories': categories,
      'averageRating': averageRating,
      'ratingsCount': ratingsCount,
      'imageUrl': imageUrl,
      'language': language,
      'previewLink': previewLink,
      'infoLink': infoLink,
      'googleBooksId': googleBooksId,
      'subtitle': subtitle,
      'authors': authors,
      'status': status,
      'rating': rating,
      'memo': memo,
      'tags': tags,
      'dateAdded': dateAdded,
      'dateRead': dateRead,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    String? publisher,
    String? publishedDate,
    String? description,
    String? isbn,
    int? pageCount,
    List<String>? categories,
    double? averageRating,
    int? ratingsCount,
    String? imageUrl,
    String? language,
    String? previewLink,
    String? infoLink,
    String? googleBooksId,
    String? subtitle,
    List<String>? authors,
    String? status,
    double? rating,
    String? memo,
    List<String>? tags,
    String? dateAdded,
    String? dateRead,
    String? createdAt,
    String? updatedAt,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      publishedDate: publishedDate ?? this.publishedDate,
      description: description ?? this.description,
      isbn: isbn ?? this.isbn,
      pageCount: pageCount ?? this.pageCount,
      categories: categories ?? this.categories,
      averageRating: averageRating ?? this.averageRating,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      imageUrl: imageUrl ?? this.imageUrl,
      language: language ?? this.language,
      previewLink: previewLink ?? this.previewLink,
      infoLink: infoLink ?? this.infoLink,
      googleBooksId: googleBooksId ?? this.googleBooksId,
      subtitle: subtitle ?? this.subtitle,
      authors: authors ?? this.authors,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      memo: memo ?? this.memo,
      tags: tags ?? this.tags,
      dateAdded: dateAdded ?? this.dateAdded,
      dateRead: dateRead ?? this.dateRead,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

