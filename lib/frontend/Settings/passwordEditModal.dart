import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class PasswordEditModal extends StatefulWidget {
  @override
  _ProfileEditModal createState() => _ProfileEditModal();
}

class _ProfileEditModal extends State<PasswordEditModal> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void dispose () {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
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
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: AppStrings.EditPassword),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.NoPasswordInput;
                      }
                      if (value != _passwordConfirmController.text) {
                        return AppStrings.PasswordNotMatched;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _passwordConfirmController,
                    decoration: InputDecoration(labelText: AppStrings.EditPasswordConfirm),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.NoPasswordInput;
                      }
                      if (value != _passwordController.text) {
                        return AppStrings.PasswordNotMatched;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32,),
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