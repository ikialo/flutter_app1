import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  FirstRoute createState() => FirstRoute();
}


class FirstRoute extends State<MyHomePage>{

  String teamName = '';
  String format = '';
  String stringValue ='';

  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      stringValue = prefs.getString('stringValue');
    });
    //Return bool

  }

  Future<String> _asyncInputDialog(BuildContext context, buttonNumber) async {


    return showDialog<String>(
      context: context,

      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter BSP Mobile Banking PIN'),
          content: new Column(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    obscureText: true,
                    maxLength: 4,
                    keyboardType: TextInputType.number ,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Input PIN', hintText: 'eg. 1212.'),
                    onChanged: (value) {
                      setState(() {
                        teamName = value;

                      });
                    },
                  )
              ),
              Row(children: <Widget>[
                FlatButton(color: Colors.lightGreen,

                  child: Text('Confirm'),
                  onPressed: () {
                    _initCall(buttonNumber);

                    setState(() {
                       teamName = '';
                       format = '';
                    });
                    Navigator.of(context).pop(teamName);
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(teamName);
                  },
                ),
              ],),
              Text("$stringValue")

            ],
          ),

        );
      },
    );
  }


  _initCall(buttonNum) async {


    developer.log( '*131*' + teamName + "*" + teamName + "*" + "1*2%23");
    if (buttonNum ==1) {
      await new CallNumber().callNumber(


          '*131*' + teamName + "*" + teamName + "*" + "1*2%23");
    }
    if (buttonNum ==2) {
      await new CallNumber().callNumber(
          '*131*' + teamName + "*" + teamName + "*" + "1%23");
    }
  }


  @override
  void initState() {
    getValuesSF();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(

              splashColor: Colors.purpleAccent,
              color: Colors.deepPurple,

              onPressed: (){
                _asyncInputDialog(context, 1);
              },
              child: Text(
                'Check Balance',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),

              ),
            ),
            FlatButton(
              splashColor: Colors.purpleAccent,
              color: Colors.deepPurple,
              onPressed: () {
                _asyncInputDialog(context, 2);
              },
              child: Text(
                'Mini Statement ',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),

              ),
            )
            ,
          ],
        ),
      ),
    );
  }
}
