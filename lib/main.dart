import 'package:flutter/material.dart';
import 'package:flutter_unit_test_acazia/utils/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('List Comment')),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.green,
            child: Center(
              child: OutlineButton(
                child: Text("List user online", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                onPressed: () {
                  Router.instance.goToUserOnline(context);
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.purple,
            child: Center(
              child: OutlineButton(
                child: Text("List user favorite", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                onPressed: () {
                  Router.instance.goToScreenFavoriteUser(context);
                },
              ),
            ),
          )
        ],
      )
    );
  }
}
