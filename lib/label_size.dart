enum BrotherLabelSize {
  QLDieCutW17H54,
  QLDieCutW17H87,
  QLDieCutW23H23,
  QLDieCutW29H42,
  QLDieCutW29H90,
  QLDieCutW38H90,
  QLDieCutW39H48,
  QLDieCutW52H29,
  QLDieCutW62H29,
  QLDieCutW62H100,
  QLDieCutW60H86,
  QLDieCutW54H29,
  QLDieCutW102H51,
  QLDieCutW102H152,
  QLDieCutW103H164,
  QLRollW12,
  QLRollW29,
  QLRollW38,
  QLRollW50,
  QLRollW54,
  QLRollW62,
  QLRollW62RB,
  QLRollW102,
  QLRollW103,
  QLDTRollW90,
  QLDTRollW102,
  QLDTRollW102H51,
  QLDTRollW102H152,
  PT3_5mm,
  PT6mm,
  PT9mm,
  PT12mm,
  PT18mm,
  PT24mm,
  PT36mm,
  PTHS_5_8mm,
  PTHS_8_8mm,
  PTHS_11_7mm,
  PTHS_17_7mm,
  PTHS_23_6mm,
  PTFL_21x45mm,
}

extension BrotherLabelSizeExtension on BrotherLabelSize {
  String toParam() {
    switch (this) {
      case BrotherLabelSize.QLDieCutW17H54:
        return "DieCutW17H54";
      case BrotherLabelSize.QLDieCutW17H87:
        return "DieCutW17H87";
      case BrotherLabelSize.QLDieCutW23H23:
        return "DieCutW23H23";
      case BrotherLabelSize.QLDieCutW29H42:
        return "DieCutW29H42";
      case BrotherLabelSize.QLDieCutW29H90:
        return "DieCutW29H90";
      case BrotherLabelSize.QLDieCutW38H90:
        return "DieCutW38H90";
      case BrotherLabelSize.QLDieCutW39H48:
        return "DieCutW39H48";
      case BrotherLabelSize.QLDieCutW52H29:
        return "DieCutW52H29";
      case BrotherLabelSize.QLDieCutW62H29:
        return "DieCutW62H29";
      case BrotherLabelSize.QLDieCutW62H100:
        return "DieCutW62H100";
      case BrotherLabelSize.QLDieCutW60H86:
        return "DieCutW60H86";
      case BrotherLabelSize.QLDieCutW54H29:
        return "DieCutW54H29";
      case BrotherLabelSize.QLDieCutW102H51:
        return "DieCutW102H51";
      case BrotherLabelSize.QLDieCutW102H152:
        return "DieCutW102H152";
      case BrotherLabelSize.QLDieCutW103H164:
        return "DieCutW103H164";
      case BrotherLabelSize.QLRollW12:
        return "RollW12";
      case BrotherLabelSize.QLRollW29:
        return "RollW29";
      case BrotherLabelSize.QLRollW38:
        return "RollW38";
      case BrotherLabelSize.QLRollW50:
        return "RollW50";
      case BrotherLabelSize.QLRollW54:
        return "RollW54";
      case BrotherLabelSize.QLRollW62:
        return "RollW62";
      case BrotherLabelSize.QLRollW62RB:
        return "RollW62RB";
      case BrotherLabelSize.QLRollW102:
        return "RollW102";
      case BrotherLabelSize.QLRollW103:
        return "RollW103";
      case BrotherLabelSize.QLDTRollW90:
        return "DTRollW90";
      case BrotherLabelSize.QLDTRollW102:
        return "DTRollW102";
      case BrotherLabelSize.QLDTRollW102H51:
        return "DTRollW102H51";
      case BrotherLabelSize.QLDTRollW102H152:
        return "DTRollW102H152";
      case BrotherLabelSize.PT3_5mm:
        return "3_5mm";
      case BrotherLabelSize.PT6mm:
        return "6mm";
      case BrotherLabelSize.PT9mm:
        return "9mm";
      case BrotherLabelSize.PT12mm:
        return "12mm";
      case BrotherLabelSize.PT18mm:
        return "18mm";
      case BrotherLabelSize.PT24mm:
        return "24mm";
      case BrotherLabelSize.PT36mm:
        return "36mm";
      case BrotherLabelSize.PTHS_5_8mm:
        return "HS_5_8mm";
      case BrotherLabelSize.PTHS_8_8mm:
        return "HS_8_8mm";
      case BrotherLabelSize.PTHS_11_7mm:
        return "HS_11_7mm";
      case BrotherLabelSize.PTHS_17_7mm:
        return "HS_17_7mm";
      case BrotherLabelSize.PTHS_23_6mm:
        return "HS_23_6mm";
      case BrotherLabelSize.PTFL_21x45mm:
        return "FL_21x45mm";
    }
  }

