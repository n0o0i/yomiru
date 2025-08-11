import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/strings.dart';
import 'package:yomiru/frontend/Settings/profileEditModal.dart';
import 'package:yomiru/frontend/Settings/passwordEditModal.dart';
import 'package:yomiru/frontend/Settings/tagPrivacy.dart';

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
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) => ProfileEditModal(),
                          );
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text(AppStrings.AccoutSettingsEditPassword),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) => PasswordEditModal(),
                          );
                        },                        
                      ),
                      Divider(),
                      ListTile(
                        title: Text(AppStrings.AccoutSettingsTagsPrivacy),
                        trailing: TagPrivacy(),
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