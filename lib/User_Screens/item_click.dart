import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:foodie_demo/User_Screens/place_order.dart';


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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  //todo: add to cart
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PlaceOrder(itemModel: widget.itemModel)
                    ));
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
