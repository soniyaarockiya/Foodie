import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_demo/Admin_Screens/admin_page.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:foodie_demo/Sub_widgets/admin_gridView_builder.dart';

final _fireStore = Firestore.instance;

class LiveOrders extends StatefulWidget {
  @override
  _LiveOrdersState createState() => _LiveOrdersState();
}

class _LiveOrdersState extends State<LiveOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Order'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection('AdminOrderCopy').snapshots(),
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
              final itemAddress = item.data['address'];
              final itemUserId = item.data['userId'];
              final itemOrderId = item.data['orderId'];

              final itemSingle = ItemModel.status(
                  itemName: itemName,
                  itemImage: itemImage,
                  itemPrice: itemPrice,
                  itemStatus: itemStatus,
                  address: itemAddress,
                  userID: itemUserId,
                  orderId: itemOrderId);
              itemModel.add(itemSingle);
            }

            return AdminGridViewBuild(items: itemModel);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminPage(),
              ));
        },
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPage(),
                ));
          },
        ),
      ),
    );
  }
}
