import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
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
                        Text("Choose Account to Send",style: TextStyle(fontWeight: FontWeight.bold , color: Colors.lightGreen)),
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
                        Text("Enter Amount",style: TextStyle(fontWeight: FontWeight.bold , color: Colors.lightGreen)),
                        TextField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          decoration: new InputDecoration(
                              labelText: 'Input Amount', hintText: 'eg. 1212.'),
                          onChanged: (value) {
                            setState(() {
                              amountTF = value;
                            });
                          },
                        ),
                        Text("Enter Pin "),
                        TextField(
                          obscureText: true,
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          decoration: new InputDecoration(
                              labelText: 'Input PIN', hintText: 'eg. 1212.'),
                          onChanged: (value) {
                            setState(() {
                              pinTF = value;
                            });
                          },
                        ),
                      Row(children: <Widget>[ FlatButton(
                        onPressed: () {
                          if (_character == 1) {
                            otherAccount = 2;
                          }if (_character == 2){
                            otherAccount = 1;
                          }
                          String format = '*131*' +
                              pinTF +
                              "*" +
                              pinTF +
                              "*" +
                              "2*1*" +
                              _character.toString() +
                              "*" +
                              otherAccount.toString() +
                              "*" +
                              amountTF +
                              "*1%23";

                          developer.log(format, name: 'my.app.category');

                          _initCall(format);
                          Navigator.pop(context);

                        },
                        color: Colors.lightGreen,
                        child: Text("Confirm"),
                      ),
                        FlatButton(onPressed: (){
                          Navigator.pop(context);


                        },child: Text("Cancel"),)],)
                      ]),
                    )))));
  }

  _initCall(num) async {
    await new CallNumber().callNumber(num);
  }
}