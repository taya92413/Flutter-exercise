import 'package:flutter/material.dart';
import 'package:flutter_app/shoppingcart.dart';

class ItemsPage extends StatelessWidget {
  final String title;

  ItemsPage(this.title);

  setimage() {
    String imagename;
    switch (this.title) {
      case ("菇類"):
        imagename = "image/mushroom.jpg";
        break;
      case ("辣椒類"):
        imagename = "image/hotpepper.jpg";
        break;
      case ("蒜類"):
        imagename = "image/garlic.jpg";
        break;
      case ("薑類"):
        imagename = "image/ginger.jpg";
        break;
      case ("木耳類"):
        imagename = "image/blackfungus.jpg";
        break;
      case ("蔥類"):
        imagename = "image/scallion.jpg";
        break;
    }
    return imagename;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
      ),
      body: new Column(
        children: <Widget>[
          new Center(
            child: new Container(
              child: new Image.asset(
                setimage(),
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
          ),
          new Center(
            child: new FlatButton(onPressed: null, child: new Text("123")),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        //tooltip: '123',
        onPressed: () {
          Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new ShoppingCartPage()),);
        },
        child: new Icon(Icons.shopping_cart),
      ),
    );
  }
}
