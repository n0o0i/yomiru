import 'package:flutter/material.dart';
import 'package:yomiru/frontend/Friends/friendDetailsView.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return Material(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FriendDetailsView()) 
                );
            },
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.purple[100],
                      // child: Icon(Icon.person),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(
                            fontSize: 10
                          ),
                        ),
                        Text(
                          '@userID',
                          style: TextStyle(
                            fontSize: 10
                          ),
                        ),
                      ]
                    ),
                  ]
                ),
                SizedBox(height: 10),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ],
            ),
          )
        );
      },
    );
  }
}