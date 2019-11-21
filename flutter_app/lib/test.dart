import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class Item {
  String key;
  String sort;
  String itemname;
  int price;
  String unit;

  Item({this.key, this.sort, this.itemname, this.price, this.unit});

  toJson() {
    return {
      "分類": sort,
      "名稱": itemname,
      "價格": price,
      "單位": unit,
    };
  }
}

List<Item> itemslist = List();
Item itemlist = Item(key: "",
    sort: "",
    itemname: "",
    price: 0,
    unit: "");
//class ItemList {
//  final ;
//
//  ItemList({
//    this.Items,
//  });
//}

class TestPage extends StatelessWidget {
  TestPage(this.title);

  final String title;

  final DatabaseReference database = FirebaseDatabase.instance
      .reference()
      .child('test'); //.child('-LPdHz-t32vkoMsVwIe4');

  final DatabaseReference database1 =
  FirebaseDatabase.instance.reference().child('商品'); //.child("六大品項");

  sendData() {
    database.parent();
    database.push().set({'商品': '菇', '品項': '大菇'});
  }

  readData() {
    String _key;
    print("read");
    print(database
        .reference()
        .key);
    database.reference().once().then((DataSnapshot snapshot) {
      _key = snapshot.key;
      print('${snapshot.value['商品']}');
      print('${snapshot.value['品項']}');
      print(_key);
    });

    database
        .reference()
        .onChildAdded
        .listen((Event event) {
      var response = event.snapshot.key;
      print(response);
    });

    database
        .reference()
        .onChildAdded
        .listen((Event event) {
      var response = event.snapshot.value;
      print(response);
    });

//    database.reference().child(_key).once().then((DataSnapshot snapshot){
//      print('${snapshot.value['商品']}');
//      print('${snapshot.value['品項']}');
//    });
  }

  readDataitems() {
    String _key;
    database1.reference().once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      //print(values);
      _key = snapshot.key;
      //print('${snapshot.value['細項']}');
      //print(_key);
    });

    database1
        .reference()
        .onChildAdded
        .listen((Event event) {
      var responsevalue = event.snapshot.value;
      var responsekey = event.snapshot.key;
      itemlist = Item(
        key: responsekey,
        sort: responsevalue['分類'],
        itemname: responsevalue['名稱'],
        price: responsevalue['價格'],
        unit: responsevalue['單位'],
      );
      itemslist.add(itemlist);
//      print(responsekey);
//      print(responsevalue['分類']);
//      print(responsevalue['價格']);
//      print(responsevalue['名稱']);
//      print(responsevalue['單位']);
    });
//    print(itemslist[0].key);
//    print(itemslist[0].sort);
//    print(itemslist[0].itemname);
//    print(itemslist[0].price);
//    print(itemslist[0].unit);

//    database1.reference().onChildAdded.listen((Event event) {
//      var response = event.snapshot.value;
//      print(response);
//      try {
//        Map<dynamic, dynamic> item = json.decode(response);
//        print('${item['細項']}');
//      } catch (e) {
//        print('$e');
//      }
//
//      print(response);
//    });
  }

  update() {
    database1
        .reference()
        .onChildAdded
        .listen((Event event) {
      var responsevalue = event.snapshot.value;
      var responsekey = event.snapshot.key;
      itemslist[0].price = 200;
      itemslist[0].sort = "木耳類";
      itemslist[0].unit = "斤";
      itemslist[0].itemname = "大耳";
      print(itemslist[0].key);
      database1.reference().child(itemslist[0].key).set(itemslist[0].toJson());
    });
  }

  delete() {
    database1.reference().child(itemslist[0].key).remove().then((_) {

    });
  }

//  static Future<User> getUser(String userKey) async {
//    Completer<User> completer = new Completer<User>();
//
//    String accountKey = await Preferences.getAccountKey();
//
//    FirebaseDatabase.instance
//        .reference()
//        .child("accounts")
//        .child(accountKey)
//        .child("users")
//        .childOrderBy("Group_id")
//        .equals("54")
//        .once()
//
//
//    return completer.future;
//  }
//}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: <Widget>[
          new Center(
            child: new FlatButton(
              color: Colors.deepOrange,
              onPressed: sendData,
              child: new Text("發送"),
            ),
          ),
          new Center(
            child: new FlatButton(
              color: Colors.deepOrange,
              onPressed: readData,
              child: new Text("讀取"),
            ),
          ),
          new Center(
            child: new FlatButton(
              color: Colors.deepOrange,
              onPressed: readDataitems,
              child: new Text("讀取品項"),
            ),
          ),
          new Center(
            child: new FlatButton(
              color: Colors.deepOrange,
              onPressed: update,
              child: new Text("更新"),
            ),
          ),
          new Center(
            child: new FlatButton(
              color: Colors.deepOrange,
              onPressed: delete,
              child: new Text("刪除"),
            ),
          ),
        ],
      ),
    );
  }
}
