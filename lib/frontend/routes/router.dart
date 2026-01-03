import 'package:flutter/material.dart';
import 'package:yomiru/frontend/auth/auth_check_screen.dart';
import 'package:yomiru/frontend/auth/login_screen.dart';
import 'package:yomiru/frontend/auth/profileSettingPage.dart';
import 'package:yomiru/frontend/homePage.dart';
import 'package:yomiru/utils/logger.dart';
import 'package:yomiru/frontend/auth/emailSentScreen.dart';

class AppRouter {
  static const String root = '/';
  static const String login = '/login';
  static const String profileSetup = '/profileSetup';
  static const String home = '/home';
  static const String emailSent = '/emailSent';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final name = settings.name ?? '';

    final isRecoveringSession = name.contains('code=');

    if(name.startsWith('/code?=') || isRecoveringSession) {
      return MaterialPageRoute(
        builder: (_) => AuthCheckScreen(isRecoveringSession: isRecoveringSession,)
      );
    }

    Log.i("Navigating to: ${settings.name}");

    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => const AuthCheckScreen(isRecoveringSession: false,),);
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen(),);
      case profileSetup:
        return MaterialPageRoute(builder: (_) => const ProfileSetupPage(),);
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage(),);
      case emailSent:
        return MaterialPageRoute(builder: (_) => const EmailSentPage(),);
      
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