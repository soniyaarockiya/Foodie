import 'package:flutter/material.dart';
import 'package:foodie_demo/Controller/auth.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:foodie_demo/Sub_widgets/drawer.dart';
import 'package:foodie_demo/Sub_widgets/gridView_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//firestore instance
final _fireStore = Firestore.instance;

class Home extends StatefulWidget {
  final VoidCallback onSignedOutHome;
  final BaseAuth auth;

  Home({this.auth, this.onSignedOutHome});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String email;
  List<ItemModel> items = [];

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
          }),

      //ADD GRID VIEW IN BODY
      body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection('items').snapshots(),
          builder: (context, snapshot) {
            //When snapshot has no data
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }

            List<ItemModel> itemModel = [];

            final items = snapshot.data.documents;
            for (var item in items) {
              final itemName = item.data['name'];
              final itemPrice = item.data['price'];
              final itemImage = item.data['image'];

              final itemSingle = ItemModel.items(
                  itemName: itemName,
                  itemImage: itemImage,
                  itemPrice: itemPrice);
              itemModel.add(itemSingle);
            }


            return GridViewBuild(items: itemModel);
          }),
    );
  }
}
