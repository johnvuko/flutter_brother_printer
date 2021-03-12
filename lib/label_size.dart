enum BrotherLabelSize {
  DieCutW17H54,
  DieCutW17H87,
  DieCutW23H23,
  DieCutW29H42,
  DieCutW29H90,
  DieCutW38H90,
  DieCutW39H48,
  DieCutW52H29,
  DieCutW62H29,
  DieCutW62H100,
  DieCutW60H86,
  DieCutW54H29,
  DieCutW102H51,
  DieCutW102H152,
  DieCutW103H164,
  RollW12,
  RollW29,
  RollW38,
  RollW50,
  RollW54,
  RollW62,
  RollW62RB,
  RollW102,
  RollW103,
  DTRollW90,
  DTRollW102,
  DTRollW102H51,
  DTRollW102H152,
}

extension BrotherLabelSizeExtension on BrotherLabelSize {
  String toParam() {
    switch (this) {
      case BrotherLabelSize.DieCutW17H54:
        return "DieCutW17H54";
      case BrotherLabelSize.DieCutW17H87:
        return "DieCutW17H87";
      case BrotherLabelSize.DieCutW23H23:
        return "DieCutW23H23";
      case BrotherLabelSize.DieCutW29H42:
        return "DieCutW29H42";
      case BrotherLabelSize.DieCutW29H90:
        return "DieCutW29H90";
      case BrotherLabelSize.DieCutW38H90:
        return "DieCutW38H90";
      case BrotherLabelSize.DieCutW39H48:
        return "DieCutW39H48";
      case BrotherLabelSize.DieCutW52H29:
        return "DieCutW52H29";
      case BrotherLabelSize.DieCutW62H29:
        return "DieCutW62H29";
      case BrotherLabelSize.DieCutW62H100:
        return "DieCutW62H100";
      case BrotherLabelSize.DieCutW60H86:
        return "DieCutW60H86";
      case BrotherLabelSize.DieCutW54H29:
        return "DieCutW54H29";
      case BrotherLabelSize.DieCutW102H51:
        return "DieCutW102H51";
      case BrotherLabelSize.DieCutW102H152:
        return "DieCutW102H152";
      case BrotherLabelSize.DieCutW103H164:
        return "DieCutW103H164";
      case BrotherLabelSize.RollW12:
        return "RollW12";
      case BrotherLabelSize.RollW29:
        return "RollW29";
      case BrotherLabelSize.RollW38:
        return "RollW38";
      case BrotherLabelSize.RollW50:
        return "RollW50";
      case BrotherLabelSize.RollW54:
        return "RollW54";
      case BrotherLabelSize.RollW62:
        return "RollW62";
      case BrotherLabelSize.RollW62RB:
        return "RollW62RB";
      case BrotherLabelSize.RollW102:
        return "RollW102";
      case BrotherLabelSize.RollW103:
        return "RollW103";
      case BrotherLabelSize.DTRollW90:
        return "DTRollW90";
      case BrotherLabelSize.DTRollW102:
        return "DTRollW102";
      case BrotherLabelSize.DTRollW102H51:
        return "DTRollW102H51";
      case BrotherLabelSize.DTRollW102H152:
        return "DTRollW102H152";
    }
  }

  String get description {
    switch (this) {
      case BrotherLabelSize.DieCutW17H54:
        return "17mm x 54mm";
      case BrotherLabelSize.DieCutW17H87:
        return "17mm x 87mm";
      case BrotherLabelSize.DieCutW23H23:
        return "23mm x 23mm";
      case BrotherLabelSize.DieCutW29H42:
        return "29mm x 42mm";
      case BrotherLabelSize.DieCutW29H90:
        return "29mm x 90mm";
      case BrotherLabelSize.DieCutW38H90:
        return "38mm x 90mm";
      case BrotherLabelSize.DieCutW39H48:
        return "39mm x 48mm";
      case BrotherLabelSize.DieCutW52H29:
        return "52mm x 29mm";
      case BrotherLabelSize.DieCutW62H29:
        return "62mm x 29mm";
      case BrotherLabelSize.DieCutW62H100:
        return "62mm x 100mm";
      case BrotherLabelSize.DieCutW60H86:
        return "60mm x 86mm";
      case BrotherLabelSize.DieCutW54H29:
        return "54mm x 29mm";
      case BrotherLabelSize.DieCutW102H51:
        return "102mm x 51mm";
      case BrotherLabelSize.DieCutW102H152:
        return "102mm x 152mm";
      case BrotherLabelSize.DieCutW103H164:
        return "103mm x 164mm";
      case BrotherLabelSize.RollW12:
        return "12mm";
      case BrotherLabelSize.RollW29:
        return "29mm";
      case BrotherLabelSize.RollW38:
        return "38mm";
      case BrotherLabelSize.RollW50:
        return "50mm";
      case BrotherLabelSize.RollW54:
        return "54mm";
      case BrotherLabelSize.RollW62:
        return "62mm";
      case BrotherLabelSize.RollW62RB:
        return "62mm RB";
      case BrotherLabelSize.RollW102:
        return "102mm";
      case BrotherLabelSize.RollW103:
        return "103mm";
      case BrotherLabelSize.DTRollW90:
        return "DT 90mm";
      case BrotherLabelSize.DTRollW102:
        return "DT 102mm";
      case BrotherLabelSize.DTRollW102H51:
        return "DT 102mm x 51mm";
      case BrotherLabelSize.DTRollW102H152:
        return "DT 102mm x 152mm";
    }
  }

