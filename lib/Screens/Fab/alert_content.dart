import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
class AlertContent extends StatefulWidget {
  AlertContent({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<AlertContent> {
  int _character = 0;
  int otherAccount = 0;
  String pinTF = '';
  String amountTF = '';

  Widget build(BuildContext context) {
    return new Material(
        child: new Container(
            child: new SingleChildScrollView(
                child: new ConstrainedBox(
                    constraints: new BoxConstraints(),
                    child: Center(
                      child: new Column(children: <Widget>[
                        Column(children: <Widget>[
                          FlatButton(
                          onPressed: () {

                          },
                            color: Colors.lightGreen,
                          child: Text("Esi Pay Meter Number"),
                        ),
                          FlatButton(onPressed: (){


                          },child: Text("Bank Account Number"),
                            color: Colors.lightGreen,
                          ),
                          FlatButton(onPressed: (){
                            Navigator.pop(context);


                          },child: Text("Cancel"),)
                          ],
                        ),
                      ]),
                    )
                )
            )
        )
    );
  }


}