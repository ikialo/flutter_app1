import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Other_Bank extends StatefulWidget {
  Other_Bank({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Other_Bank> {
  int _character = 0;
  int otherAccount = 0;
  String pinTF = '';
  String amountTF = '';
  String accountTo = "";
  String desc = "";
  int bank = 0;

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
                        Padding(padding: EdgeInsets.all(8.0),
                          child: Text("Choose BANK",style: TextStyle(fontWeight: FontWeight.bold , color: Colors.lightGreen)),),
                            
                        ListTile(
                          title: const Text('ANZ'),
                          leading: Radio(
                            value: 1,
                            groupValue: bank,
                            onChanged: (int value) {
                              setState(() {
                                bank = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('KINA'),
                          leading: Radio(
                            value: 3,
                            groupValue: bank,
                            onChanged: (int value) {
                              setState(() {
                                bank = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('WESPAC'),
                          leading: Radio(
                            value: 2,
                            groupValue: bank,
                            onChanged: (int value) {
                              setState(() {
                                bank = value;
                              });
                            },
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          decoration: new InputDecoration(
                              labelText: 'Input Acc Number', hintText: 'eg. 1212.'),
                          onChanged: (value) {
                            setState(() {
                              accountTo = value;
                            });
                          },
                        ),
                        TextField(
                          autofocus: true,
                          decoration: new InputDecoration(
                              labelText: 'Input Description', hintText: 'eg. 1212.'),
                          onChanged: (value) {
                            setState(() {
                              desc = value;
                            });
                          },
                        ),
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

                        Row(
                          children: <Widget>[
                            FlatButton(

                              onPressed: () {
                                if (_character == 1) {
                                  otherAccount = 2;
                                }
                                String format = '*131*' +
                                    pinTF +
                                    "*" +
                                    pinTF +
                                    "*" +
                                    "2*3*" +
                                    _character.toString() +
                                    "*1*" + bank.toString()+ "*"+
                                    accountTo +
                                    "*" +
                                    amountTF +
                                    "*"+ desc+
                                    "*1%23";

                                developer.log(format, name: 'my.app.category');

                                _initCall(format);

                                setState(() {
                                   _character = 0;
                                   otherAccount = 0;
                                   pinTF = '';
                                   amountTF = '';
                                   accountTo = "";
                                   desc = "";
                                   bank = 0;

                                });
                                Navigator.pop(context);
                              },
                              color: Colors.lightGreen,
                              child: Text("Confirm"),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            )
                          ],
                        )
                      ]),
                    )))));
  }

  _initCall(num) async {
    await new CallNumber().callNumber(num);
  }
}