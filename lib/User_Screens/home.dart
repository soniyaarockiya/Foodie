import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:foodie_demo/Sub_widgets/drawer.dart';
import 'package:foodie_demo/Sub_widgets/gridView_card.dart';

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

        //ADD FAV AND NOTIFICATIONS ICON (USE STACK FOR NOTIFY)
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            onPressed: null,
          ),
          Stack(
            //ALIGNMENT IS IMPORTANT FOR NOTIFICATION ICON
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

      //DRAWER WIDGET ADDED FROM drawer.dart(Sub_widgets pkg)
      drawer: DrawerMenu(),

      //ADD GRID VIEW IN BODY
      body: GridView.builder(
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GridCard(items[index]);
          }),
    );
  }
}
