import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class UserItemClick extends StatefulWidget {
  final ItemModel itemModel;

  // ItemClick({this.itemImage, this.itemName, this.itemPrice});
  UserItemClick({this.itemModel});

  @override
  _UserItemClickState createState() => _UserItemClickState();
}

class _UserItemClickState extends State<UserItemClick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Item Detail',
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Image(
                image: NetworkImage(widget.itemModel.itemImage),
              ),
              height: 200.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(widget.itemModel.itemName),
                Text(widget.itemModel.itemPrice)
              ],
            ),
//            Text(widget.itemModel.address),
            Text(widget.itemModel.itemStatus)
          ],
        ));
  }
}
