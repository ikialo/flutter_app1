import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/accountSave.dart';
import 'dart:developer' as developer;

import '../../list_db.dart';

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

  AccountSave selectedAcc = AccountSave('Name', "Account");

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

                   Row( children: <Widget>[

                     Expanded(


                       child: TextField(



                       keyboardType: TextInputType.number,
                       autofocus: true,
                       decoration: new InputDecoration(
                           labelText: 'Input Acc Number ', hintText: 'eg. 1212.'),
                       onChanged: (value) {
                         setState(() {
                           accountTo = value;
                         });
                       },
                     ),
                       flex: 2,
                     ),


                     Expanded(child:    FlatButton.icon(icon: Icon(Icons.list, size: 50,color: Colors.lightGreen, ),label: Text(""), splashColor: Colors.deepPurple,
                       onPressed: (){

                         _navigateAndDisplaySelection(context);
                       },

                     ), flex: 1,)

                   ],),


                        Text( selectedAcc == null ? "No contact selected ": "Name: "+ selectedAcc.name + " Number: " + selectedAcc.savedAccount),

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


  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEmployeeList()),
    );


    setState(() {
      selectedAcc = result;

      accountTo = selectedAcc.savedAccount;
    });

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }

  _initCall(num) async {
    await new CallNumber().callNumber(num);
  }
}