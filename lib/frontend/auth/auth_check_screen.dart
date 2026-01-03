// import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
// import '../homePage.dart';
// import 'login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yomiru/utils/logger.dart';

class AuthCheckScreen extends StatefulWidget{
  final bool isRecoveringSession;
  const AuthCheckScreen({super.key, this.isRecoveringSession = false});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  StreamSubscription<AuthState>? _authSubscription;
  
  @override
  void initState(){
    super.initState();
    _handleAuthTransition();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    Log.d('AuthCheckScreen disposed: Auth listener cancelled.');
    super.dispose();
  }


  Future<void> _checkProfileAndNavigate(String userId) async {
      try {
        final profile = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

        if(!mounted) return;

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
  }

  void _handleAuthTransition() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      if(!mounted) return;

      final session = data.session;
      final event = data.event;
      Log.i('Auth Event: ${session}');
      Log.i('Auth Event: ${event}');

      if (session != null && (event == AuthChangeEvent.signedIn || event == AuthChangeEvent.initialSession)) {
        await _checkProfileAndNavigate(session.user.id);
        return;
      }

      if(event == AuthChangeEvent.initialSession && session == null) {
        if (!widget.isRecoveringSession){
          Log.d('No session. Redirecting to Login Screen');
          _navigateTo('/login');
        } else {
          Log.d('Waiting for processing the authentication code...');
        }
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
}