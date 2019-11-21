import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'test.dart';
import 'home.dart';
import 'login.dart';
import 'drawer.dart';
import 'auth.dart';
import 'connection.dart';
import 'items.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.auth, this.onSignedOut, this.email})
      : super(key: key);
  static const String routename = '/首頁';

  final String email;
  final BaseAuth auth;

  //final String title;
  final VoidCallback onSignedOut;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String email;
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  void _signOut(BuildContext context) async {
    try {
      //var auth = AuthProvider.of(context).auth;
      await Auth().signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  List<String> itemsname = ['菇類', '辣椒類', '蒜類', '薑類', '木耳類', '蔥類'];
  List<String> itemsimage = [
    'image/mushroom.jpg',
    'image/hotpepper.jpg',
    'image/garlic.jpg',
    'image/ginger.jpg',
    'image/blackfungus.jpg',
    'image/scallion.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = _controller.drive(_drawerDetailsTween);
  }

  void _onitemsclicked(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new ItemsPage(itemsname[0])));
        break;
      case 1:
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new ItemsPage(itemsname[1])));
        break;
      case 2:
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new ItemsPage(itemsname[2])));
        break;
      case 3:
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new ItemsPage(itemsname[3])));
        break;
      case 4:
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new ItemsPage(itemsname[4])));
        break;
      case 5:
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new ItemsPage(itemsname[5])));
        break;
    }
    print("按了: $index");
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('首頁'),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: new Text(widget.email == null ? "" : widget.email),
              accountName: new Text(''),
              currentAccountPicture: new CircleAvatar(
                child: new Text(
                  widget.email == null ? "" : widget.email[0] + widget.email[1],
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
            new ListTile(

              selected: true,
              title: new Text('首頁'),
              leading: new Icon(Icons.home),
              onTap: () {
                //Navigator.of(context).pop();
                //Navigator.of(context).pushNamed(MyHomePage.routename);
//              Navigator.of(context).push(new PageRouteBuilder(
//                transitionsBuilder:
//                    (_, Animation<double> animation, __, Widget child) {
//                  return new FadeTransition(opacity: animation, child: child);
//                },
//              ));
//              Navigator.of(context).push(new MaterialPageRoute(
//                  builder: (BuildContext context) => new MyHomePage()));
              },
            ),
            new ListTile(
              title: new Text('帳戶'),
              leading: new Icon(Icons.perm_identity),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text('登出'),
              leading: new Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.of(context).pop();
                _signOut(context);
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text('隱私政策'),
              leading: new Icon(Icons.https),
            ),
            new ListTile(
              title: new Text('聯絡資訊'),
              leading: new Icon(Icons.help_outline),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ConnectionPage('聯絡資訊')),
                );
//                Navigator.of(context).push(
//                    new PageRouteBuilder(
//                  transitionsBuilder:
//                      (_, Animation<double> animation, __, Widget child) {
//                    return new FadeTransition(opacity: animation, child: child);
//                  },
//                ));
              },
            ),
            new ListTile(
              title: new Text('關於'),
              leading: new Icon(Icons.info_outline),
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AboutDialog(
                        applicationIcon: new Icon(Icons.shopping_cart),
                        applicationVersion: 'V0.2.1',
                        applicationName: 'Market',
                        children: <Widget>[new Text('測試CRUD'),],
                      );
//                      return AlertDialog(
//                        title: new Text('菜市場'),
//                        content: new Text('版本 : 0.2.1\n\n開發人員 : \nlaysdra7265、arthur0209\ntaya92413、tseng8628'),
//                        actions: <Widget>[
//                          new FlatButton(
//                            child: new Text('關閉'),
//                            onPressed: () {
//                              Navigator.of(context).pop();
//                            },
//                          )
//                        ],
//                      );
                    });

              },
            ),
            new Divider(),
            new ListTile(
              title: new Text('測試'),
              leading: Icon(Icons.build),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new TestPage('測試')),
                );
              },
            )
          ],
        ),
      ),
      body: new GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 7.0,
        crossAxisSpacing: 7.0,
        padding: EdgeInsets.all(4.0),
        children: new List.generate(6, (index) {
          return new GestureDetector(
            onTap: () {
              _onitemsclicked(index);
            },
            child: new Container(
              width: double.infinity,
              height: double.infinity,
              decoration: new BoxDecoration(
                //image: DecorationImage(image: ExactAssetImage(itemsimage[index])),
                color: Colors.white,
              ),
              child: new Column(
                children: <Widget>[
                  Image.asset(
                    itemsimage[index],
                    fit: BoxFit.fitWidth,
                  ),
                  Center(
                    child: Text(
                      itemsname[index],
                      style: TextStyle(fontSize: 22.0),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
        //reverse: false,
//        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 2,
//            mainAxisSpacing: 10.0,
//            crossAxisSpacing: 10.0,
//            childAspectRatio: 1.0),
      ),
    );
  }
}
