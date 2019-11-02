import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/first_page.dart';
import 'package:flutter_app1/Screens/second_page.dart';
import 'package:flutter_app1/Screens/third_page.dart';
import 'package:flutter_app1/Screens/Fab/fab_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.greenAccent,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          backgroundColor: Colors.greenAccent),
      home: _MyHomePageState(),
    );
  }
}

class _MyHomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.green,
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                elevation: 10,
                backgroundColor: Colors.lightGreen,
                bottom: TabBar(
                  indicatorColor: Colors.deepPurpleAccent,
                  labelColor: Colors.deepPurple,
                  tabs: [
                    Tab(
                      child: Text(
                        "Balance",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Transfer",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Top Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                title: Text("BSP USSD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent)),
                centerTitle: true,
              ),
              body: TabBarView(
                children: <Widget>[MyHomePage(), Transfer(), Topup()],
              ),
              drawer: ListTile(
                leading: Icon(Icons.change_history),
                title: Text('Change history'),
                onTap: () {
                  // change app state...
                },
              ),
              floatingActionButton: FabAlert(),
         )
      )
    );
  }

}

