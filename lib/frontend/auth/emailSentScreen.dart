import 'package:flutter/material.dart';
import 'package:yomiru/services/api_client.dart';

class EmailSentPage extends StatefulWidget {
  const EmailSentPage({super.key});

  @override
  State<EmailSentPage> createState() => _EmailSentPage();
}

class _EmailSentPage extends State<EmailSentPage> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _displayNameController = TextEditingController();
  bool _isLoading = false;
  final ApiClient _apiClient = ApiClient();

  Future<void> _createProfile() async {
    if(!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true,);

    try {
      await _apiClient.createProfile(_userIdController.text, _displayNameController.text);

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました'))
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('メールアドレス確認')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/icons/yomiru_icon.png',
                width: 120,
                height: 120,
              ),
              const Text(
                '確認メールを送付しました。\nメール本文のリンクをクリックして\n登録を完了してください。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                  ),),
              const SizedBox(height: 32,),
            ],
          ),
        ),
        ),
    );
  }
}