import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:ckb_sdk_dart/ckb_addrss.dart';
import 'package:ckb_sdk_dart/ckb_crypto.dart';
import 'package:ckb_sdk_dart/ckb_utils.dart';
import 'package:wckb/utils/const.dart';
import 'package:wckb/utils/crypto.dart';
import 'package:wckb/wallet/account.dart';

String generateMnemonic(String password) {
  return bip39.generateMnemonic();
}

Future<Account> importWallet(String mnemonic, String password) async {
  var seed = bip39.mnemonicToSeed(mnemonic);
  final root = bip32.BIP32.fromSeed(seed);
  final child = root.derivePath(CKB_HD_PATH);
  final privateKey = listToHex(child.privateKey);
  final encryptKey = encrypt(privateKey, password);

  var lock = await generateLockScriptWithPrivateKey(
      privateKey: privateKey, codeHash: SECP_BLAKE160_CODE_HASH);
  var address = AddressGenerator.generate(Network.TESTNET, lock);

  return Account(encryptKey: encryptKey, address: address);
}
