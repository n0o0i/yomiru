import 'package:flutter/material.dart';
import 'package:yomiru/frontend/homePage.dart';
import 'package:yomiru/services/hive_service.dart';
import 'package:yomiru/services/config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 設定サービスの初期化
  await ConfigService.init();
  await ConfigService.loadDefaultConfig();
  
  // Hiveの初期化
  await HiveService.init();
  
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
    ),
    themeMode: ThemeMode.system, // システムの設定に従う
    home: HomePage(),
  ));
}