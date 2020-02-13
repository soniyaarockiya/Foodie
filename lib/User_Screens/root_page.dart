import 'package:flutter/material.dart';
import 'package:foodie_demo/User_Screens/home.dart';
import 'login_page.dart';
import 'package:foodie_demo/Controller/auth.dart';

class RootPage extends StatefulWidget {
  //ROOT PAGE TAKES AUTH INSTANCE , SO AS TO CHECK IF USER IS LOGGED IN OR NOT ...SEE INIT STATE
  final BaseAuth auth;

  RootPage({this.auth});

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  //AUTH STAT IS SET TO NOT SIGNED IN BY DEFAULT ,
  // BUT THIS MIGHT OR MIGHT NOT CHANGE WHEN INIT STATE IS CALLED
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  //INIT STATE IS CALLED  BEFORE THE BUILD , HENCE WE CHECK THE STATUS OF THE USER
  // HERE FIRST AND ACCORDINGLY DISPLAY THE RELEVANT SCREEN
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //ROOT PAGE CHECKS IF USER IS LOGGED IN OR NOT AND ACCORDINGLY CHANGES THE AUTH STATUS VAR ,
    // THEN THE BUILD METHOD IS CALLED

    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      //IF USER IS NOT LOGGED IN , OPEN LOGIN SCREEN
      case AuthStatus.notSignedIn:
        return LoginPage(auth: widget.auth, onSignedIn: _signedIn);
      //IF USER IS LOGGED IN , OPEN HOME SCREEN
      case AuthStatus.signedIn:
        return Home(auth: widget.auth, onSignedOutHome: _signedOut);
    }
  }

  // BOTH THESE METHODS ARE INVOKED FROM THE LOGIN PAGE AND HOME PAGE RESPECTIVELY,
  // BY CALL BACK METHODS.
  //HENCE BOTH  LOGIN AND HOME PAGE ARE ASSIGNED SECOND PARAMETERS HERE TO RECEIVE THE
  // CALL BACK FROM THE LOGIN PAGE AND HOME
  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }
}
