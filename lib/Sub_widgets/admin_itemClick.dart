import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminItemClick extends StatefulWidget {
  final ItemModel itemModel;

  // ItemClick({this.itemImage, this.itemName, this.itemPrice});
  AdminItemClick({this.itemModel});

  @override
  _AdminItemClickState createState() => _AdminItemClickState();
}

class _AdminItemClickState extends State<AdminItemClick> {
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
            Text(widget.itemModel.address),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: acceptOrder,
                  child: Text('Accept Order'),
                )
              ],
            )
          ],
        ));
  }

  //Update order history for user by setting status as accepted
  // and delete the order from live order screen (admin screen)
  void acceptOrder() async {
    try {
      //delete from live screen
      await Firestore.instance
          .collection('AdminOrderCopy')
          .document(widget.itemModel.orderId)
          .delete();

      String userId = widget.itemModel.userID;
      String ORDERId = widget.itemModel.orderId;
      print(userId);
      print(ORDERId);

      //update user order history
      await Firestore.instance
          .collection('Orders')
          .document(userId)
          .collection('EachUserOrders')
          .document(ORDERId)
          .updateData({
        'orderStatus': 'Order accepted, vendor will contact you shortly'
      });
      print("item sa");
    } catch (e) {
      print(e);
    }
  }
}
