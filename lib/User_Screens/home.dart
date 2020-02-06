import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //TODO: try adding an icon like spoon instead of text here
        title: Text('Hey Foodie !'),

        //Add favourite and notification icons (use stack fo notifications)
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            onPressed: null,
          ),
          Stack(
            //alignment is important for notifications icon
            alignment: Alignment.centerLeft,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                ),
                onPressed: null,
              ),
              CircleAvatar(
                radius: 10.0,
                child: Text('0'),
              )
            ],
          )
        ],
      ),
    );
  }
}
