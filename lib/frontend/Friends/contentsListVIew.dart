import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookHorizonalList.dart';
import 'package:yomiru/frontend/Friends/friendDetailsView.dart';
import 'package:yomiru/frontend/shared/strings.dart';


class ContentsListView extends StatelessWidget {
  const ContentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Material( 
                child:InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FriendDetailsView())
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.purple[100],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Material(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
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
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        AppStrings.bookListSectionListMore,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,)
                                  ],
                                ),
                              ),
                            ]
                          )
                        )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 120,
                child: BookHorizonaLlist()
              )
            ],
          ) 
        );
      },
    );
  }
}