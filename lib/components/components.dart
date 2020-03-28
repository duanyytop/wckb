import 'package:flutter/material.dart';
import 'package:wckb/utils/const.dart';

Widget welcomeWCKB() {
  return Padding(
    padding: EdgeInsets.only(left: 50),
    child: Container(
      width: 360,
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Hello World', style: TextStyle(fontSize: 18, color: Color(0xffbababa), fontWeight: FontWeight.w600)),
          Padding(
              padding: EdgeInsets.only(top: 18),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: "Welcome \nto  ", style: TextStyle(fontSize: 60, color: Colors.white)),
                  TextSpan(
                      text: "WCKB",
                      style: TextStyle(
                        color: Color(0xff3cc68a),
                        fontSize: 60,
                      )),
                  TextSpan(text: "  :)", style: TextStyle(fontSize: 60, color: Colors.white)),
                ]),
              ))
        ],
      ),
    ),
  );
}

Widget mainPenal(Widget business) {
  return Padding(
    padding: EdgeInsets.only(left: 84),
    child: Container(
      width: 580,
      height: 474,
      decoration: BoxDecoration(
        border: new Border.all(color: Colors.white, width: 1),
        borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(82), bottomRight: Radius.circular(82)),
      ),
      child: business,
    ),
  );
}

Widget tabWidget(bool isSelected, String title) {
  return Container(
    width: 289,
    height: 56,
    decoration: BoxDecoration(
        border: new Border.all(color: Color(isSelected ? GREEN_COLOR : GRAY_COLOR), width: 1),
        color: Color(0x0ff1c1d20)),
    child: Center(
      child: Text(
        title,
        style: TextStyle(color: Color(isSelected ? GREEN_COLOR : WHITE_COLOR), fontSize: 21),
      ),
    ),
  );
}

Widget balanceWidget(String ckbBalance, String wckbBalance, String blockNumber) {
  return Padding(
    padding: EdgeInsets.only(left: 50),
    child: Container(
      width: 460,
      height: 340,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Balance: ', style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.w600)),
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('CKB', style: TextStyle(color: Color(WHITE_COLOR), fontSize: 21)),
                      Padding(
                        padding: EdgeInsets.only(left: 115),
                        child: Text(ckbBalance, style: TextStyle(color: Colors.white, fontSize: 21)),
                      )
                    ],
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(height: 2.0, indent: 0.0, color: Color(WHITE_COLOR)),
          ),
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('WCKB', style: TextStyle(color: Color(WHITE_COLOR), fontSize: 21)),
                      Padding(
                        padding: EdgeInsets.only(left: 95),
                        child: Text(wckbBalance, style: TextStyle(color: Color(GREEN_COLOR), fontSize: 21)),
                      )
                    ],
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(height: 2.0, indent: 0.0, color: Color(WHITE_COLOR)),
          ),
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Block Number', style: TextStyle(color: Color(WHITE_COLOR), fontSize: 21)),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(blockNumber, style: TextStyle(color: Color(GREEN_COLOR), fontSize: 21)),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    ),
  );
}
