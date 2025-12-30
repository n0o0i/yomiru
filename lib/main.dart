import 'package:flutter/material.dart';
import 'package:yomiru/services/config_service.dart';
import 'package:yomiru/frontend/shared/auth_check_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 設定サービスの初期化
  await ConfigService.init();
  await ConfigService.loadDefaultConfig();
  
  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );
  
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
    home: AuthCheckScreen(),
    onGenerateRoute: (settings){
      return MaterialPageRoute(
        builder: (settings) => const AuthCheckScreen()
      );
    },
  ));
}