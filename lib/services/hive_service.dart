import 'package:hive_flutter/hive_flutter.dart';
import 'package:yomiru/models/book_model.dart';

class HiveService {
  static const String _booksBoxName = 'books';
  static const String _settingsBoxName = 'settings';
  
  static Box<BookModel>? _booksBox;
  static Box<Map>? _settingsBox;
  
  // Hiveの初期化
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // アダプターの登録
    Hive.registerAdapter(BookModelAdapter());
    
    // ボックスの初期化
    _booksBox = await Hive.openBox<BookModel>(_booksBoxName);
    _settingsBox = await Hive.openBox<Map>(_settingsBoxName);
  }
  
  // 本の保存
  static Future<void> saveBook(BookModel book) async {
    await _booksBox?.put(book.id, book);
  }
  
  // 本の取得
  static BookModel? getBook(String id) {
    return _booksBox?.get(id);
  }
  
  // すべての本を取得
  static List<BookModel> getAllBooks() {
    return _booksBox?.values.toList() ?? [];
  }
  
  // ステータス別の本を取得
  static List<BookModel> getBooksByStatus(String status) {
    return _booksBox?.values
        .where((book) => book.status == status)
        .toList() ?? [];
  }
  
  // 本の更新
  static Future<void> updateBook(BookModel book) async {
    await _booksBox?.put(book.id, book);
  }
  
  // 本の削除
  static Future<void> deleteBook(String id) async {
    await _booksBox?.delete(id);
  }
  
  // 本の検索
  static List<BookModel> searchBooks(String query) {
    final lowerQuery = query.toLowerCase();
    return _booksBox?.values
        .where((book) => 
          book.title.toLowerCase().contains(lowerQuery) ||
          book.author.toLowerCase().contains(lowerQuery) ||
          (book.publisher?.toLowerCase().contains(lowerQuery) ?? false) ||
          (book.memo?.toLowerCase().contains(lowerQuery) ?? false)
        )
        .toList() ?? [];
  }
  
  // 設定の保存
  static Future<void> saveSetting(String key, dynamic value) async {
    await _settingsBox?.put(key, {'value': value, 'timestamp': DateTime.now().millisecondsSinceEpoch});
  }
  
  // 設定の取得
  static T? getSetting<T>(String key) {
    final setting = _settingsBox?.get(key);
    return setting?['value'] as T?;
  }
  
  // 設定の削除
  static Future<void> deleteSetting(String key) async {
    await _settingsBox?.delete(key);
  }
  
  // すべてのデータをクリア
  static Future<void> clearAllData() async {
    await _booksBox?.clear();
    await _settingsBox?.clear();
  }
  
  // 本の統計情報を取得
  static Map<String, int> getBookStats() {
    final books = getAllBooks();
    final readBooks = books.where((book) => book.status == 'read').length;
    final toReadBooks = books.where((book) => book.status == 'to_read').length;
    
    return {
      'total': books.length,
      'read': readBooks,
      'to_read': toReadBooks,
    };
  }
  
  // ボックスのクローズ
  static Future<void> close() async {
    await _booksBox?.close();
    await _settingsBox?.close();
  }
}




