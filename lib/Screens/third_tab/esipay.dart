import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class EsiPay extends StatefulWidget {
  EsiPay({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<EsiPay> {
  int _character = 0;
  int otherAccount = 0;
  String pinTF = '';
  String amountTF = '';
  String meterNum = '';

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
                        TextField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          decoration: new InputDecoration(
                              labelText: 'Input Esi Pay',
                              hintText: 'eg. 1212.'),
                          onChanged: (value) {
                            setState(() {
                              meterNum = value;
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
                                    "3*2*" +
                                    _character.toString() +
                                    "*1*" +
                                    meterNum +
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
