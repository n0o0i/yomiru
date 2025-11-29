import 'package:flutter/material.dart';
import 'package:yomiru/services/api_client.dart';
import '../homePage.dart';
import 'login_screen.dart';

class AuthCheckScreen extends StatelessWidget{
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: ApiClient().isAuthenticated(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
          return const Center(child: Text('認証チェック中にエラーが発生しました'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final bool isLoggedIn = snapshot.data ?? false;

          if (isLoggedIn) {
            return const HomePage();
          } else {
            return const LoginScreen();
          }
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
    );
  }
}