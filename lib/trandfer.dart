import 'package:flutter/material.dart';
import 'package:wckb/components/components.dart';
import 'package:wckb/utils/const.dart';

var _screenWidth = 0.0;
var _screenHeight = 0.0;

class Transfer extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransferPage(),
    );
  }
}

class TransferPage extends StatefulWidget {
  TransferPage({Key key}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  Tab _tab = Tab.Swap;
  Swap _swap = Swap.ToWCKB;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xff3c3e45),
        body: Container(
            width: _screenWidth,
            height: _screenHeight,
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
                                _tab = Tab.Swap;
                              });
                            },
                            child: tabWidget(_tab == Tab.Swap, 'Swap')),
                        new GestureDetector(
                            onTap: () {
                              setState(() {
                                _tab = Tab.Send;
                              });
                            },
                            child: tabWidget(_tab == Tab.Send, 'Send'))
                      ],
                    ),
                    _tab == Tab.Swap
                        ? swapWidget(_swap, () {
                            setState(() {
                              _swap = _swap == Swap.ToCKB ? Swap.ToWCKB : Swap.ToCKB;
                            });
                          })
                        : transferWidget(),
                  ],
                )),
                balanceWidget('1223434.3434', '2343434.45656', '12334')
              ],
            )));
  }
}

Widget swapWidget(Swap swap, Function switchSwap) {
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
            child: Stack(
              children: <Widget>[
                inputWidget('Input', false, (value) {
                  print(value);
                }),
                Positioned(
                  left: 400,
                  top: 27,
                  child: Text(
                    swap == Swap.ToCKB ? 'WCKB' : 'CKB',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                )
              ],
            )),
      ),
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Center(
          child: SizedBox(
            width: 34,
            height: 34,
            child: GestureDetector(
                onTap: () {
                  switchSwap();
                },
                child: Image(
                  image: AssetImage('assets/images/transfer.jpg'),
                )),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Container(
          width: 490,
          height: 73,
          decoration: BoxDecoration(
              border: new Border.all(color: Color(GRAY_COLOR), width: 1),
              color: Color(0x0ff1c1d20),
              borderRadius: new BorderRadius.all(Radius.circular(45))),
          child: Stack(
            children: <Widget>[
              inputWidget('Output', false, (value) {
                print(value);
              }),
              Positioned(
                left: 400,
                top: 27,
                child: Text(
                  swap == Swap.ToCKB ? 'CKB' : 'WCKB',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              )
            ],
          ),
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
                "Swap",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ))
    ],
  );
}

Widget transferWidget() {
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
            child: Stack(
              children: <Widget>[
                inputWidget('Amount', false, (value) {
                  print(value);
                }),
                Positioned(
                  left: 400,
                  top: 27,
                  child: Text(
                    'WCKB',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                )
              ],
            )),
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
          child: inputWidget('From', true, (value) {
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
          child: inputWidget('To', true, (value) {
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
                "Confirm",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ))
    ],
  );
}

Widget inputWidget(String title, bool isPassword, Function onChanged) {
  return Padding(
      padding: EdgeInsets.only(left: 30, right: 0, top: 5),
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

enum Tab { Swap, Send }

enum Swap { ToWCKB, ToCKB }