  int get width {
    switch (this) {
      case BrotherLabelSize.DieCutW17H54:
        return 17;
      case BrotherLabelSize.DieCutW17H87:
        return 17;
      case BrotherLabelSize.DieCutW23H23:
        return 23;
      case BrotherLabelSize.DieCutW29H42:
        return 29;
      case BrotherLabelSize.DieCutW29H90:
        return 29;
      case BrotherLabelSize.DieCutW38H90:
        return 38;
      case BrotherLabelSize.DieCutW39H48:
        return 39;
      case BrotherLabelSize.DieCutW52H29:
        return 52;
      case BrotherLabelSize.DieCutW62H29:
        return 62;
      case BrotherLabelSize.DieCutW62H100:
        return 62;
      case BrotherLabelSize.DieCutW60H86:
        return 60;
      case BrotherLabelSize.DieCutW54H29:
        return 54;
      case BrotherLabelSize.DieCutW102H51:
        return 102;
      case BrotherLabelSize.DieCutW102H152:
        return 102;
      case BrotherLabelSize.DieCutW103H164:
        return 103;
      case BrotherLabelSize.RollW12:
        return 12;
      case BrotherLabelSize.RollW29:
        return 29;
      case BrotherLabelSize.RollW38:
        return 38;
      case BrotherLabelSize.RollW50:
        return 50;
      case BrotherLabelSize.RollW54:
        return 54;
      case BrotherLabelSize.RollW62:
        return 62;
      case BrotherLabelSize.RollW62RB:
        return 62;
      case BrotherLabelSize.RollW102:
        return 102;
      case BrotherLabelSize.RollW103:
        return 103;
      case BrotherLabelSize.DTRollW90:
        return 90;
      case BrotherLabelSize.DTRollW102:
        return 102;
      case BrotherLabelSize.DTRollW102H51:
        return 102;
      case BrotherLabelSize.DTRollW102H152:
        return 102;
    }
  }

  int get height {
    switch (this) {
      case BrotherLabelSize.DieCutW17H54:
        return 54;
      case BrotherLabelSize.DieCutW17H87:
        return 87;
      case BrotherLabelSize.DieCutW23H23:
        return 23;
      case BrotherLabelSize.DieCutW29H42:
        return 42;
      case BrotherLabelSize.DieCutW29H90:
        return 90;
      case BrotherLabelSize.DieCutW38H90:
        return 90;
      case BrotherLabelSize.DieCutW39H48:
        return 48;
      case BrotherLabelSize.DieCutW52H29:
        return 29;
      case BrotherLabelSize.DieCutW62H29:
        return 29;
      case BrotherLabelSize.DieCutW62H100:
        return 100;
      case BrotherLabelSize.DieCutW60H86:
        return 86;
      case BrotherLabelSize.DieCutW54H29:
        return 29;
      case BrotherLabelSize.DieCutW102H51:
        return 51;
      case BrotherLabelSize.DieCutW102H152:
        return 152;
      case BrotherLabelSize.DieCutW103H164:
        return 164;
      case BrotherLabelSize.RollW12:
        return null;
      case BrotherLabelSize.RollW29:
        return null;
      case BrotherLabelSize.RollW38:
        return null;
      case BrotherLabelSize.RollW50:
        return null;
      case BrotherLabelSize.RollW54:
        return null;
      case BrotherLabelSize.RollW62:
        return null;
      case BrotherLabelSize.RollW62RB:
        return null;
      case BrotherLabelSize.RollW102:
        return null;
      case BrotherLabelSize.RollW103:
        return null;
      case BrotherLabelSize.DTRollW90:
        return null;
      case BrotherLabelSize.DTRollW102:
        return null;
      case BrotherLabelSize.DTRollW102H51:
        return 51;
      case BrotherLabelSize.DTRollW102H152:
        return 152;
    }
  }
}
