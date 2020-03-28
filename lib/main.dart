import 'package:flutter/material.dart';
import 'package:wckb/components/components.dart';
import 'package:wckb/trandfer.dart';
import 'package:wckb/utils/const.dart';

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
  Tab _tab = Tab.Create;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xff3c3e45),
        appBar: AppBar(title: const Text('WCKB Wallet'), backgroundColor: Color(TitleBarColor)),
        body: Container(
            width: _screenWidth,
            height: _screenHeight - 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mainPenal(Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new GestureDetector(
                            onTap: () {
                              setState(() {
                                _tab = Tab.Create;
                              });
                            },
                            child: tabWidget(_tab == Tab.Create, 'Create a Wallet')),
                        new GestureDetector(
                            onTap: () {
                              setState(() {
                                _tab = Tab.Import;
                              });
                            },
                            child: tabWidget(_tab == Tab.Import, 'Import Wallet Mnemonic'))
                      ],
                    ),
                    _tab == Tab.Create ? createWalletWidget(context) : importMnemonicWidget(),
                  ],
                )),
                welcomeWCKB()
              ],
            )));
  }
}

Widget createWalletWidget(BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 48),
        child: Container(
            width: 490,
            height: 73,
            decoration: BoxDecoration(
                border: new Border.all(color: Color(GRAY_COLOR), width: 1),
                color: Color(0x0ff1c1d20),
                borderRadius: new BorderRadius.all(Radius.circular(45))),
            child: inputWidget('Wallet Name *', false, (value) {
              print(value);
            })),
      ),
      Padding(
        padding: EdgeInsets.only(top: 14),
        child: Container(
          width: 490,
          height: 73,
          decoration: BoxDecoration(
              border: new Border.all(color: Color(GRAY_COLOR), width: 1),
              color: Color(0x0ff1c1d20),
              borderRadius: new BorderRadius.all(Radius.circular(45))),
          child: inputWidget('Password *', true, (value) {
            print(value);
          }),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 14),
        child: Container(
          width: 490,
          height: 73,
          decoration: BoxDecoration(
              border: new Border.all(color: Color(GRAY_COLOR), width: 1),
              color: Color(0x0ff1c1d20),
              borderRadius: new BorderRadius.all(Radius.circular(45))),
          child: inputWidget('Confirm Password *', true, (value) {
            print(value);
          }),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(
            width: 180,
            height: 40,
            child: RaisedButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Transfer()));
              },
              color: Color(GREEN_COLOR),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(33.0), side: BorderSide(color: Color(GREEN_COLOR))),
              child: Text(
                "Confirm",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ))
    ],
  );
}

Widget confirmMnemonicWidget() {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 78),
        child: Text(
          "Your new wallet mnemonic has been generated",
          style: TextStyle(color: Color(WHITE_COLOR), fontSize: 18),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 48),
        child: Container(
            width: 490,
            height: 90,
            decoration: BoxDecoration(
                border: new Border.all(color: Color(GRAY_COLOR), width: 1),
                color: Color(0x0ff1c1d20),
                borderRadius: new BorderRadius.all(Radius.circular(45))),
            child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text(
                  'Mnemonic words',
                  style: TextStyle(color: Color(WHITE_COLOR)),
                ))),
      ),
      Padding(
        padding: EdgeInsets.only(top: 12),
        child: Text(
          "Write down your wallet mnemonic and save it in a safe place.",
          style: TextStyle(color: Color(GREEN_COLOR), fontSize: 18),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(
            width: 180,
            height: 40,
            child: RaisedButton(
              textColor: Colors.white,
              onPressed: () {},
              color: Color(GREEN_COLOR),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(33.0), side: BorderSide(color: Color(GREEN_COLOR))),
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ))
    ],
  );
}

Widget importMnemonicWidget() {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 40),
        child: Text(
          "Input your wallet mnemonic words",
          style: TextStyle(color: Color(WHITE_COLOR), fontSize: 18),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 48),
        child: Container(
            width: 490,
            height: 90,
            decoration: BoxDecoration(
                border: new Border.all(color: Color(GRAY_COLOR), width: 1),
                color: Color(0x0ff1c1d20),
                borderRadius: new BorderRadius.all(Radius.circular(45))),
            child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text(
                  'Mnemonic words',
                  style: TextStyle(color: Color(WHITE_COLOR)),
                ))),
      ),
      Padding(
        padding: EdgeInsets.only(top: 14),
        child: Container(
          width: 490,
          height: 73,
          decoration: BoxDecoration(
              border: new Border.all(color: Color(GRAY_COLOR), width: 1),
              color: Color(0x0ff1c1d20),
              borderRadius: new BorderRadius.all(Radius.circular(45))),
          child: inputWidget('Password *', true, (value) {
            print(value);
          }),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(
            width: 180,
            height: 40,
            child: RaisedButton(
              textColor: Colors.white,
              onPressed: () {},
              color: Color(GREEN_COLOR),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(33.0), side: BorderSide(color: Color(GREEN_COLOR))),
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ))
    ],
  );
}

Widget inputWidget(String title, bool isPassword, Function onChanged) {
  return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Color(WHITE_COLOR), fontSize: 12),
          ),
          TextField(
            autofocus: true,
            obscureText: isPassword,
            cursorColor: Color(WHITE_COLOR),
            style: TextStyle(color: Color(WHITE_COLOR)),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ],
      ));
}

enum Tab { Create, Import }
