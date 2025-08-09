import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class AccountSettings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.purple,
                )
              ]
            ),
          ),
          SizedBox(height: 100,)
        ],
      )
    );
  }
}