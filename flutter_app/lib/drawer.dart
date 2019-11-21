//import 'package:flutter/material.dart';
//import './home.dart';
//import './login.dart';
//import './connection.dart';
//import './auth.dart';
//
//class MyDrawer extends StatefulWidget {
//  MyDrawer({this.onSignedOut,this.auth});
//  final BaseAuth auth;
//  final VoidCallback onSignedOut;
//
//
//  @override
//  _MyDrawerState createState() => _MyDrawerState();
//}
//
//class _MyDrawerState extends State<MyDrawer> {
//
//
//
//  void _signOut(BuildContext context) async {
//    try {
//      //var auth = AuthProvider.of(context).auth;
//      await Auth().signOut();
//      widget.onSignedOut();
//    } catch (e) {
//      print(e);
//    }
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return new Drawer(
//
//    );
//  }
//}
