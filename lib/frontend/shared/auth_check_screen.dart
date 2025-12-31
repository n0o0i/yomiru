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
      if(!mounted) return;

      final session = data.session;
      final event = data.event;

      if(session != null){
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()), 
          (route) => false
        );
      }
      else if(event == AuthChangeEvent.initialSession || event == AuthChangeEvent.signedOut) {
        if(mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}