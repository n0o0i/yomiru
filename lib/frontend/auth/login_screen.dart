import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yomiru/services/api_client.dart';
import '../homePage.dart';
import 'signUpPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  bool _isLoading = false;
  bool _isLoginFailed = false;
  String _errorMessage = '';

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    try {
      await _apiClient.login(_emailController.text, _passwordController.text);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      if (mounted) {
          // SnackBar(content: Text('ログイン失敗: ${e.toString()}')),
        setState(() => _isLoginFailed = true,);
        setState(() => _errorMessage = e.toString(),);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _goToSignUpPage() {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text(
      //       'Yomiru', 
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold
      //       ),)
      //   ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child:          
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 20,),
                Image.asset(
                  'assets/icons/yomiru_icon.png',
                  width: 120,
                  height: 120,
                ),
                const Text(
                  'Yomiru',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5
                  ),
                ),
                // Spacer(),
                const SizedBox(height: 16,),
                const Text(
                  'ログイン',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40,),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'メールアドレス', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  obscureText: true,
                ),
                if(_isLoginFailed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _errorMessage,                    
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      // fontSize: 24
                    ),
                  )
                ),
                const SizedBox(height: 32),
                _isLoading 
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _handleLogin, 
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color.fromRGBO(237, 115, 59, 1.0)
                    ),
                    child: const Text(
                      'ログイン',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                const Spacer(flex: 2,),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      const TextSpan(text: 'アカウントをお持ちでないですか？ '),
                      TextSpan(
                        text: '登録する',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _goToSignUpPage();
                        }
                      )
                    ]
                  ),
                )  
              ],
            ),
        ),
      )
    );
  }
}