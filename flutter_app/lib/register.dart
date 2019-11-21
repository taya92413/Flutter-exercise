import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './auth.dart';


class MyRegisterPage extends StatefulWidget {
  MyRegisterPage({Key key, this.title}) : super(key: key);
  static const String routename = "/註冊";
  final String title;

  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
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
        String userid = await Auth()?.createUserWithEmailAndPassword(_email, _password);
        print('register ${userid}');
      } catch (e) {
        print('error ${e}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Stack(children: <Widget>[
        new Column(
          children: <Widget>[
            new Center(
//              child: new Image.asset(
//                'image/star.png',
//                width: MediaQuery.of(context).size.width * 0.6,
//              ),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Form(
                key: formkey,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new TextFormField(
                      maxLines: 1,
                      style:
                      new TextStyle(fontSize: 19.0, color: Colors.black),
                      decoration: new InputDecoration(
                        labelText: "Email",
                        icon: new Icon(
                          Icons.account_box,
                        ),
                      ),
                      validator: (value) => value.isEmpty ? 'Email 錯誤' : null,
                      onSaved: (value) => _email = value,
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    new TextFormField(
                      maxLines: 1,
                      obscureText: true,
                      style:
                      new TextStyle(fontSize: 19.0, color: Colors.black),
                      decoration: new InputDecoration(
                        labelText: "Password",
                        icon: new Icon(
                          Icons.lock_outline,
                        ),
                      ),
                      validator: (value) =>
                      value.isEmpty ? 'Password 錯誤' : null,
                      onSaved: (value) => _password = value,
                    ),
                    new Padding(padding: EdgeInsets.only(top: 50.0)),
                    new FlatButton(
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Theme.of(context).accentColor),
                        child: new Center(
                          child: new Text(
                            "註冊",
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: (){
                        vaildateAndSubmit();
                       if(vaildateAndSave()){
                         Navigator.of(context).pop();
                       }


                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
