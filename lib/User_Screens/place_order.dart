import 'dart:math';
import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseUser loggedInUser;
String emailFinal;
String userIdFinal;
String orderIdFinal;

class PlaceOrder extends StatefulWidget {
  final ItemModel itemModel;

// final BaseAuth auth = Auth();

  PlaceOrder({this.itemModel});

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  String userAddress;
  TextEditingController userAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    inputData();
  }

  Future<String> inputData() async {
    try {
      //onAuthStateChanged is important , nothing else works
      await FirebaseAuth.instance.onAuthStateChanged
          .firstWhere((user) => user != null)
          .then((user) {
        loggedInUser = user;
        emailFinal = loggedInUser.email.toString();
        userIdFinal = loggedInUser.uid.toString();
      });
    } catch (e) {}
    print("error in drwer user email retrieval:$e");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text('Place Order'),
      ),
      body: Column(
        children: <Widget>[
          Image(
            image: NetworkImage(widget.itemModel.itemImage),
            height: 50.0,
          ),
          Row(
            children: <Widget>[
              Text(widget.itemModel.itemName),
              Text(widget.itemModel.itemPrice),
            ],
          ),
          TextFormField(
            controller: userAddressController,
            decoration: InputDecoration(
              labelText: 'Enter your address',
            ),
            validator: (value) => value.isEmpty ? 'Email cant be empty' : null,
            onSaved: (value) => userAddress = value,
          ),
          RaisedButton(
            onPressed: placeOrder,
            child: Text('Place Order'),
          )
        ],
      ),
    );
  }

  void placeOrder() async {
    orderIdFinal = randomString(5);
    print('Random string : $orderIdFinal');

    try {
      await Firestore.instance
          .collection("Orders")
          .document(userIdFinal)
          .collection('EachUserOrders')
          .document(orderIdFinal)
          .setData({
        'name': widget.itemModel.itemName,
        'price': widget.itemModel.itemPrice,
        'image': widget.itemModel.itemImage,
        'address': userAddressController.text,
        'orderStatus': 'waiting',
        'userId': userIdFinal,
        'orderId': orderIdFinal
      });

      await Firestore.instance
          .collection("AdminOrderCopy")
          .document(orderIdFinal)
          .setData({
        'name': widget.itemModel.itemName,
        'price': widget.itemModel.itemPrice,
        'image': widget.itemModel.itemImage,
        'address': userAddressController.text,
        'orderStatus': 'waiting',
        'userId': userIdFinal,
        'orderId': orderIdFinal
      });

      print(("ordered successfully $userIdFinal  and $emailFinal"));
    } catch (e) {
      print("Error while ordering: $e");
    }
  }
}
