import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';


//todo: work on the ui
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
            Container(
              child: Image(
                image: NetworkImage(widget.itemModel.itemImage),
              ),
              height: 200.0,
            ),
            Row(
              children: <Widget>[
                Text(widget.itemModel.itemName),
                Text(widget.itemModel.itemPrice)
              ],
            ),

            Row(
              children: <Widget>[
                FlatButton(
                  //todo: add to cart
                  onPressed: () {
                    print('added to cart');
                  },
                  child: Text(
                      'Buy Now'

                  ),

                ),

                FlatButton(
                  onPressed: () {
                    //todo: add to fav list func
                    print('added to fav');
                  },
                  child: Text(
                      'Add to favourites'
                  ),
                )
              ],
            )
          ],
        ));
  }
}
