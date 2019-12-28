import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'accountSave.dart';

class Seller extends StatefulWidget {
  @override
  SellerState createState() => new SellerState();
}

class SellerState extends State<Seller> {
  String barcode = "";
  String stringValue = '';
  String accountNum = "";
  String amount = "";
  String qrStringGen = "BSP USSD QR CODE";


  GlobalKey globalKey = new GlobalKey();

  AccountSave selectedAccSeller;

  String accountTo;
  String nameOfAcc;


  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      accountNum = prefs.getString('stringValue');
      stringValue = prefs.getString("NameBusiness");
    });
  }


  addString() {
    String qrString = accountNum + "," + amount + "," + stringValue;

    setState(() {
      qrStringGen = qrString;
    });
  }

  @override
  initState() {
    super.initState();
    getValuesSF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Seller'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Center(child: Text("$stringValue ")),
                  Center(child: Text("Acc #$accountNum")),
                  Padding(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Amount To Charge', hintText: 'eg. 25.'),
                      onChanged: (value) {
                        setState(() {
                          amount = value;
                        });
                      },
                    ),
                    padding: EdgeInsets.only(right: 40, left: 40),
                  ),
                ],
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.blueAccent),
              child: _contentWidget(),
            ),
            flex: 5,
          ),
          Expanded(
            child: Container(
              child: Center(
                  child: FlatButton(
                onPressed: () {
                  addString();
                },
                child: Text("Submit"),
                color: Colors.blueAccent,
              )),
            ),
            flex: 1,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndDisplaySelection(context),
        child: Text(
          "+",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 30.0),
        ),
        backgroundColor: Colors.yellow,
      ),
    );
  }


  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SellerUser()),
    );


    setState(() {
      selectedAccSeller = result;

      accountNum = selectedAccSeller.savedAccount;
      stringValue = selectedAccSeller.name;
    });

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }

  Future<String> _asyncInputDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,

      barrierDismissible: false,
      // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Your BSP Account Number to Save'),
          content: SellerUser(),
        );
      },
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[

          Expanded(
            child: Center(
              child: RepaintBoundary(

                key: globalKey,
                child: QrImage(
                  data: qrStringGen,
                  size: 0.5 * bodyHeight,
                  backgroundColor: Colors.blueAccent,
                ),


              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SellerUser extends StatefulWidget {
  @override
  SellerUserState createState() => new SellerUserState();
}

class SellerUserState extends State<SellerUser> {
  String accountNum = "";
  String stringValue = '';
  String businessName = '';

  @override
  void initState() {
    getValuesSF();
  }

  addStringToSF() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', accountNum);
    prefs.setString('NameBusiness', businessName);

    Navigator.pop(context, AccountSave(businessName, accountNum));
  }

  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      stringValue = prefs.getString('stringValue');
    });
    //Return bool
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Account"),),
      body:Center(child: Container(

        child: Center(child:Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Account Number', hintText: 'eg. .'),
              onChanged: (value) {
                setState(() {
                  accountNum = value;
                });
              },
            ),
            TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Business Name', hintText: 'eg. Bobs Market.'),
              onChanged: (value) {
                setState(() {
                  businessName = value;
                });
              },
            ),
            Text("$accountNum"),
            FlatButton(
              onPressed: addStringToSF,
              child: Text("Submit"),
              color: Colors.blueAccent,
            ),
            Text("$stringValue")
          ],
        ),
      ),
    )));
  }
}
