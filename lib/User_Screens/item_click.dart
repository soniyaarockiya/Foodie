import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';

class ItemClick extends StatefulWidget {
  final ItemModel itemModel;

  // ItemClick({this.itemImage, this.itemName, this.itemPrice});
  ItemClick({this.itemModel});

  @override
  _ItemClickState createState() => _ItemClickState();
}

class _ItemClickState extends State<ItemClick> {
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
          children: <Widget>[
            Image(
              image: NetworkImage(widget.itemModel.itemImage),
            ),
            Row(
              children: <Widget>[
                Text(widget.itemModel.itemName),
                Text(('${widget.itemModel.itemPrice}'))
              ],
            ),
          ],
        ));
  }
}
