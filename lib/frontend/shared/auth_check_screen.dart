// import 'dart:async';
import 'package:flutter/material.dart';
// import '../homePage.dart';
// import 'login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yomiru/utils/logger.dart';

class AuthCheckScreen extends StatefulWidget{
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState(){
    super.initState();
    _handleAuthTransition();
  }

  void _handleAuthTransition() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      if(!mounted) return;

      final session = data.session;
      Log.i('Auth Event: ${data.event}');

      if(session == null) {
        Log.d('No session. Redirecting to Login Screen');
        _navigateTo('/login');
        return;
      }

      Log.d('Session found. Checking profile for user: ${session.user.id}');

      try {
        final profile = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', session.user.id)
          .maybeSingle();

        if(profile == null) {
          Log.w('Profile not found. Redirecting to ProfileSetup');
          _navigateTo('/profileSetup');
        } else {
          Log.i('Profile exist. Redirecting to Home');
          _navigateTo('/home');
        }
      } catch (e) {
        Log.e('Failed to fetch profile', e);
        _navigateTo('/login');
      }
    });
  }

  void _navigateTo(String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // StreamSubscription<AuthState>? _authSubScription;

  // @override
  // void initState() {
  //   super.initState();

  //   _authSubScription = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
  //     if(!mounted) return;

  //     final session = data.session;
  //     final event = data.event;

  //     if(session != null){
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => const HomePage()), 
  //         (route) => false
  //       );
  //     }
  //     else if(event == AuthChangeEvent.initialSession || event == AuthChangeEvent.signedOut) {
  //       if(mounted) {
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => const LoginScreen()),
  //           (route) => false,
  //         );
  //       }
  //     }
  //   });
  // }
  
  // @override
  // void dispose(){
  //   _authSubScription?.cancel();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return const Scaffold(
  //     body: Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }
}