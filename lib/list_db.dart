import 'package:flutter/material.dart';
import 'accountSave.dart';
import 'dart:async';
import 'database.dart';

Future<List<AccountSave>> fetchEmployeesFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<AccountSave>> employees = dbHelper.getEmployees();
  return employees;
}

class MyEmployeeList extends StatefulWidget {
  @override
  MyEmployeeListPageState createState() => new MyEmployeeListPageState();
}

class MyEmployeeListPageState extends State<MyEmployeeList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Account List List'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new FutureBuilder<List<AccountSave>>(
          future: fetchEmployeesFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(snapshot.data[index].name.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].savedAccount,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0)),

                          new Divider()
                        ]),
                      onTap: () {
                        Navigator.pop(context, snapshot.data[index]);

                      }


                    );
                  });
            } else if (snapshot.data == null) {
              return new Text("No Data found");
            }
            return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
