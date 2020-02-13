import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie_demo/Controller/auth.dart';

class DrawerMenu extends StatefulWidget {
  final BaseAuth auth;
  final signOutSelected;

  DrawerMenu({this.auth, this.signOutSelected});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  void logout() async {
    try {
      await widget.auth.signOut();
      widget.signOutSelected();
    } catch (e) {
      print("Errror while logging out : $e");
    }
  }

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
                  'Soniya Arockiya'),
              accountEmail: Text(
                'soniya@gmail.com',
              )),

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
            title: Text('Log out'),
            onTap: () {
              //THIA LINE CLOSES THE DRAWER BEFORE LOGIN OUT(I.E CHANGING THE WIDGET--- other
              // wise it gives this error-->setState() or markNeedsBuild() called when widget tree was locked.)
              Navigator.pop(context);

              logout();
              //signOutSelected();
            },
          ),
        ],
      ),
    );
  }
}
