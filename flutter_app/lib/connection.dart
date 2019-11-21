import 'package:flutter/material.dart';
import './drawer.dart';

class ConnectionPage extends StatelessWidget {
  final String title;

  ConnectionPage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(this.title),
        ),
        body: new Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          //new Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 10.0),
              child: new Text(
                "連絡電話 : 07-1234567",
                style: new TextStyle(fontSize: 25.0),
              ),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 10.0),
              child: new Text(
                "行動電話 : 09-12345678",
                style: new TextStyle(fontSize: 25.0),
              ),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 10.0),
              child: new Text(
                "服務時間 : 6.30 AM ~ 4:30 PM",
                style: new TextStyle(fontSize: 25.0),
              ),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 20.0),
              child: new Text(
                "地址 : OOOOOOOOOOOOO",
                style: new TextStyle(fontSize: 25.0),
              ),

            ),
            new Center(
              child: Image.asset("image/location.jpg", width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,),
            )
          ],
        ));
  }
}



