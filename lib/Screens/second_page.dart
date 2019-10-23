import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/second_tabs/other_bank.dart';
import 'package:flutter_app1/Screens/second_tabs/other_bsp.dart';
import 'package:flutter_app1/Screens/second_tabs/own_acc.dart';

class Transfer extends StatefulWidget {
  Transfer({Key key}) : super(key: key);

  @override
  SecondRoute createState() => SecondRoute();
}

enum SingingCharacter { savings, current }

class SecondRoute extends State<Transfer> {
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
              alertDialog(MyStatefulWidget());
            },
            child: Text(
              "Own BSP Account",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          FlatButton(
            splashColor: Colors.purpleAccent,
            color: Colors.deepPurple,
            onPressed: () {
              alertDialog(Other_BSP());
            },
            child: Text(
              "Other BSP Account",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          FlatButton(
            splashColor: Colors.purpleAccent,
            color: Colors.deepPurple,
            onPressed: () {
              alertDialog(Other_Bank());
            },
            child: Text(
              "Other Bank Account",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
