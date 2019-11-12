import 'package:call_number/call_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/first_page.dart';
import 'package:flutter_app1/Screens/second_page.dart';
import 'package:flutter_app1/Screens/third_page.dart';
import 'package:flutter_app1/Screens/Fab/fab_alert.dart';
import 'package:flutter_app1/seller.dart';
import 'package:flutter_app1/add_acc.dart';


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
              drawer: Drawer(
                  elevation: 22.0,
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        arrowColor: Colors.lightGreen,
                        accountName: Text("BSP USSD Options"),
                      ),
                      ListTile(
                        title: Text("Seller Page"),
                        trailing: Icon(Icons.account_box),
                        onTap: () {
//                        Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Seller()));
                        },
                      ),
                      ListTile(
                        title: Text("Add Account"),
                        trailing: Icon(Icons.playlist_add),

                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => AddAcc()));
                        },
                      ),
                    ],
                  )),
              floatingActionButton: FabAlert(),
            )));
  }
}
