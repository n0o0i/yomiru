import 'package:flutter/material.dart';
import 'package:yomiru/services/config_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yomiru/frontend/routes/router.dart';
import 'package:yomiru/utils/logger.dart';

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
  
  Log.i('🚀 App Started with Supabase PKCE Flow');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'yomiru',
      theme: ThemeData(
        brightness: Brightness.light,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   splashFactory: NoSplash.splashFactory,
      //   highlightColor: Colors.transparent,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Colors.blue,
      //     brightness: Brightness.dark,
      //   ),
      // ),
      themeMode: ThemeMode.light,
      initialRoute: AppRouter.root,
      onGenerateRoute: AppRouter.generateRoute,

      debugShowCheckedModeBanner: false,
    );
  }
}