import 'package:flutter/material.dart';
import 'package:foodie_demo/Controller/auth.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:foodie_demo/Sub_widgets/drawer.dart';
import 'package:foodie_demo/Sub_widgets/gridView_card.dart';
import 'package:foodie_demo/User_Screens/item_click.dart';

class Home extends StatefulWidget {
  final VoidCallback onSignedOutHome;
  final BaseAuth auth;


  Home({this.auth, this.onSignedOutHome});

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  String email;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //TODO: try adding an icon like spoon instead of text here
        title: Icon(
          Icons.star,
        ),

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
      drawer: DrawerMenu(
          auth: widget.auth,
          signOutSelected: () {
            widget.onSignedOutHome();
          }

      ),

      //ADD GRID VIEW IN BODY
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // crossAxisSpacing: 10,
            // mainAxisSpacing: 10
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ItemClick(itemModel: (items[index]))));
              },
              child: GridCard(items[index]),
            );
          }),
    );
  }

}

