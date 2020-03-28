import 'dart:convert';

import 'package:ckb_sdk_dart/ckb_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wckb/utils/utils.dart';
import 'package:wckb/wallet/transaction/cell_collector.dart';

class Wallet {
  String name;
  String encryptKey;
  String address;

  Wallet({this.name, this.encryptKey, this.address});

  String toJson() {
    return '{ "name": "${this.name}", "encryptKey": "${this.encryptKey}", "address": "${this.address}"}';
  }

  factory Wallet.fromJson(String json) {
    var temp = jsonDecode(json);
    if (temp == null) return null;
    return Wallet(
      name: temp['name'],
      encryptKey: temp['encryptKey'],
      address: temp['address'],
    );
  }

  Future<String> getCKBBalance(Api api) async {
    var cellCollector = CellCollector(api);
    return shannonToCkb((await cellCollector.getCapacityWithAddress(address)).toRadixString(10)).toString();
  }

  Future<bool> save() async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(name) == null) {
      return await prefs.setString(name, toJson());
    }
    return false;
  }

  static Future<Wallet> getWallet(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Wallet.fromJson(prefs.getString(name));
  }
}
