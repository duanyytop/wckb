import 'dart:math';

import 'package:ckb_sdk_dart/ckb_core.dart';
import 'package:ckb_sdk_dart/ckb_crypto.dart';
import 'package:ckb_sdk_dart/ckb_serialization.dart';
import 'package:ckb_sdk_dart/ckb_utils.dart';
import 'package:ckb_sdk_dart/src/core/rpc/api.dart';
import 'package:ckb_sdk_dart/src/core/system/system_contract.dart';
import 'package:ckb_sdk_dart/src/core/transaction/script_group.dart';
import 'package:ckb_sdk_dart/src/core/transaction/secp256k1_sighash_all_builder.dart';
import 'package:ckb_sdk_dart/src/core/transaction/transaction_builder.dart';
import 'package:ckb_sdk_dart/src/core/type/witness.dart';
import 'package:ckb_sdk_dart/src/crypto/sign.dart';
import 'package:ckb_sdk_dart/src/serialization/fixed/uint128.dart';
import 'package:wckb/utils/const.dart';
import 'package:wckb/utils/utils.dart';

import 'transaction/collect_utils.dart';
import 'transaction/receiver.dart';
import 'transaction/script_group_with_private_keys.dart';
import 'wckb//wckb_cell_collector.dart';

const String NERVOS_DAO_DATA = '0x0000000000000000';
const String WCKB_DATA_PLACEHOLDER = '0x000000000000000000000000000000000000000000000000';
BigInt UnitCKB = BigInt.from(100000000);
const int DAO_LOCK_PERIOD_EPOCHS = 180;
const int DAO_MATURITY_BLOCKS = 5;

const String NODE_URL = 'http://localhost:8114';
const String DaoTestPrivateKey = 'd00c06bfd800d27397002dca6fb0993d5ba6399b4238b2f29ee9deb97593d2bc';
const String DaoTestAddress = 'ckt1qyqvsv5240xeh85wvnau2eky8pwrhh4jr8ts8vyj37';

const String DaoTestPrivateKey1 = '08730a367dfabcadb805d69e0e613558d5160eb8bab9d6e326980c2c46a05db2';
const String DaoTestAddress1 = 'ckt1qyqxgp7za7dajm5wzjkye52asc8fxvvqy9eqlhp82g';

Future<Transaction> generateWckbTx(Api api, BigInt wckbAmount, String privateKey, String address) async {
  var daoCodeHash = await SystemContract.getDaoCodeHash(api: api);
  var daoType = Script(codeHash: daoCodeHash, args: '0x', hashType: Script.Type);
  var wckbType = Script(codeHash: WCKB_CODE_HASH, args: daoCodeHash, hashType: Script.Data);
  var txUtils = CollectUtils(api);

  var cellOutputs =
      txUtils.generateOutputs([Receiver(address, wckbAmount), Receiver(address, WCKB_TRANSFER_DAO_CAPACITY)], address);

  cellOutputs[0].type = daoType;
  cellOutputs[0].lock = Script(
      codeHash: ALWAYS_SUCCESS_CODE_HASH, args: generateLockScriptWithAddress(address).args, hashType: Script.Data);

  cellOutputs[1].type = wckbType;
  cellOutputs[1].lock = Script(
      codeHash: ALWAYS_SUCCESS_CODE_HASH, args: generateLockScriptWithAddress(address).args, hashType: Script.Data);

  var cellOutputsData = [
    NERVOS_DAO_DATA,
    '${listToHex(UInt128(wckbAmount).toBytes())}${cleanHexPrefix(NERVOS_DAO_DATA)}',
    '0x'
  ];

  var scriptGroupWithPrivateKeysList = [];
  var txBuilder = TransactionBuilder(api);
  txBuilder.addOutputs(cellOutputs);
  txBuilder.setOutputsData(cellOutputsData);
  txBuilder
      .addCellDep(CellDep(outPoint: (await SystemContract.getSystemDaoCell(api: api)).outPoint, depType: CellDep.Code));
  txBuilder.addCellDep(
      CellDep(outPoint: OutPoint(txHash: ALWAYS_SUCCESS_OUT_POINT_TX_HASH, index: '0x0'), depType: CellDep.Code));
  txBuilder
      .addCellDep(CellDep(outPoint: OutPoint(txHash: WCKB_OUT_POINT_TX_HASH, index: '0x1'), depType: CellDep.Code));

  // You can get fee rate by rpc or set a simple number
  // BigInteger feeRate = Numeric.toBigInt(api.estimateFeeRate("5").feeRate);
  var feeRate = BigInt.from(1024);
  var collectUtils = CollectUtils(api, skipDataAndType: true);
  var collectResult = await collectUtils.collectInputs([address], txBuilder.buildTx(), feeRate, Sign.SIGN_LENGTH * 2);

  // update change output capacity after collecting cells
  cellOutputs[cellOutputs.length - 1].capacity = collectResult.changeCapacity;
  txBuilder.setOutputs(cellOutputs);

  var startIndex = 0;
  for (var cellsWithAddress in collectResult.cellsWithAddresses) {
    txBuilder.addInputs(cellsWithAddress.inputs);
    for (var i = 0; i < cellsWithAddress.inputs.length; i++) {
      txBuilder.addWitness(i == 0 ? Witness(lock: Witness.SIGNATURE_PLACEHOLDER) : '0x');
    }
    scriptGroupWithPrivateKeysList.add(ScriptGroupWithPrivateKeys(
        ScriptGroup(regionToList(startIndex, cellsWithAddress.inputs.length)), [privateKey]));
    startIndex += cellsWithAddress.inputs.length;
  }

  var signBuilder = Secp256k1SighashAllBuilder(txBuilder.buildTx());

  for (var scriptGroupWithPrivateKeys in scriptGroupWithPrivateKeysList) {
    signBuilder.sign(scriptGroupWithPrivateKeys.scriptGroup, scriptGroupWithPrivateKeys.privateKeys[0]);
  }
  return signBuilder.buildTx();
}