  String get description {
    switch (this) {
      case BrotherLabelSize.QLDieCutW17H54:
        return "17mm x 54mm";
      case BrotherLabelSize.QLDieCutW17H87:
        return "17mm x 87mm";
      case BrotherLabelSize.QLDieCutW23H23:
        return "23mm x 23mm";
      case BrotherLabelSize.QLDieCutW29H42:
        return "29mm x 42mm";
      case BrotherLabelSize.QLDieCutW29H90:
        return "29mm x 90mm";
      case BrotherLabelSize.QLDieCutW38H90:
        return "38mm x 90mm";
      case BrotherLabelSize.QLDieCutW39H48:
        return "39mm x 48mm";
      case BrotherLabelSize.QLDieCutW52H29:
        return "52mm x 29mm";
      case BrotherLabelSize.QLDieCutW62H29:
        return "62mm x 29mm";
      case BrotherLabelSize.QLDieCutW62H100:
        return "62mm x 100mm";
      case BrotherLabelSize.QLDieCutW60H86:
        return "60mm x 86mm";
      case BrotherLabelSize.QLDieCutW54H29:
        return "54mm x 29mm";
      case BrotherLabelSize.QLDieCutW102H51:
        return "102mm x 51mm";
      case BrotherLabelSize.QLDieCutW102H152:
        return "102mm x 152mm";
      case BrotherLabelSize.QLDieCutW103H164:
        return "103mm x 164mm";
      case BrotherLabelSize.QLRollW12:
        return "12mm";
      case BrotherLabelSize.QLRollW29:
        return "29mm";
      case BrotherLabelSize.QLRollW38:
        return "38mm";
      case BrotherLabelSize.QLRollW50:
        return "50mm";
      case BrotherLabelSize.QLRollW54:
        return "54mm";
      case BrotherLabelSize.QLRollW62:
        return "62mm";
      case BrotherLabelSize.QLRollW62RB:
        return "62mm RB";
      case BrotherLabelSize.QLRollW102:
        return "102mm";
      case BrotherLabelSize.QLRollW103:
        return "103mm";
      case BrotherLabelSize.QLDTRollW90:
        return "DT 90mm";
      case BrotherLabelSize.QLDTRollW102:
        return "DT 102mm";
      case BrotherLabelSize.QLDTRollW102H51:
        return "DT 102mm x 51mm";
      case BrotherLabelSize.QLDTRollW102H152:
        return "DT 102mm x 152mm";
      case BrotherLabelSize.PT3_5mm:
        return "3_5mm";
      case BrotherLabelSize.PT6mm:
        return "6mm";
      case BrotherLabelSize.PT9mm:
        return "9mm";
      case BrotherLabelSize.PT12mm:
        return "12mm";
      case BrotherLabelSize.PT18mm:
        return "18mm";
      case BrotherLabelSize.PT24mm:
        return "24mm";
      case BrotherLabelSize.PT36mm:
        return "36mm";
      case BrotherLabelSize.PTHS_5_8mm:
        return "HS 5.8mm";
      case BrotherLabelSize.PTHS_8_8mm:
        return "HS 8.8mm";
      case BrotherLabelSize.PTHS_11_7mm:
        return "HS 11.7mm";
      case BrotherLabelSize.PTHS_17_7mm:
        return "HS 17.7mm";
      case BrotherLabelSize.PTHS_23_6mm:
        return "HS 23.6mm";
      case BrotherLabelSize.PTFL_21x45mm:
        return "FL 21mm x 45mm";
    }
  }

