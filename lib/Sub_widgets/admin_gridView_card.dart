import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';

class AdminGridCard extends StatelessWidget {
  final ItemModel itemModel;

  AdminGridCard({this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            // IMAGE --FIRST CARD COMPONENT
            Container(
              child: Image.network(
                itemModel.itemImage,
                //fit: BoxFit.fitHeight,
              ),
              height: 100.0,
            ),

            //TEXT--ITEM PRICE--THIRD CARD COMPONENT

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  itemModel.itemName,
                ),
                Text(
                  itemModel.itemPrice,
                ),
              ],
            ),

            Text(itemModel.address),

            Text(itemModel.itemStatus)

            //TEXT--ITEM NAME --- SECOND CARD COMPONENT
          ],
        ),
      ),
    );
  }
}
