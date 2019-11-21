import 'package:flutter/material.dart';
import 'home.dart';
import 'drawer.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'auth.dart';

class MyLoginPage extends StatefulWidget {
  //MyLoginPage({this.onSignedIn});

  MyLoginPage({Key key, this.onSignedIn}) : super(key: key);
  static const String routename = "/登入";

  //final BaseAuth auth;
  //final String title;
  //final FirebaseUser user;
  final VoidCallback onSignedIn;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final formkey = new GlobalKey<FormState>();
  String _email;
  String _password;

  bool vaildateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void vaildateAndSubmit() async {
    if (vaildateAndSave()) {
      try {
        String userid =
            await Auth()?.signInWithEmailAndPassword(_email, _password);
        print('sign ${userid}');
        widget.onSignedIn();
      } catch (e) {
        print('error ${e}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      //drawer: new MyDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.dstATop),
                          image: new AssetImage('image/loginbackground.jpg')),
                      gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.black])),
                  height: MediaQuery.of(context).size.height,
                  //padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  //width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                    key: formkey,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 90.0, bottom: 50.0),
                          child: Center(
                            child: new Column(
                              children: <Widget>[
                                Container(
                                  height: 140.0,
                                  width: 150.0,
                                  child: new CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    //foregroundColor: ,
                                    radius: 100.0,
                                    child: new Text(
                                      "MK",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
//                                decoration: BoxDecoration(
//                                    border: Border.all(
//                                        color: Colors.white, width: 1.0),
//                                    shape: BoxShape.circle),
                                )
                              ],
                            ),
                          ),
                        ),
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 40.0, right: 40.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          padding: EdgeInsets.only(left: 0.0, right: 10.0),
                          child: new Row(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, bottom: 10.0, right: 20.0),
                                child: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: new TextFormField(
                                    validator: (value) =>
                                        value.isEmpty ? 'Email 錯誤' : null,
                                    onSaved: (value) => _email = value,
                                    maxLines: 1,
                                    style: new TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: "電子郵件",
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 40.0, right: 40.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          padding: EdgeInsets.only(left: 0.0, right: 10.0),
                          child: new Row(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, bottom: 10.0, right: 20.0),
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: new TextFormField(
                                    obscureText: true,
                                    validator: (value) =>
                                        value.isEmpty ? 'Password 錯誤' : null,
                                    onSaved: (value) => _password = value,
                                    maxLines: 1,
                                    style: new TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: "密碼",
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 30.0),
                          alignment: Alignment.center,
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new FlatButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(28.0)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 15.0),
                                  color: Colors.deepOrange,
                                  onPressed: vaildateAndSubmit,
                                  child: new Text(
                                    '登入',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 30.0),
                          alignment: Alignment.center,
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new FlatButton(
                                  //padding: const EdgeInsets.symmetric(
                                  //vertical: 15.0, horizontal: 15.0),
                                  //color: Colors.deepOrange,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(MyRegisterPage.routename);
                                  },
                                  child: new Text(
                                    '尚未註冊?前去註冊',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
