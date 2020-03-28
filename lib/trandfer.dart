import 'dart:async';

import 'package:ckb_sdk_dart/ckb_core.dart';
import 'package:ckb_sdk_dart/ckb_utils.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:wckb/components/components.dart';
import 'package:wckb/utils/const.dart';
import 'package:wckb/utils/crypto.dart';
import 'package:wckb/wallet/wallet.dart';
import 'package:wckb/wallet/wckb.dart';

var _screenWidth = 0.0;
var _screenHeight = 0.0;
final _api = Api('http://localhost:8114');
Timer _timer;

class Transfer extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff3c3e45),
        appBar: AppBar(
          title: const Text('WCKB Transfer'),
          backgroundColor: Color(TitleBarColor),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: TransferPage());
  }
}

String _tempPassword = '';
Wallet _wallet;
String _swapAmount = '0';

class TransferPage extends StatefulWidget {
  TransferPage({Key key}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  Tab _tab = Tab.Swap;
  Swap _swap = Swap.ToWCKB;
  String _blockNumber = '0';
  String _ckbBalance = '0';
  String _wckbBalance = '0';

  @override
  void initState() {
    _api.getTipBlockNumber().then((blockNumber) {
      setState(() {
        _blockNumber = '${hexToInt(blockNumber)}';
      });
    });
    Wallet.getWallet().then((wallet) {
      setState(() {
        _wallet = wallet;
      });
      _wallet.getCKBBalance(_api).then((balance) {
        setState(() {
          _ckbBalance = balance;
        });
      });
      _wallet.getWCKBBalance(_api).then((balance) {
        setState(() {
          _wckbBalance = balance;
        });
      });
    });
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      _timer = timer;
      _api.getTipBlockNumber().then((blockNumber) {
        setState(() {
          _blockNumber = '${hexToInt(blockNumber)}';
        });
      });
      Wallet.getWallet().then((wallet) {
        setState(() {
          _wallet = wallet;
        });
        _wallet.getCKBBalance(_api).then((balance) {
          setState(() {
            _ckbBalance = balance;
          });
        });
        _wallet.getWCKBBalance(_api).then((balance) {
          setState(() {
            _wckbBalance = balance;
          });
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: _screenWidth,
        height: _screenHeight - 40,
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
                    ? swapWidget(context, _swap, () {
                        setState(() {
                          _swap = _swap == Swap.ToCKB ? Swap.ToWCKB : Swap.ToCKB;
                        });
                      })
                    : transferWidget(),
              ],
            )),
            balanceWidget(_ckbBalance, _wckbBalance, _blockNumber)
          ],
        ));
  }
}

Widget swapWidget(BuildContext context, Swap swap, Function switchSwap) {
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
                  _swapAmount = value;
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
                  image: AssetImage('assets/images/swap.png'),
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
                _swapAmount = value;
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
              onPressed: () async {
                _showInputDialog(context);
              },
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

Future<String> _showInputDialog(BuildContext context) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter wallet password'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              obscureText: true,
              decoration: new InputDecoration(labelText: 'Wallet password'),
              onChanged: (password) {
                _tempPassword = password;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () async {
              var privateKey = decrypt(_wallet.encryptKey, _tempPassword);
              try {
                var transaction = await generateWckbTx(
                    _api, ckbToShannon(number: int.parse(_swapAmount)), privateKey, _wallet.address);
                var txHash = await _api.sendTransaction(transaction);
                Navigator.of(context).pop();
                Toast.show("Swap success", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                print('ckb swap wckb tx hash: $txHash');
              } catch (e) {
                Toast.show("Swap fail", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
              }
            },
          ),
        ],
      );
    },
  );
}

enum Tab { Swap, Send }

enum Swap { ToWCKB, ToCKB }
