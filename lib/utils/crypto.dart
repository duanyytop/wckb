import 'package:ckb_sdk_dart/ckb_crypto.dart';
import 'package:ckb_sdk_dart/ckb_utils.dart';
import 'package:encrypt/encrypt.dart';

String encrypt(String origin, String password) {
  final key = Key(hexToList(Blake2b.hash(password)));
  final iv = IV.fromLength(16);
  final encrypt = Encrypter(AES(key));
  return listToHex(encrypt.encrypt(origin, iv: iv).bytes);
}

String decrypt(String encrypted, String password) {
  final key = Key.fromUtf8(password);
  final iv = IV.fromLength(16);
  final encrypt = Encrypter(AES(key));
  return encrypt.decrypt(Encrypted.fromUtf8(encrypted), iv: iv);
}
