import 'package:shared_preferences/shared_preferences.dart';

class ConfigService {
  static SharedPreferences? _prefs;
  
  // 初期化
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // API設定
  // static String get apiBaseUrl => _prefs?.getString('api_base_url') ?? 'http://localhost:8787/';
  static String get apiBaseUrl => 'http://localhost:8787/api';
  static String get googleBooksApiKey => _prefs?.getString('google_books_api_key') ?? '';
  
  // アプリ設定
  static String get appName => _prefs?.getString('app_name') ?? 'Yomiru';
  static String get appVersion => _prefs?.getString('app_version') ?? '1.0.0';
  static bool get debugMode => _prefs?.getBool('debug_mode') ?? true;
  
  // ストレージ設定
  static bool get localStorageEnabled => _prefs?.getBool('local_storage_enabled') ?? true;
  static bool get syncEnabled => _prefs?.getBool('sync_enabled') ?? true;
  static bool get offlineMode => _prefs?.getBool('offline_mode') ?? true;
  
  // 機能フラグ
  static bool get enableGoogleBooks => _prefs?.getBool('enable_google_books') ?? true;
  static bool get enableLocalStorage => _prefs?.getBool('enable_local_storage') ?? true;
  static bool get enableOfflineSync => _prefs?.getBool('enable_offline_sync') ?? true;
  
  // 設定の保存
  static Future<void> setApiBaseUrl(String url) async {
    await _prefs?.setString('api_base_url', url);
  }
  
  static Future<void> setGoogleBooksApiKey(String key) async {
    await _prefs?.setString('google_books_api_key', key);
  }
  
  static Future<void> setDebugMode(bool enabled) async {
    await _prefs?.setBool('debug_mode', enabled);
  }
  
  static Future<void> setLocalStorageEnabled(bool enabled) async {
    await _prefs?.setBool('local_storage_enabled', enabled);
  }
  
  static Future<void> setSyncEnabled(bool enabled) async {
    await _prefs?.setBool('sync_enabled', enabled);
  }
  
  static Future<void> setOfflineMode(bool enabled) async {
    await _prefs?.setBool('offline_mode', enabled);
  }
  
  // デフォルト設定の読み込み
  static Future<void> loadDefaultConfig() async {
    if (_prefs?.getString('api_base_url') == null) {
      await setApiBaseUrl('http://localhost:8787');
    }
    if (_prefs?.getString('app_name') == null) {
      await _prefs?.setString('app_name', 'Yomiru');
    }
    if (_prefs?.getString('app_version') == null) {
      await _prefs?.setString('app_version', '1.0.0');
    }
    if (_prefs?.getBool('debug_mode') == null) {
      await setDebugMode(true);
    }
    if (_prefs?.getBool('local_storage_enabled') == null) {
      await setLocalStorageEnabled(true);
    }
    if (_prefs?.getBool('sync_enabled') == null) {
      await setSyncEnabled(true);
    }
    if (_prefs?.getBool('offline_mode') == null) {
      await setOfflineMode(true);
    }
    if (_prefs?.getBool('enable_google_books') == null) {
      await _prefs?.setBool('enable_google_books', true);
    }
    if (_prefs?.getBool('enable_local_storage') == null) {
      await _prefs?.setBool('enable_local_storage', true);
    }
    if (_prefs?.getBool('enable_offline_sync') == null) {
      await _prefs?.setBool('enable_offline_sync', true);
    }
  }
}




