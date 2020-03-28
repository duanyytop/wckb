import 'dart:convert';

import 'package:ckb_sdk_dart/ckb_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wckb/utils/const.dart';
import 'package:wckb/utils/utils.dart';
import 'package:wckb/wallet/transaction/cell_collector.dart';
import 'package:wckb/wallet/wckb/wckb_cell_collector.dart';

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

  Future<String> getWCKBBalance(Api api) async {
    var cellCollector = WCKBCellCollector(api);
    var daoCodeHash = await SystemContract.getDaoCodeHash(api: api);
    var wckbType = Script(codeHash: WCKB_CODE_HASH, args: daoCodeHash, hashType: Script.Data);
    return shannonToCkb((await cellCollector.getWCKBBalance(address, wckbType.computeHash())).toRadixString(10))
        .toString();
  }

  Future<bool> save() async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(address);
    return await prefs.setString('wallet', toJson());
  }

  static Future<Wallet> getWallet({String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Wallet.fromJson(prefs.getString(name ?? 'wallet'));
  }
}
