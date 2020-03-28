import 'package:ckb_sdk_dart/ckb_core.dart';
import 'package:wckb/utils/utils.dart';
import 'package:wckb/wallet/account.dart';
import 'package:wckb/wallet/transaction/cell_collector.dart';

class Wallet {
  String name;
  Account account;

  Wallet(this.name, this.account);

  Future<String> getCKBBalance(Api api) async {
    var cellCollector = CellCollector(api);
    return shannonToCkb((await cellCollector.getCapacityWithAddress(account.address)).toRadixString(10)).toString();
  }
}
