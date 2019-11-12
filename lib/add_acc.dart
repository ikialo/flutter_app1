import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAcc extends StatefulWidget {
  @override
  SellerState createState() => new SellerState();
}

class SellerState extends State<AddAcc> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Add Account'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[

                ],
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.lightGreen),
              child: Center(child: Column(children: <Widget>[

                FlatButton(
                  child: Text("Bank Account Number",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  color: Colors.deepPurple,

                  onPressed: (){

                  },
                )
                ,
                FlatButton(
                  child: Text("EsiPay Meter Number",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  color: Colors.deepPurple,
                  onPressed: (){

                  },
                )

              ],),),

            ),
            flex: 5,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[

                ],
              ),
            ),
            flex: 2,
          ),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () => _asyncInputDialog(context),
//        child: Text(
//          "+",
//          style: TextStyle(
//              fontWeight: FontWeight.bold,
//              color: Colors.deepPurple,
//              fontSize: 30.0),
//        ),
//        backgroundColor: Colors.lightGreen,
//      ),
    );
  }

  Future<String> _asyncInputDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,

      barrierDismissible: false,
      // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Your BSP Account Number to Save'),
        );
      },
    );
  }

}
