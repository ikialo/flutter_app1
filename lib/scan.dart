import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:call_number/call_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;


class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  String accountNum = "";
  String amount = "";
  String desc = "";
  int _character = 0;
  String pinTF = '';

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: new AppBar(
          backgroundColor: Colors.lightGreen,
          title: new Text('QR Code Scanner'),
        ),
        floatingActionButton: FloatingActionButton(backgroundColor:Colors.lightGreen,
          child: Icon(Icons.camera), onPressed: scan,splashColor: Colors.deepPurple,),


        body: new Center(

          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text("Account Number: "+accountNum, textAlign: TextAlign.left,),
              )
              ,

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text("Amount is: K"+amount, textAlign: TextAlign.left, ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text("Business Name: "+desc, textAlign: TextAlign.left,),
              ),
              Padding(

                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(children: <Widget>[

                  Text("Choose Account to Transfer From",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreen),),

                  ListTile(

                    title: const Text('Savings'),
                    leading: Radio(
                      value: 2,
                      groupValue: _character,
                      onChanged: (int value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Current'),
                    leading: Radio(
                      value: 1,
                      groupValue: _character,
                      onChanged: (int value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),

                  Text("Enter Pin ",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreen),),
                  TextField(
                    obscureText: true,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: new InputDecoration(
                      focusColor: Colors.lightGreen,
                        fillColor: Colors.lightGreen,
                        labelText: 'Input PIN', hintText: 'eg. 1212.'),
                    onChanged: (value) {
                      setState(() {
                        pinTF = value;
                      });
                    },
                  ),

                ],),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    onPressed: (){


                      String format = '*131*' +
                          pinTF +
                          "*" +
                          pinTF +
                          "*" +
                          "2*2*" +
                          _character.toString() +
                          "*1*" +
                          accountNum +
                          "*" +
                          amount +
                          "*"+ desc+
                          "*1%23";

                      developer.log(format, name: 'my.app.category');

                      _initCall(format);

                    },
                    splashColor: Colors.lightGreen,
                    child: const Text('CONFIRM',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                ),
              )
              ,



            ],
          ),
        ));
  }

  _initCall(num) async {
    await new CallNumber().callNumber(num);
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();

      List<String> splitString  = barcode.split(',');

      if (splitString.length == 3) {
        setState(() {
          accountNum = splitString[0];
          amount = splitString[1];
          desc = splitString [2];
        });
      }
      else {
        setState(() {
          accountNum = "Please Scan from BSP USSD app";
          amount ="";
          desc = "";
        });
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}