import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          //FIRST PART OF DRAWER MENU
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.person,
              ),
            ),
            accountName: Text(
              //dummy data
              'Soniya Arockiya',
            ),
            accountEmail: Text('soniya@gmail.com'),
          ),

          //SECOND PART OF DRAWER MENU
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.history),
            ),
            title: Text('Order History'),
          ),

          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.info),
            ),
            title: Text('About us '),
          ),

          //THIRD PART OF DRAWER MENU
          Divider(
            height: 20.0,
          ),

          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.exit_to_app),
            ),
            title: Text('Log in / Log out'),
          ),
        ],
      ),
    );
  }
}
