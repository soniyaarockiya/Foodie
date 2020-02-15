import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:foodie_demo/Sub_widgets/user_gridView_card.dart';
import 'package:foodie_demo/Sub_widgets/user_itemClick.dart';

class UserGridViewBuild extends StatefulWidget {
  final List<ItemModel> items;

  UserGridViewBuild({this.items});

  @override
  _UserGridViewBuildState createState() => _UserGridViewBuildState();
}

class _UserGridViewBuildState extends State<UserGridViewBuild> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            //When any item or grid is clicked
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      UserItemClick(itemModel: (widget.items[index]))));
            },

            //Grid View is made of gridCard (tiles)
            child: UserGridCard(itemModel: widget.items[index]),
          );
        });
  }
}
