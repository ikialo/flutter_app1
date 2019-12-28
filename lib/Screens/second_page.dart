import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/second_tabs/other_bank.dart';
import 'package:flutter_app1/Screens/second_tabs/other_bsp.dart';
import 'package:flutter_app1/Screens/second_tabs/own_acc.dart';
import 'package:flutter_app1/accountSave.dart';
import 'package:flutter_app1/db_bank.dart' as Accounts;
import 'package:flutter_app1/list_db.dart';

import '../database.dart';

class Transfer extends StatefulWidget {
  Transfer({Key key}) : super(key: key);

  @override
  SecondRoute createState() => SecondRoute();
}

enum SingingCharacter { savings, current }

class SecondRoute extends State<Transfer> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  Animation<double> sizeAnimation;
  int currentState = 0;

  String accountTo = "";

  String name = '';
  String selected_acc;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: 60).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    sizeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.

              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                splashColor: Colors.purpleAccent,
                color: Colors.deepPurple,
                onPressed: () {
                  alertDialog(MyStatefulWidget());
                },
                child: Text(
                  "Own BSP Account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.yellowAccent),
                ),
              ),
              FlatButton(
                splashColor: Colors.purpleAccent,
                color: Colors.deepPurple,
                onPressed: () {
                  alertDialog(Other_BSP());
                },
                child: Text(
                  "Other BSP Account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.yellowAccent),
                ),
              ),
              FlatButton(
                splashColor: Colors.purpleAccent,
                color: Colors.deepPurple,
                onPressed: () {
                  alertDialog(Other_Bank());
                },
                child: Text(
                  "Other Bank Account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.yellowAccent),
                ),
              )
            ],
          )

              //_widgetOptions.elementAt(_selectedIndex),
              ),
          Positioned(
            bottom: 15,
            left: 5,

            child: FlatButton.icon(icon: Icon(Icons.add_circle, size: 50,color: Colors.deepPurple, ),label: Text(""), splashColor: Colors.yellow,
              onPressed: (){
                alertAdd();
              },

                )

          ),
        ],
      ),
    );
  }

  Future<void> alertDialog(popup) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(1.0),
          elevation: 8.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          title: Text('BSP USSD'),
          backgroundColor: Colors.redAccent,
          content: popup,
        );
      },
    );
  }


  Future<void> alertAdd() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(1.0),
          elevation: 8.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          title: Text('Save Account'),
          backgroundColor: Colors.redAccent,
          content: AlertContentSave()
        );
      },
    );

  }


}


class AlertContentSave extends StatefulWidget{

  @override
  AlertContentSaveState createState() => AlertContentSaveState();

}

class AlertContentSaveState extends State<AlertContentSave>{



  String name;
  String savedAccount;
  String emailId;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  String selected_acc = "Save";

  void _submit() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    }
    var employee = AccountSave(name,savedAccount);
    var dbHelper = DBHelper();
    dbHelper.saveEmployee(employee);
    _showSnackBar("Data saved successfully");
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
          title: new Text('Saving '),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.view_list),
              tooltip: 'Next choice',
              onPressed: () {
                navigateToEmployeeList();
                //_navigateAndDisplaySelection(context);

              },
            ),
          ]
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: [
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: ' Name'),
                validator: (val) =>
                val.length == 0 ?"Enter Name" : null,
                onSaved: (val) => this.name = val,
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(labelText: 'Account'),
                validator: (val) =>
                val.length ==0 ? 'Enter Account' : null,
                onSaved: (val) => this.savedAccount = val,
              ),

              new Container(margin: const EdgeInsets.only(top: 10.0),child: new RaisedButton(onPressed: _submit,
                color: Colors.yellow,
                child: new Text('$selected_acc'),),)

            ],
          ),
        ),
      ),
    );


  }
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEmployeeList()),
    );


    setState(() {
       selected_acc = result;
    });

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }

  void navigateToEmployeeList() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => MyEmployeeList()));
  }
}
