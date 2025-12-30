import 'dart:async';
import 'package:flutter/material.dart';
import '../homePage.dart';
import 'login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCheckScreen extends StatefulWidget{
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  StreamSubscription<AuthState>? _authSubScription;

  @override
  void initState() {
    super.initState();

    _authSubScription = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      print("Auth Event: ${data.event}");
      final session = data.session;
      final event = data.event;

      if((event == AuthChangeEvent.signedIn || session != null) && session != null) {
        if(mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        }
      }
    });
  }
  
  @override
  void dispose(){
    _authSubScription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null){
      return const HomePage();
    } else {
      return const LoginScreen();
    }
  }

}