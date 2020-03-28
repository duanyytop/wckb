import 'package:ckb_sdk_dart/ckb_utils.dart';
import 'package:flutter/cupertino.dart';

const CKB_HD_PATH = "m/44'/309'/0'/0/0";
const String SECP_BLAKE160_CODE_HASH = '9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8';
BigInt UnitCKB = BigInt.from(100000000);

const int GREEN_COLOR = 0xff3cc68a;
const int GRAY_COLOR = 0xff3c3e45;
const int WHITE_COLOR = 0xffbababa;

const Map<int, Color> TitleBarColors = {
  50: Color.fromRGBO(0x1c, 0x1d, 0x20, .1),
  100: Color.fromRGBO(0x1c, 0x1d, 0x20, .2),
  200: Color.fromRGBO(0x1c, 0x1d, 0x20, .3),
  300: Color.fromRGBO(0x1c, 0x1d, 0x20, .4),
  400: Color.fromRGBO(0x1c, 0x1d, 0x20, .5),
  500: Color.fromRGBO(0x1c, 0x1d, 0x20, .6),
  600: Color.fromRGBO(0x1c, 0x1d, 0x20, .7),
  700: Color.fromRGBO(0x1c, 0x1d, 0x20, .8),
  800: Color.fromRGBO(0x1c, 0x1d, 0x20, .9),
  900: Color.fromRGBO(0x1c, 0x1d, 0x20, 1),
};

const TitleBarColor = 0xFF1C1D20;

final String ALWAYS_SUCCESS_CODE_HASH = '0x56806108025878f143d767a5e642f83b3043b185ed891a41eb71a7873b3f7284';
final String ALWAYS_SUCCESS_OUT_POINT_TX_HASH = '0x85728ac46bb61963bcb80bca6fc200bdd4e4330dee89478de4c8df5a915eee37';
final BigInt WCKB_MIN_CELL_CAPACITY = ckbToShannon(number: 150);
final BigInt WCKB_TRANSFER_CAPACITY = ckbToShannon(number: 149);
final BigInt WCKB_TRANSFER_DAO_CAPACITY = ckbToShannon(number: 200);
final String WCKB_CODE_HASH = '0x90de6515262517d972127ca94ff6eb9bf94ac4d79dde01abcecbf56305fc5965';
final String WCKB_OUT_POINT_TX_HASH = '0x0d4d8ab43cdbc6ed649cd25070373103ca990c3a3b003f8e7650aa66592da5f9';
