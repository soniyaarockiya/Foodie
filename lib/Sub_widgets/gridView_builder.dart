import 'package:flutter/material.dart';
import 'package:foodie_demo/Model/item_model_pojo.dart';
import 'package:foodie_demo/Sub_widgets/gridView_card.dart';
import 'package:foodie_demo/User_Screens/item_click.dart';

class GridViewBuild extends StatefulWidget {
  final List<ItemModel> items;

  GridViewBuild({this.items});

  @override
  _GridViewBuildState createState() => _GridViewBuildState();
}

class _GridViewBuildState extends State<GridViewBuild> {
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
                      ItemClick(itemModel: (widget.items[index]))));
            },

            //Grid View is made of gridCard (tiles)
            child: GridCard(widget.items[index]),
          );
        });
  }
}
