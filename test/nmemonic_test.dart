import 'package:test/test.dart';
import 'package:wckb/wallet/mnemonic.dart';

void main() {
  group('A group tests of mnemonic', () {
    setUp(() {});

    test('Generate mnemonic', () {
      var mnemonic = generateMnemonic('12345678');
      print(mnemonic);
      expect(mnemonic.isNotEmpty, true);
    });
  });
}
