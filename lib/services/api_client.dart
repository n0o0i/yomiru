import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/book_relation.dart';
import 'config_service.dart';
import 'dart:io' show Platform;

class ApiClient {
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
  print('DEBUG: ApiClient Base URL is: $finalUrl'); // ★ これを追記
  return finalUrl;
    // return base.endsWith('/v1') ? base : '$base/v1';
  }



  // static const String _baseUrl = 'http://10.0.2.2:3000/api/v1';// ★ エミュレータからPCのローカルホストにアクセスするためのIP
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
        final token = await _strage.read(key: 'jwt_token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<void> signIn(String email, String password) async {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if(response.statusCode == 200) {
        final session = response.data['session'];
        if (session != null && session['access_token'] != null) {
          await _strage.write(key: 'jwt_token', value: session['access_token']);
        }
      } else {
        throw Exception('Failed to sign in');
      }
  }

  Future<void> logout() async {
    await _strage.delete(key: 'jwt_token');
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
    final token = await _strage.read(key: 'jwt_token');

    return token != null;
  }
}