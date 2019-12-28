import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:native_contact_picker/native_contact_picker.dart';

class OtherPhone extends StatefulWidget {
  OtherPhone({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<OtherPhone> {
  int _character = 0;
  int otherAccount = 0;
  String pinTF = '';
  String amountTF = '';
  String accountTo = "";
  String desc = "";
  String phoneNum = "123";
  int network = 0;

  TextEditingController _quoteController;
  TextEditingController _authorController;

  final NativeContactPicker _contactPicker = new NativeContactPicker();
  Contact _contact;

  Widget build(BuildContext context) {
    return new Material(
        child: new Container(
            child: new SingleChildScrollView(
                child: new ConstrainedBox(
                    constraints: new BoxConstraints(),
                    child: Center(
                      child: new Column(children: <Widget>[
                        Text("Choose Account to Send from",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen)),
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
                        Padding(
                          child: Text("Choose Network",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreen)),
                          padding: EdgeInsets.all(8.0),
                        ),
                        ListTile(
                          title: const Text('Digicel'),
                          leading: Radio(
                            value: 1,
                            groupValue: network,
                            onChanged: (int value) {
                              setState(() {
                                network = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Bemobile'),
                          leading: Radio(
                            value: 2,
                            groupValue: network,
                            onChanged: (int value) {
                              setState(() {
                                network = value;
                              });
                            },
                          ),
                        ),
                        Center(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  autofocus: true,
                                  decoration: new InputDecoration(
                                      labelText: 'Input Phone #',
                                      hintText: 'eg. 1212.'),
                                  onChanged: (value) {
                                    setState(() {
                                      phoneNum = value;
                                    });
                                  },
                                ),
                                width: 130.0,
                              ),
                              Container(
                                  width: 60.0,
                                  child: Center(
                                      child: FlatButton.icon(
                                    onPressed: () async {
                                      Contact contact =
                                          await _contactPicker.selectContact();

                                    //  RegExp exp = new RegExp("+675");


                                      String con = contact.phoneNumber.replaceFirst("+675", "");


                                      setState(() {
                                        _contact = contact;
                                        phoneNum = con;
                                      });

                                      //alertList();
                                    },
                                    icon: Icon(Icons.contacts),
                                    label: Text(""),
                                    color: Colors.lightGreen,
                                  )))
                            ],
                          ),
                        ),

                        Text( _contact == null ? "No contact selected ": "Name: "+ _contact.fullName + " Number: " + phoneNum),
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
                                    "3*1*" +
                                    _character.toString() +
                                    "*1*" +
                                    phoneNum +
                                    "*" +
                                    network.toString() +
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
//
//  Future<void> alertList() async {
//    Iterable<Contact> contacts =
//        await ContactsService.getContacts(withThumbnails: false);
//
//    List<Contact> entries = contacts.toList();
//
//    final List<int> colorCodes = <int>[600, 500, 100];
//
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('Contact List'),
//          content: Material(
//            child: Scaffold(
//              body: Center(
//                child: Padding(
//                  padding: EdgeInsets.all(10),
//                  child: ListView.builder(
//                      padding: const EdgeInsets.all(8),
//                      itemCount: entries.length,
//                      itemBuilder: (BuildContext context, int index) {
//                        return Container(
//                            height: 50,
//                            color: Colors.lightGreenAccent,
//                            child: GestureDetector(
//                                child: Center(
//                                    child:
//                                        Text('${entries[index].displayName}')),
//
//                                onTap: () {
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text(
//                                          '${entries[index].phones.toList()[0].value}')));
//
//
//                                  String ph =  entries[index].phones.toList()[0].value;
//
//                                  developer.log(ph.length.toString(), name: "Length: ");
//                                  setState(() {
//                                    phoneNum =ph;
//
//                                  });
//
//                                  Navigator.pop(context);
//                                }));
//                      }),
//                ),
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
}
