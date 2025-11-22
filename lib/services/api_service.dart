import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:yomiru/services/config_service.dart';

class ApiService {
  static String get baseUrl => ConfigService.apiBaseUrl;
  
  // Google Books APIで本を検索
  static Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/google-books/search?q=${Uri.encodeComponent(query)}&maxResults=10'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data']['books']);
        }
      }
      return [];
    } catch (e) {
      print('Error searching books: $e');
      return [];
    }
  }
  
  // ISBNで本を検索
  static Future<Map<String, dynamic>?> searchBookByISBN(String isbn) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/google-books/isbn/$isbn'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      print('Error searching book by ISBN: $e');
      return null;
    }
  }
  
  // 本の詳細を取得
  static Future<Map<String, dynamic>?> getBookDetails(String volumeId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/google-books/details/$volumeId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      print('Error getting book details: $e');
      return null;
    }
  }
  
  // 本を追加
  static Future<bool> addBook(Map<String, dynamic> bookData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/books'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bookData),
      );
      
      return response.statusCode == 201;
    } catch (e) {
      print('Error adding book: $e');
      return false;
    }
  }
  
  // 本の一覧を取得
  static Future<List<Map<String, dynamic>>> getBooks() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/books'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return List<Map<String, dynamic>>.from(data['data']);
        }
      }
      return [];
    } catch (e) {
      print('Error getting books: $e');
      return [];
    }
  }
}

