import 'dart:math';
import 'dart:typed_data';

import 'package:ckb_sdk_dart/ckb_serialization.dart';

double shannonToCkb(String shannon) {
  return double.parse(shannon) / pow(10, 8);
}

UInt32 u32FromBytes(Uint8List bytes) {
  var result = 0;
  for (var i = 3; i >= 0; i--) {
    result += (bytes[i] & 0xff) << 8 * i;
  }
  return UInt32(result);
}
