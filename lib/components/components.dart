import 'package:flutter/material.dart';

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
