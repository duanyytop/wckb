import 'package:test/test.dart';
import 'package:wckb/utils/crypto.dart';

void main() {
  group('A group tests of crypto', () {
    setUp(() {});

    test('Encrypt', () {
      var encrypted = encrypt('12345678', '12345678');
      expect(encrypted, '0x27553fc7c555affc28190a8e4dd39599');
    });

    test('Decrypt', () {
      var origin = decrypt('0x27553fc7c555affc28190a8e4dd39599', '12345678');
      expect(origin, '12345678');
    });
  });
}
