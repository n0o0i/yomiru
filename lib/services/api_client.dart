import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/book_relation.dart';
import 'config_service.dart';
import 'dart:io' show Platform;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yomiru/utils/logger.dart';

class ApiClient {
  SupabaseClient get _supabase => Supabase.instance.client;

  late Dio _dio;
  static String get _baseUrl {
    String base = ConfigService.apiBaseUrl;

    if (base.contains('localhost')) {
      if (Platform.isAndroid) {
        // Androidの場合のみ置換
        base = base.replaceAll('localhost', '10.0.2.2');
      } else if (Platform.isIOS) {
        // iOSの場合、localhostのまま (置換しない)
      }
    }
      
    String finalUrl = base.endsWith('/v1') ? base : '$base/v1';
    return finalUrl;
  }

  final _strage = const FlutterSecureStorage();

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl, // getter を呼び出す
      connectTimeout: const Duration(seconds: 30), // タイムアウトを長めに設定
      receiveTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final session = _supabase.auth.currentSession;
        final token = session?.accessToken;

        if(token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        } 
        return handler.next(options);
      }
    ));
  }

  Future<void> signUp(String email, String password) async {
    try {
      final response = await _dio.post('/auth/isAvailable', data: {
        'column': 'email',
        'value': email,
      });

      await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'http://localhost:8787/api/v1/auth/callback'
      );
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'サインアップに失敗しました';
    }
  }

  Future<void> createProfile (String userId, String displayName) async {
    try {
      final response = await _dio.post('/auth/isAvailable', data: {
        'column': 'user_id',
        'value': userId,
      });
      
      final user = _supabase.auth.currentUser;

      await _dio.post('/auth/createProfile', data: {
        'id': user!.id,
        'userId': userId,
        'displayName': displayName,
        'email': user.email
      });
    } on DioException catch(e) {
      throw e.message.toString();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password
      );
    } on AuthException catch (error) {
        throw Exception(error.message);
    }

      // try {
      //   final response = await _dio.post('/auth/login', data: {
      //     'email': email,
      //     'password': password,
      //   });

      //   if(response.statusCode == 200) {
      //     final session = response.data['session'];
      //     if (session != null && 
      //         session['access_token'] != null &&
      //         session['refresh_token'] != null) {
      //       await _strage.write(key: 'access_token', value: session['access_token']);
      //       await _strage.write(key: 'refresh_token', value: session['refresh_token']);
      //     }
      //   } else {
      //     throw Exception('Failed to sign in');
      //   }
      // } on DioException catch (e) {
      //   print('Dio Error: ${e.response?.data}');
      //   print('Status code: ${e.response?.statusCode}');

      //   final String errorMessage = e.response?.data['message'] ?? 'サインインに失敗しました';
      //   throw Exception(errorMessage);
      // } catch (e) {
      //   print('Unknown error: $e');
      //   throw Exception('予期せぬエラーが発生しました');
      // }
  }

  Future<void> logout() async {
    try {
      Log.i('User requested sign out');
      await _supabase.auth.signOut();
    } catch (e) {
      Log.e('Sign out failed', e);
    }
  }

  Future<List<BookRelation>> fetchMyBooks() async {
    try {
      final response = await _dio.get('/mybooks');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => BookRelation.fromJson(json)).toList();
      } 
      throw Exception('Failed to load books'); 
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized: session expired or invalid token');
      }
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    final session = _supabase.auth.currentSession;

    return session != null && !session.isExpired;
  }
}