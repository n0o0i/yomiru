import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/strings.dart';

class AccountSettings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Column ( // profile display
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.purple,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            '山田　太郎',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          Text(
                            'ID: xxxxx',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          Text(
                            'xxx@xxx.xxx',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                        ]
                      )
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Divider(),
                      ListTile(
                        title: Text(AppStrings.AccoutSettingsEditProfile),
                      ),
                      Divider(),
                      ListTile(
                        title: Text(AppStrings.AccoutSettingsEditPassword),
                      ),
                      Divider(),
                      ListTile(
                        title: Text(AppStrings.AccoutSettingsTagsPrivacy),
                      ),
                      Divider(),
                      ListTile(
                        title: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),                
                          ),
                          onPressed: (){
                            print('pressed');
                          },
                          child: Text(
                            AppStrings.AccoutSettingsDeliteAccout,
                            style: TextStyle(
                            color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                      )
                    ]
                  )
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