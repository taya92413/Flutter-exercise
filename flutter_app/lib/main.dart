import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import './home.dart';
import './login.dart';
import './register.dart';
import './root.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'market',
      options: const FirebaseOptions(
        googleAppID: '1:170826011754:android:7bd71543f89d056a',
        apiKey: 'AIzaSyBZ1afRHNizuoS32I7ahcYhteAwpnclfhc',
        databaseURL: 'https://jokes-arthur.firebaseio.com',
      ));
  runApp(new MyApp(
    app: app,
  ));
}

//void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp({this.app});

  final FirebaseApp app;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '菜市場',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new RootPage(
        app: this.app,
        //title: '首頁',
      ),
      routes: <String, WidgetBuilder>{
        MyHomePage.routename: (BuildContext context) => new MyHomePage(),
        MyLoginPage.routename: (BuildContext context) => new MyLoginPage(),
        MyRegisterPage.routename: (BuildContext context) => new MyRegisterPage(
              title: '註冊',
            )
      },
    );
  }
}
