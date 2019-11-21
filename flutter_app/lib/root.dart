import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'login.dart';
import 'auth.dart';
import 'drawer.dart';


class RootPage extends StatefulWidget {
  RootPage({this.app});
//  final BaseAuth auth;
  final FirebaseApp app;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;

  String email;

  @override
  void initState() {
    super.initState();
    try{
      //var auth = AuthProvider.of(context).auth;
      Auth()?.currentUser().then((userid) {
        setState(() {
          authStatus = userid == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
//      FirebaseAuth.instance.onAuthStateChanged.listen((userid) {
//        // do whatever you want based on the firebaseUser state
//
//      });
      });
    }catch(e){
      print(e.toString());
    }

  }

  void _signedIn() {
    userdata();
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  void userdata() async {
    //String username = await Auth().currentUsername();
    String useremail = await Auth().currentUseremail();
    setState(() {
      email = useremail;
    });
  }

  @override
  Widget build(BuildContext context) {
    userdata();
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return new MyLoginPage(
          //user: widget.user,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        //userdata();
        //new ();
        return new MyHomePage(
          email: email,
          //user: widget.user,
          onSignedOut: _signedOut,
        );
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