  double get width {
    switch (this) {
      case BrotherLabelSize.QLDieCutW17H54:
        return 17;
      case BrotherLabelSize.QLDieCutW17H87:
        return 17;
      case BrotherLabelSize.QLDieCutW23H23:
        return 23;
      case BrotherLabelSize.QLDieCutW29H42:
        return 29;
      case BrotherLabelSize.QLDieCutW29H90:
        return 29;
      case BrotherLabelSize.QLDieCutW38H90:
        return 38;
      case BrotherLabelSize.QLDieCutW39H48:
        return 39;
      case BrotherLabelSize.QLDieCutW52H29:
        return 52;
      case BrotherLabelSize.QLDieCutW62H29:
        return 62;
      case BrotherLabelSize.QLDieCutW62H100:
        return 62;
      case BrotherLabelSize.QLDieCutW60H86:
        return 60;
      case BrotherLabelSize.QLDieCutW54H29:
        return 54;
      case BrotherLabelSize.QLDieCutW102H51:
        return 102;
      case BrotherLabelSize.QLDieCutW102H152:
        return 102;
      case BrotherLabelSize.QLDieCutW103H164:
        return 103;
      case BrotherLabelSize.QLRollW12:
        return 12;
      case BrotherLabelSize.QLRollW29:
        return 29;
      case BrotherLabelSize.QLRollW38:
        return 38;
      case BrotherLabelSize.QLRollW50:
        return 50;
      case BrotherLabelSize.QLRollW54:
        return 54;
      case BrotherLabelSize.QLRollW62:
        return 62;
      case BrotherLabelSize.QLRollW62RB:
        return 62;
      case BrotherLabelSize.QLRollW102:
        return 102;
      case BrotherLabelSize.QLRollW103:
        return 103;
      case BrotherLabelSize.QLDTRollW90:
        return 90;
      case BrotherLabelSize.QLDTRollW102:
        return 102;
      case BrotherLabelSize.QLDTRollW102H51:
        return 102;
      case BrotherLabelSize.QLDTRollW102H152:
        return 102;
      case BrotherLabelSize.PT3_5mm:
        return 3.5;
      case BrotherLabelSize.PT6mm:
        return 6;
      case BrotherLabelSize.PT9mm:
        return 9;
      case BrotherLabelSize.PT12mm:
        return 12;
      case BrotherLabelSize.PT18mm:
        return 18;
      case BrotherLabelSize.PT24mm:
        return 24;
      case BrotherLabelSize.PT36mm:
        return 36;
      case BrotherLabelSize.PTHS_5_8mm:
        return 5.8;
      case BrotherLabelSize.PTHS_8_8mm:
        return 8.8;
      case BrotherLabelSize.PTHS_11_7mm:
        return 11.7;
      case BrotherLabelSize.PTHS_17_7mm:
        return 17.7;
      case BrotherLabelSize.PTHS_23_6mm:
        return 23.6;
      case BrotherLabelSize.PTFL_21x45mm:
        return 21;
    }
  }

  double? get height {
    switch (this) {
      case BrotherLabelSize.QLDieCutW17H54:
        return 54;
      case BrotherLabelSize.QLDieCutW17H87:
        return 87;
      case BrotherLabelSize.QLDieCutW23H23:
        return 23;
      case BrotherLabelSize.QLDieCutW29H42:
        return 42;
      case BrotherLabelSize.QLDieCutW29H90:
        return 90;
      case BrotherLabelSize.QLDieCutW38H90:
        return 90;
      case BrotherLabelSize.QLDieCutW39H48:
        return 48;
      case BrotherLabelSize.QLDieCutW52H29:
        return 29;
      case BrotherLabelSize.QLDieCutW62H29:
        return 29;
      case BrotherLabelSize.QLDieCutW62H100:
        return 100;
      case BrotherLabelSize.QLDieCutW60H86:
        return 86;
      case BrotherLabelSize.QLDieCutW54H29:
        return 29;
      case BrotherLabelSize.QLDieCutW102H51:
        return 51;
      case BrotherLabelSize.QLDieCutW102H152:
        return 152;
      case BrotherLabelSize.QLDieCutW103H164:
        return 164;
      case BrotherLabelSize.QLRollW12:
        return null;
      case BrotherLabelSize.QLRollW29:
        return null;
      case BrotherLabelSize.QLRollW38:
        return null;
      case BrotherLabelSize.QLRollW50:
        return null;
      case BrotherLabelSize.QLRollW54:
        return null;
      case BrotherLabelSize.QLRollW62:
        return null;
      case BrotherLabelSize.QLRollW62RB:
        return null;
      case BrotherLabelSize.QLRollW102:
        return null;
      case BrotherLabelSize.QLRollW103:
        return null;
      case BrotherLabelSize.QLDTRollW90:
        return null;
      case BrotherLabelSize.QLDTRollW102:
        return null;
      case BrotherLabelSize.QLDTRollW102H51:
        return 51;
      case BrotherLabelSize.QLDTRollW102H152:
        return 152;
      case BrotherLabelSize.PT3_5mm:
        return null;
      case BrotherLabelSize.PT6mm:
        return null;
      case BrotherLabelSize.PT9mm:
        return null;
      case BrotherLabelSize.PT12mm:
        return null;
      case BrotherLabelSize.PT18mm:
        return null;
      case BrotherLabelSize.PT24mm:
        return null;
      case BrotherLabelSize.PT36mm:
        return null;
      case BrotherLabelSize.PTHS_5_8mm:
        return null;
      case BrotherLabelSize.PTHS_8_8mm:
        return null;
      case BrotherLabelSize.PTHS_11_7mm:
        return null;
      case BrotherLabelSize.PTHS_17_7mm:
        return null;
      case BrotherLabelSize.PTHS_23_6mm:
        return null;
      case BrotherLabelSize.PTFL_21x45mm:
        return 45;
    }
  }
}
