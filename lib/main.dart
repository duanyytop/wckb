import 'package:flutter/material.dart';
import 'package:wckb/components/components.dart';

var _screenWidth = 0.0;
var _screenHeight = 0.0;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0x3c3e45),
        body: Container(
            width: _screenWidth,
            height: _screenHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mainPenal(Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
                welcomeWCKB()
              ],
            )));
  }
}