Future<Transaction> swapWckbTx(Api api, BigInt transferWckbAmount) async {
  var daoCodeHash = await SystemContract.getDaoCodeHash(api: api);
  var wckbType = Script(codeHash: WCKB_CODE_HASH, args: daoCodeHash, hashType: Script.Data);
  var txUtils = CollectUtils(api);

  var cellOutputs = txUtils.generateOutputsNoChange(
      [Receiver(DaoTestAddress, WCKB_TRANSFER_CAPACITY), Receiver(DaoTestAddress1, WCKB_TRANSFER_CAPACITY)]);

  cellOutputs[0].type = wckbType;
  cellOutputs[0].lock = Script(
      codeHash: ALWAYS_SUCCESS_OUT_POINT_TX_HASH,
      args: generateLockScriptWithAddress(DaoTestAddress).args,
      hashType: Script.Type);

  cellOutputs[1].type = wckbType;
  cellOutputs[1].lock = Script(
      codeHash: ALWAYS_SUCCESS_OUT_POINT_TX_HASH,
      args: generateLockScriptWithAddress(DaoTestAddress1).args,
      hashType: Script.Type);

  var txBuilder = TransactionBuilder(api);
  txBuilder.addOutputs(cellOutputs);
  txBuilder.addCellDep(
      CellDep(outPoint: OutPoint(txHash: ALWAYS_SUCCESS_OUT_POINT_TX_HASH, index: '0x0'), depType: CellDep.DepGroup));
  txBuilder
      .addCellDep(CellDep(outPoint: OutPoint(txHash: WCKB_OUT_POINT_TX_HASH, index: '0x1'), depType: CellDep.Code));

  var collectResult =
      await WCKBCellCollector(api).collectInputs(DaoTestAddress, wckbType.computeHash(), WCKB_TRANSFER_CAPACITY);
  var collectResult1 =
      await WCKBCellCollector(api).collectInputs(DaoTestAddress1, wckbType.computeHash(), WCKB_TRANSFER_CAPACITY);

  txBuilder.setHeaderDeps([collectResult[0].blockHash, collectResult1[0].blockHash]);
  var maxHeight = max(hexToInt(collectResult[0].height), hexToInt(collectResult1[0].height));
  var minHeight = min(hexToInt(collectResult[0].height), hexToInt(collectResult1[0].height));
  var maxAR = cleanHexPrefix((await api.getBlockByNumber(intToHex(maxHeight))).header.dao).substring(8, 17);
  var minAR = cleanHexPrefix((await api.getBlockByNumber(intToHex(minHeight))).header.dao).substring(8, 17);
  var ar = u32FromBytes(hexToList(maxAR)).getValue() - u32FromBytes(hexToList(minAR)).getValue();
  var cellWithBlock = minHeight == hexToInt(collectResult[0].height) ? collectResult[0] : collectResult1[0];
  var interest =
      (hexToBigInt(cellWithBlock.wckbAmount) - WCKB_MIN_CELL_CAPACITY) * BigInt.from(ar) / (BigInt.from(10).pow(16));
  var outputsData1 =
      '0x${hexToBigInt(collectResult[0].wckbAmount) - transferWckbAmount + BigInt.from(interest.toInt())}${listToHexNoPrefix(UInt64.fromInt(maxHeight).toBytes())}';
  var outputsData2 =
      '0x${hexToBigInt(collectResult1[0].wckbAmount) + transferWckbAmount}${listToHexNoPrefix(UInt64.fromInt(maxHeight).toBytes())}';

  txBuilder.setOutputsData([outputsData1, outputsData2]);

  txBuilder.addInput(collectResult[0].input);
  txBuilder.addWitness(Witness(lock: Witness.SIGNATURE_PLACEHOLDER, inputType: '0'));
  txBuilder.addInput(collectResult1[0].input);
  txBuilder.addWitness('0x');

  var signBuilder = Secp256k1SighashAllBuilder(txBuilder.buildTx());

  signBuilder.sign(ScriptGroup([0]), DaoTestPrivateKey);
  return signBuilder.buildTx();
}
