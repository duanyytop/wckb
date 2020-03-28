import 'package:test/test.dart';
import 'package:wckb/wallet/mnemonic.dart';

void main() {
  group('A group tests of address generator', () {
    setUp(() {});

    test('Generate testnet address with any arg', () {
      var mnemonic = generateMnemonic('12345678');
      expect(mnemonic.isNotEmpty, true);
    });
  });
}
