import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/second_tabs/other_bank.dart';
import 'package:flutter_app1/Screens/second_tabs/other_bsp.dart';
import 'package:flutter_app1/Screens/second_tabs/own_acc.dart';
import 'package:flutter_app1/Screens/Fab/alert_content.dart';

class FabAlert extends StatefulWidget {
  FabAlert({Key key}) : super(key: key);

  @override
  FabAlertState createState() => FabAlertState();
}


class FabAlertState extends State<FabAlert> {
  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
       onPressed: () {
         alertDialog(AlertContent());
       },
       child: Text(
         "+",
         style: TextStyle(
             fontWeight: FontWeight.bold,
             color: Colors.deepPurple,
             fontSize: 30.0),
       ),
       backgroundColor: Colors.lightGreen,

    );
  }

  Future<void> alertDialog(popup) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          title: Text('Choose Option To Add Account'),
          content: popup,
        );
      },
    );
  }
}