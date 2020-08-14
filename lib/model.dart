import 'package:equatable/equatable.dart';

class BrotherModel extends Equatable {
  final int codeIOS;
  final int codeAndroid;
  final String nameIOS; // 'Brother QL-820NWB' for `setPrinterNames` method
  final String nameAndroid; // 'QL-820NWB' for `getNetPrinters` method

  const BrotherModel({
    this.codeIOS,
    this.nameIOS,
    this.codeAndroid,
    this.nameAndroid,
  });

  @override
  List<Object> get props => [
        codeIOS,
        codeAndroid,
        nameIOS,
        nameAndroid,
      ];
}

// Mapping for enum from iOS SDK and Android SDK
const BRLMPrinterModelPJ_673 = BrotherModel(codeIOS: 0, nameIOS: 'Brother PJ-763', codeAndroid: 255, nameAndroid: 'PJ-763'); // not available on Android
const BRLMPrinterModelPJ_763MFi = BrotherModel(codeIOS: 1, nameIOS: 'Brother PJ-673', codeAndroid: 32, nameAndroid: 'PJ-673');
const BRLMPrinterModelPJ_773 = BrotherModel(codeIOS: 2, nameIOS: 'Brother PJ-773', codeAndroid: 29, nameAndroid: 'PJ-773');
const BRLMPrinterModelMW_145MFi = BrotherModel(codeIOS: 3, nameIOS: 'Brother MW-145MF', codeAndroid: 34, nameAndroid: 'MW-145MF');
const BRLMPrinterModelMW_260MFi = BrotherModel(codeIOS: 4, nameIOS: 'Brother MW-260MF', codeAndroid: 35, nameAndroid: 'MW-260MF');
const BRLMPrinterModelMW_170 = BrotherModel(codeIOS: 5, nameIOS: 'Brother MW-170', codeAndroid: 66, nameAndroid: 'MW-170');
const BRLMPrinterModelMW_270 = BrotherModel(codeIOS: 6, nameIOS: 'Brother MW-270', codeAndroid: 67, nameAndroid: 'MW-270');
const BRLMPrinterModelRJ_4030Ai = BrotherModel(codeIOS: 7, nameIOS: 'Brother RJ-4030Ai', codeAndroid: 41, nameAndroid: 'RJ-4030Ai');
const BRLMPrinterModelRJ_4040 = BrotherModel(codeIOS: 8, nameIOS: 'Brother RJ-4040', codeAndroid: 14, nameAndroid: 'RJ-4040');
const BRLMPrinterModelRJ_3050 = BrotherModel(codeIOS: 9, nameIOS: 'Brother RJ-3050', codeAndroid: 16, nameAndroid: 'RJ-3050');
const BRLMPrinterModelRJ_3150 = BrotherModel(codeIOS: 10, nameIOS: 'Brother RJ-3150', codeAndroid: 15, nameAndroid: 'RJ-3150');
const BRLMPrinterModelRJ_3050Ai = BrotherModel(codeIOS: 11, nameIOS: 'Brother RJ-3050Ai', codeAndroid: 49, nameAndroid: 'RJ-3050Ai');
const BRLMPrinterModelRJ_3150Ai = BrotherModel(codeIOS: 12, nameIOS: 'Brother RJ-3150Ai', codeAndroid: 50, nameAndroid: 'RJ-3150Ai');
const BRLMPrinterModelRJ_2050 = BrotherModel(codeIOS: 13, nameIOS: 'Brother RJ-2050', codeAndroid: 46, nameAndroid: 'RJ-2050');
const BRLMPrinterModelRJ_2140 = BrotherModel(codeIOS: 14, nameIOS: 'Brother RJ-2140', codeAndroid: 47, nameAndroid: 'RJ-2140');
const BRLMPrinterModelRJ_2150 = BrotherModel(codeIOS: 15, nameIOS: 'Brother RJ-2150', codeAndroid: 48, nameAndroid: 'RJ-2150');
const BRLMPrinterModelRJ_4230B = BrotherModel(codeIOS: 16, nameIOS: 'Brother RJ-4230B', codeAndroid: 59, nameAndroid: 'RJ-4230B');
const BRLMPrinterModelRJ_4250WB = BrotherModel(codeIOS: 17, nameIOS: 'Brother RJ-4250WB', codeAndroid: 60, nameAndroid: 'RJ-4250WB');
const BRLMPrinterModelTD_2120N = BrotherModel(codeIOS: 18, nameIOS: 'Brother TD-2120N', codeAndroid: 21, nameAndroid: 'TD-2120N');
const BRLMPrinterModelTD_2130N = BrotherModel(codeIOS: 19, nameIOS: 'Brother TD-2130N', codeAndroid: 22, nameAndroid: 'TD-2130N');
const BRLMPrinterModelTD_4100N = BrotherModel(codeIOS: 20, nameIOS: 'Brother TD-4410D', codeAndroid: 25, nameAndroid: 'TD-4410D');
const BRLMPrinterModelTD_4420DN = BrotherModel(codeIOS: 21, nameIOS: 'Brother TD-4420DN', codeAndroid: 62, nameAndroid: 'TD-4420DN');
const BRLMPrinterModelTD_4520DN = BrotherModel(codeIOS: 22, nameIOS: 'Brother TD-4520DN', codeAndroid: 64, nameAndroid: 'TD-4520DN');
const BRLMPrinterModelTD_4550DNWB = BrotherModel(codeIOS: 23, nameIOS: 'Brother TD-4550DNWB', codeAndroid: 65, nameAndroid: 'TD-4550DNWB');
const BRLMPrinterModelQL_710W = BrotherModel(codeIOS: 24, nameIOS: 'Brother QL-710W', codeAndroid: 18, nameAndroid: 'QL-710W');
const BRLMPrinterModelQL_720NW = BrotherModel(codeIOS: 25, nameIOS: 'Brother QL-720NW', codeAndroid: 19, nameAndroid: 'QL-720NW');
const BRLMPrinterModelQL_810W = BrotherModel(codeIOS: 26, nameIOS: 'Brother QL-810W', codeAndroid: 52, nameAndroid: 'QL-810W');
const BRLMPrinterModelQL_820NWB = BrotherModel(codeIOS: 27, nameIOS: 'Brother QL-820NWB', codeAndroid: 53, nameAndroid: 'QL-820NWB');
const BRLMPrinterModelQL_1110NWB = BrotherModel(codeIOS: 28, nameIOS: 'Brother QL-1110NWB', codeAndroid: 55, nameAndroid: 'QL-1110NWB');
const BRLMPrinterModelQL_1115NWB = BrotherModel(codeIOS: 29, nameIOS: 'Brother QL-1115NWB', codeAndroid: 56, nameAndroid: 'QL-1115NWB');
const BRLMPrinterModelPT_E550W = BrotherModel(codeIOS: 30, nameIOS: 'Brother PT-E550W', codeAndroid: 23, nameAndroid: 'PT-E550W');
const BRLMPrinterModelPT_P750W = BrotherModel(codeIOS: 31, nameIOS: 'Brother PT-P750W', codeAndroid: 24, nameAndroid: 'PT-P750W');
const BRLMPrinterModelPT_D800W = BrotherModel(codeIOS: 32, nameIOS: 'Brother PT-D800W', codeAndroid: 38, nameAndroid: 'PT-D800W');
const BRLMPrinterModelPT_E800W = BrotherModel(codeIOS: 33, nameIOS: 'Brother PT-E800W', codeAndroid: 42, nameAndroid: 'PT-E800W');
const BRLMPrinterModelPT_E850TKW = BrotherModel(codeIOS: 34, nameIOS: 'Brother PT-E850TKW', codeAndroid: 37, nameAndroid: 'PT-E850TKW');
const BRLMPrinterModelPT_P900W = BrotherModel(codeIOS: 35, nameIOS: 'Brother PT-P900W', codeAndroid: 39, nameAndroid: 'PT-P900W');
const BRLMPrinterModelPT_P950NW = BrotherModel(codeIOS: 36, nameIOS: 'Brother PT-P950NW', codeAndroid: 40, nameAndroid: 'PT-P950NW');
const BRLMPrinterModelPT_P300BT = BrotherModel(codeIOS: 37, nameIOS: 'Brother PT-P300BT', codeAndroid: 36, nameAndroid: 'PT-P300BT');
const BRLMPrinterModelPT_P710BT = BrotherModel(codeIOS: 38, nameIOS: 'Brother PT-P710BT', codeAndroid: 57, nameAndroid: 'PT-P710BT');
const BRLMPrinterModelPT_P715eBT = BrotherModel(codeIOS: 39, nameIOS: 'Brother PT-P715eBT', codeAndroid: 69, nameAndroid: 'PT-P715eBT');
const BRLMPrinterModelPT_P910BT = BrotherModel(codeIOS: 40, nameIOS: 'Brother PT-P910BT', codeAndroid: 68, nameAndroid: 'PT-P910BT');

