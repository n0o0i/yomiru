import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookHorizonalList.dart';
import 'package:yomiru/frontend/Friends/friendDetailsView.dart';


class ContentsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
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
                                      height: screenHeight * 0.05,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        "もっと見る >", 
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
                height: screenHeight * 0.17,
                child: BookHorizonaLlist()
              )
            ],
          ) 
        );
      },
    );
  }
}