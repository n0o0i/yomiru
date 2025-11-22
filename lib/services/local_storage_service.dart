import 'package:yomiru/models/book_model.dart';
import 'package:yomiru/services/hive_service.dart';
import 'package:yomiru/services/api_service.dart';

class LocalStorageService {
  // 本をローカルに保存
  static Future<bool> saveBook(BookModel book) async {
    try {
      await HiveService.saveBook(book);
      return true;
    } catch (e) {
      print('Error saving book locally: $e');
      return false;
    }
  }
  
  // 本をローカルから取得
  static BookModel? getBook(String id) {
    return HiveService.getBook(id);
  }
  
  // すべての本をローカルから取得
  static List<BookModel> getAllBooks() {
    return HiveService.getAllBooks();
  }
  
  // ステータス別の本を取得
  static List<BookModel> getBooksByStatus(String status) {
    return HiveService.getBooksByStatus(status);
  }
  
  // 本を更新
  static Future<bool> updateBook(BookModel book) async {
    try {
      await HiveService.updateBook(book);
      return true;
    } catch (e) {
      print('Error updating book locally: $e');
      return false;
    }
  }
  
  // 本を削除
  static Future<bool> deleteBook(String id) async {
    try {
      await HiveService.deleteBook(id);
      return true;
    } catch (e) {
      print('Error deleting book locally: $e');
      return false;
    }
  }
  
  // 本を検索
  static List<BookModel> searchBooks(String query) {
    return HiveService.searchBooks(query);
  }
  
  // 本の統計情報を取得
  static Map<String, int> getBookStats() {
    return HiveService.getBookStats();
  }
  
  // 本を同期（サーバーから取得してローカルに保存）
  static Future<bool> syncBooks() async {
    try {
      // サーバーから本の一覧を取得
      final booksData = await ApiService.getBooks();
      
      // ローカルに保存
      for (final bookData in booksData) {
        final book = BookModel.fromJson(bookData);
        await HiveService.saveBook(book);
      }
      
      return true;
    } catch (e) {
      print('Error syncing books: $e');
      return false;
    }
  }
  
  // 本をサーバーに送信してローカルにも保存
  static Future<bool> addBookToServerAndLocal(BookModel book) async {
    try {
      // サーバーに送信
      final success = await ApiService.addBook(book.toJson());
      
      if (success) {
        // サーバーに送信成功したらローカルにも保存
        await HiveService.saveBook(book);
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error adding book to server and local: $e');
      return false;
    }
  }
  
  // オフライン対応：ローカルに保存して後で同期
  static Future<bool> addBookOffline(BookModel book) async {
    try {
      // ローカルに保存
      await HiveService.saveBook(book);
      
      // 設定に「同期が必要」フラグを保存
      await HiveService.saveSetting('needs_sync', true);
      
      return true;
    } catch (e) {
      print('Error adding book offline: $e');
      return false;
    }
  }
  
  // 同期が必要かどうかを確認
  static bool needsSync() {
    return HiveService.getSetting<bool>('needs_sync') ?? false;
  }
  
  // 同期完了フラグを設定
  static Future<void> markSyncComplete() async {
    await HiveService.saveSetting('needs_sync', false);
  }
  
  // すべてのデータをクリア
  static Future<void> clearAllData() async {
    await HiveService.clearAllData();
  }
}




