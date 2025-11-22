import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class ProfileEditModal extends StatefulWidget {
  const ProfileEditModal({super.key});

  @override
  _ProfileEditModal createState() => _ProfileEditModal();
}

class _ProfileEditModal extends State<ProfileEditModal> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _userIdController = TextEditingController();

  @override
  void dispose () {
    _emailController.dispose();
    _userNameController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      '変更したい箇所を入力してください',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(labelText: AppStrings.EditUserName),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _userIdController,
                    decoration: InputDecoration(labelText: AppStrings.EditUserId),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: AppStrings.EditEMail),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if(value?.isNotEmpty ?? false) {
                        if (!emailRegex.hasMatch(value!)){
                          return 'correct email';
                        }
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()){
                          Navigator.pop(context);
                      }
                    }, 
                    child: Text('Done')
                  )
                ],
              ) 
            ),
          )
        ]
      ),
    ); 
  }

}