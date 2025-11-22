import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookDetails copy.dart';

class TimeLineView extends StatelessWidget {
  const TimeLineView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index){
        return Container(
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
                        '@userID xxxx/xx/xx',
                        style: TextStyle(
                          fontSize: 10
                        ),
                      ),
                    ]
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShrinkingWidget())
                      );
                    },
                    child: SizedBox(
                      width: 80,
                      height: 120,
                      child: Card(
                        color: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ],
          ),
        );
      }
    );
  }
}