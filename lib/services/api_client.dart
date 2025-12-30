import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/book_relation.dart';
import 'config_service.dart';
import 'dart:io' show Platform;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // final Dio _dio = Dio(BaseOptions(baseUrl: _baseUrl));
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
  //       final token = await _strage.read(key: 'access_token');

  //       if (token != null) {
  //         options.headers['Authorization'] = 'Bearer $token';
  //       }
  //       return handler.next(options);
  //     },

  //     onError: (DioException error, handler) async {
  //       if (error.response?.statusCode == 401 && error.requestOptions.path != '/auth/token/refresh') {
  //         final refreshToken = await _strage.read(key: 'refresh_Token');

  //         if (refreshToken == null) {
  //           await logout();
  //           return handler.reject(error);
  //         }

  //         try {
  //           final refreshResponse = await _dio.post(
  //             '/auth/token/refresh',
  //             data: {'refresh_token': refreshToken},
  //           );

  //           final newAccessToken = refreshResponse.data['access_token'];
  //           final newRefreshToken = refreshResponse.data['refresh_token'];

  //           await _strage.write(key: 'access_token', value: newAccessToken);
  //           await _strage.write(key: 'refresh_token', value: newRefreshToken);

  //           final RequestOptions requestOptions = error.requestOptions;
  //           requestOptions.headers['Authentication'] = 'Bearer $newAccessToken';

  //           return handler.resolve(await _dio.fetch(requestOptions));
  //         } catch (e) {
  //           await logout();
  //           return handler.reject(error);
  //         }
  //       }
  //       return handler.next(error);
      }
    ));
  }

  Future<void> signUp(String email, String password, String userId) async {
    try {
      final response = await _dio.post('/auth/signup', data: {
        'email': email,
        'password': password,
        'userId': userId
      });
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'サインアップに失敗しました';
    }
  }

  Future<void> login(String email, String password) async {
      try {
        final response = await _dio.post('/auth/login', data: {
          'email': email,
          'password': password,
        });

        if(response.statusCode == 200) {
          final session = response.data['session'];
          if (session != null && 
              session['access_token'] != null &&
              session['refresh_token'] != null) {
            await _strage.write(key: 'access_token', value: session['access_token']);
            await _strage.write(key: 'refresh_token', value: session['refresh_token']);
          }
        } else {
          throw Exception('Failed to sign in');
        }
      } on DioException catch (e) {
        print('Dio Error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');

        final String errorMessage = e.response?.data['message'] ?? 'サインインに失敗しました';
        throw Exception(errorMessage);
      } catch (e) {
        print('Unknown error: $e');
        throw Exception('予期せぬエラーが発生しました');
      }
  }

  Future<void> logout() async {
    // FIXME!!!! add backend for logout

    await _strage.delete(key: 'access_token');
    await _strage.delete(key: 'refresh_token');
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