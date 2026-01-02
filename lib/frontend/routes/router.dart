import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/auth_check_screen.dart';
import 'package:yomiru/frontend/shared/login_screen.dart';
import 'package:yomiru/frontend/shared/profileSettingPage.dart';
import 'package:yomiru/frontend/homePage.dart';
import 'package:yomiru/utils/logger.dart';

class AppRouter {
  static const String root = '/';
  static const String login = '/login';
  static const String profileSetup = '/profileSetup';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Log.i("Navigating to: ${settings.name}");

    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => const AuthCheckScreen(),);
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen(),);
      case profileSetup:
        return MaterialPageRoute(builder: (_) => const ProfileSetupPage(),);
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage(),);
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          )
        );
    }
  }
}