const brotherModels = [
  BRLMPrinterModelPJ_673,
  BRLMPrinterModelPJ_763MFi,
  BRLMPrinterModelPJ_773,
  BRLMPrinterModelMW_145MFi,
  BRLMPrinterModelMW_260MFi,
  BRLMPrinterModelMW_170,
  BRLMPrinterModelMW_270,
  BRLMPrinterModelRJ_4030Ai,
  BRLMPrinterModelRJ_4040,
  BRLMPrinterModelRJ_3050,
  BRLMPrinterModelRJ_3150,
  BRLMPrinterModelRJ_3050Ai,
  BRLMPrinterModelRJ_3150Ai,
  BRLMPrinterModelRJ_2050,
  BRLMPrinterModelRJ_2140,
  BRLMPrinterModelRJ_2150,
  BRLMPrinterModelRJ_4230B,
  BRLMPrinterModelRJ_4250WB,
  BRLMPrinterModelTD_2120N,
  BRLMPrinterModelTD_2130N,
  BRLMPrinterModelTD_4100N,
  BRLMPrinterModelTD_4420DN,
  BRLMPrinterModelTD_4520DN,
  BRLMPrinterModelTD_4550DNWB,
  BRLMPrinterModelQL_710W,
  BRLMPrinterModelQL_720NW,
  BRLMPrinterModelQL_810W,
  BRLMPrinterModelQL_820NWB,
  BRLMPrinterModelQL_1110NWB,
  BRLMPrinterModelQL_1115NWB,
  BRLMPrinterModelPT_E550W,
  BRLMPrinterModelPT_P750W,
  BRLMPrinterModelPT_D800W,
  BRLMPrinterModelPT_E800W,
  BRLMPrinterModelPT_E850TKW,
  BRLMPrinterModelPT_P900W,
  BRLMPrinterModelPT_P950NW,
  BRLMPrinterModelPT_P300BT,
  BRLMPrinterModelPT_P710BT,
  BRLMPrinterModelPT_P715eBT,
  BRLMPrinterModelPT_P910BT,
];
