import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yomiru/services/api_client.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
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
      appBar: AppBar(title: const Text('プロフィール作成')),
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
              const Text('yomiruへようこそ！\nあなたのプロフィールを作成します。',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                  ),),
              const SizedBox(height: 32,),

              TextFormField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  labelText: 'ユーザID',
                  prefixText: '@',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) return '必須入力です';
                  if(!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) return '英数字をアンダースコアのみ使用可能です';
                  return null;
                },
              ),
              const SizedBox(height: 20,),

              TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: '表示名',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty) ? '必須入力です': null,
              ),
              const SizedBox(height: 40,),

              ElevatedButton(
                onPressed: _isLoading ? null : _createProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color.fromRGBO(237, 115, 59, 1.0),
                  ),
                child: _isLoading
                ? const CircularProgressIndicator()
                : const Text(
                  'はじめる',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                    ),))
            ],
          ),
        ),
        ),
    );
  }
}