import 'package:test/test.dart';
import 'package:wckb/utils/crypto.dart';

void main() {
  group('A group tests of crypto', () {
    setUp(() {});

    test('Encrypt', () {
      var encrypted = encrypt('12345678', '12345678');
      expect(encrypted.isNotEmpty, true);
    });
  });
}
