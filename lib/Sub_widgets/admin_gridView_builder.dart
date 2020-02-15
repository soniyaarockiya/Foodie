import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:foodie_demo/Sub_widgets/admin_gridView_card.dart';
import 'package:foodie_demo/Sub_widgets/admin_itemClick.dart';

class AdminGridViewBuild extends StatefulWidget {
  final List<ItemModel> items;

  AdminGridViewBuild({this.items});

  @override
  _AdminGridViewBuildState createState() => _AdminGridViewBuildState();
}

class _AdminGridViewBuildState extends State<AdminGridViewBuild> {
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
                      AdminItemClick(itemModel: (widget.items[index]))));
            },

            //Grid View is made of gridCard (tiles)
            child: AdminGridCard(itemModel: widget.items[index]),
          );
        });
  }
}
