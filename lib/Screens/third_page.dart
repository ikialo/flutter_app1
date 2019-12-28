import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/third_tab/esipay.dart' as prefix0;

import 'package:flutter_app1/Screens/third_tab/own_phone.dart';
import 'package:flutter_app1/Screens/third_tab/other_phone.dart';
import 'package:flutter_app1/Screens/third_tab/esipay.dart';

class Topup extends StatefulWidget {
  Topup({Key key}) : super(key: key);

  @override
  ThirdRoute createState() => ThirdRoute();
}


class ThirdRoute extends State<Topup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                splashColor: Colors.purpleAccent,
                color: Colors.deepPurple,
                onPressed: () {
                  alertDialog(OwnPhone());
                },
                child: Text(
                  "Own Phone",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
                ),
              ),
              FlatButton(
                splashColor: Colors.purpleAccent,
                color: Colors.deepPurple,
                onPressed: () {
                  alertDialog(OtherPhone());
                },
                child: Text(
                  "Other Phone",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
                ),
              ),
              FlatButton(
                splashColor: Colors.purpleAccent,
                color: Colors.deepPurple,
                onPressed: () {
                  alertDialog(EsiPay());
                },
                child: Text(
                  "EsiPay",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
                ),
              )
            ],
          )

        //_widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Future<void> alertDialog(popup) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          title: Text('BSP USSD'),
          content: popup,
        );
      },
    );
  }
}
