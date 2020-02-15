import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie_demo/Sub_widgets/user_gridView_builder.dart';

final _fireStore = Firestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseUser loggedInUser;
String emailFinal;
String userIdFinal;
String orderIdFinal;

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<ItemModel> items = [];

  @override
  void initState() {
    super.initState();

    inputDataPlace();
  }

  Future<String> inputDataPlace() async {
    try {
      //onAuthStateChanged is important , nothing else works
      await FirebaseAuth.instance.onAuthStateChanged
          .firstWhere((user) => user != null)
          .then((user) {
        loggedInUser = user;
        emailFinal = loggedInUser.email.toString();
        userIdFinal = loggedInUser.uid.toString();
      });
    } catch (e) {
      print("error in drwer user email retrieval:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore
              .collection("Orders")
              .document(userIdFinal)
              .collection("EachUserOrders")
              .snapshots(),
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
              final itemStatus = item.data['orderStatus'];

              final itemSingle = ItemModel.status(
                itemName: itemName,
                itemImage: itemImage,
                itemPrice: itemPrice,
                itemStatus: itemStatus,
              );

              itemModel.add(itemSingle);
            }

            return UserGridViewBuild(items: itemModel);
          }),
    );
  }
}
