import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/second_tabs/other_bank.dart';
import 'package:flutter_app1/Screens/second_tabs/other_bsp.dart';
import 'package:flutter_app1/Screens/second_tabs/own_acc.dart';
import 'package:flutter_app1/Screens/Fab/alert_content.dart';
import 'package:flutter_app1/scan.dart';

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScanScreen()),
        );
      },
       child: Icon(Icons.attach_money, size: 50),
       backgroundColor: Colors.yellow,

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
