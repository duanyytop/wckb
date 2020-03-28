import 'package:test/test.dart';
import 'package:wckb/wallet/wallet.dart';

void main() {
  group('A group tests of wallet', () {
    setUp(() {});

    test('wallet toJson', () {
      var wallet = Wallet(name: 'wallet1', encryptKey: '123455', address: 'ckt123');
      expect(wallet.toJson(), '{ "name": "wallet1", "encryptKey": "123455", "address": "ckt123"}');

      var wallet1 = Wallet.fromJson('{ "name": "wallet1", "encryptKey": "123455", "address": "ckt123"}');
      expect(wallet1.name, 'wallet1');
    });
  });
}
