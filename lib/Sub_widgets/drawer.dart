import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie_demo/Controller/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie_demo/User_Screens/order_history.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseUser loggedInUser;
String emailFinal;
String userIdFinal;

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
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    inputData();
  }

  Future<String> inputData() async {
    try {
      //onAuthstatechanged is important , nothing worked
      await FirebaseAuth.instance.onAuthStateChanged
          .firstWhere((user) => user != null)
          .then((user) {
        loggedInUser = user;
        emailFinal = loggedInUser.email.toString();
        userIdFinal = loggedInUser.uid.toString();
      });
    } catch (e) {
      print(e);
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
                  userIdFinal),
              accountEmail: Text(
                emailFinal,
              )),

          //SECOND PART OF DRAWER MENU
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => OrderHistoryScreen()));
            },
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
