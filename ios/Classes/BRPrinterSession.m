#import "BRPrinterSession.h"

#import "BRError.h"

#import <BRLMPrinterKit/BRLMPrinterKit.h>
#import <BRLMPrinterKit/BRLMPJPrintSettingsPaperSize.h>

@implementation BRPrinterSession

- (void)printPDF:(nonnull NSString*) path copies:(NSUInteger) copies model:(NSInteger) model paperSettingsPath:(NSString *) paperSettingsPath labelSize:(NSString *) labelSize ipAddress:(nonnull NSString*) ipAddress error:(NSError **)error {
    BRLMChannel *channel = [[BRLMChannel alloc] initWithWifiIPAddress:ipAddress];
    [self connect:channel path:path copies:copies model:model paperSettingsPath:paperSettingsPath labelSize:labelSize error:error];
}

- (void)printPDF:(nonnull NSString*) path copies:(NSUInteger) copies model:(NSInteger) model paperSettingsPath:(NSString *) paperSettingsPath labelSize:(NSString *) labelSize serialNumber:(nonnull NSString*) serialNumber error:(NSError **)error {
    BRLMChannel *channel = [[BRLMChannel alloc] initWithBluetoothSerialNumber:serialNumber];
    [self connect:channel path:path copies:copies model:model paperSettingsPath:paperSettingsPath labelSize:labelSize error:error];
}

- (void)printPDF:(nonnull NSString*) path copies:(NSUInteger) copies model:(NSInteger) model paperSettingsPath:(NSString *) paperSettingsPath labelSize:(NSString *) labelSize bleAdvertiseLocalName:(nonnull NSString*) bleAdvertiseLocalName error:(NSError **)error {
    BRLMChannel *channel = [[BRLMChannel alloc] initWithBLELocalName:bleAdvertiseLocalName];
    [self connect:channel path:path copies:copies model:model paperSettingsPath:paperSettingsPath labelSize:labelSize error:error];
}

- (void)connect:(nonnull BRLMChannel*) channel path:(nonnull NSString*) path  copies:(NSUInteger)copies model:(BRLMPrinterModel)model paperSettingsPath:(NSString *) paperSettingsPath labelSize:(NSString *) labelSize error:(NSError **)error {
    BRLMPrinterDriverGenerateResult *generateResult = [BRLMPrinterDriverGenerator openChannel:channel];

    switch (generateResult.error.code) {
        case BRLMOpenChannelErrorCodeOpenStreamFailure:
            *error = [NSError errorWithDomain:BRErrorDomain code:BROpenChannelErrorCodeOpenStreamFailure userInfo:nil];
            return;
        case BRLMOpenChannelErrorCodeTimeout:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRLMOpenChannelErrorCodeTimeout userInfo:nil];
            return;
        case BRLMOpenChannelErrorCodeNoError:
            break;
    }
    
    if (generateResult.driver == nil) {
         *error = [NSError errorWithDomain:BRErrorDomain code:BROpenChannelErrorCodeOpenStreamFailure userInfo:nil];
         return;
    }

    BRLMPrinterDriver *printerDriver = generateResult.driver;
    [self process:printerDriver path:path copies:copies model:model paperSettingsPath:paperSettingsPath labelSize:labelSize error:error];
    [printerDriver closeChannel];
}

- (void)process:(nonnull BRLMPrinterDriver *) printerDriver path:(nonnull NSString*) path copies:(NSUInteger)copies model:(BRLMPrinterModel)model paperSettingsPath:(NSString *) paperSettingsPath labelSize:(NSString *) labelSize error:(NSError **)error {
    NSURL *url = [NSURL URLWithString:path];

    NSObject <NSCoding, BRLMPrintSettingsProtocol, BRLMPrintImageSettings> * settings = [self settings:model paperSettingsPath:paperSettingsPath labelSize:labelSize];
    [settings setNumCopies:copies];

    BRLMPrintError *printError = [printerDriver printPDFWithURL:url settings:settings];
    
    switch (printError.code) {
        case BRLMPrintErrorCodeNoError:
            break;
        case BRLMPrintErrorCodePrintSettingsError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrintSettingsError userInfo:nil];
            break;
        case BRLMPrintErrorCodeFilepathURLError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeFilepathURLError userInfo:nil];
            break;
        case BRLMPrintErrorCodePDFPageError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePDFPageError userInfo:nil];
            break;
        case BRLMPrintErrorCodePrintSettingsNotSupportError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrintSettingsNotSupportError userInfo:nil];
            break;
        case BRLMPrintErrorCodeDataBufferError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeDataBufferError userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterModelError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterModelError userInfo:nil];
            break;
        case BRLMPrintErrorCodeCanceled:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeCanceled userInfo:nil];
            break;
        case BRLMPrintErrorCodeChannelTimeout:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeChannelTimeout userInfo:nil];
            break;
        case BRLMPrintErrorCodeSetModelError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeSetModelError userInfo:nil];
            break;
        case BRLMPrintErrorCodeUnsupportedFile:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeUnsupportedFile userInfo:nil];
            break;
        case BRLMPrintErrorCodeSetMarginError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeSetMarginError userInfo:nil];
            break;
        case BRLMPrintErrorCodeSetLabelSizeError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeSetLabelSizeError userInfo:nil];
            break;
        case BRLMPrintErrorCodeCustomPaperSizeError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeCustomPaperSizeError userInfo:nil];
            break;
        case BRLMPrintErrorCodeSetLengthError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeSetLengthError userInfo:nil];
            break;
        case BRLMPrintErrorCodeTubeSettingError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeTubeSettingError userInfo:nil];
            break;
        case BRLMPrintErrorCodeChannelErrorStreamStatusError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeChannelErrorStreamStatusError userInfo:nil];
            break;
        case BRLMPrintErrorCodeChannelErrorUnsupportedChannel:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeChannelErrorUnsupportedChannel userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorPaperEmpty:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorPaperEmpty userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorCoverOpen:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorCoverOpen userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorBusy:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorBusy userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorPrinterTurnedOff:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorPrinterTurnedOff userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorBatteryWeak:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorBatteryWeak userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorExpansionBufferFull:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorExpansionBufferFull userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorCommunicationError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorCommunicationError userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorPaperJam:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorPaperJam userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorMediaCannotBeFed:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorMediaCannotBeFed userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorOverHeat:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorOverHeat userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorHighVoltageAdapter:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorHighVoltageAdapter userInfo:nil];
            break;
        case BRLMPrintErrorCodePrinterStatusErrorUnknownError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodePrinterStatusErrorUnknownError userInfo:nil];
            break;
        case BRLMPrintErrorCodeUnknownError:
            *error = [NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeUnknownError userInfo:nil];
            break;
    }
}

// TODO be able to pass settings from Flutter
-(NSObject <NSCoding, BRLMPrintSettingsProtocol, BRLMPrintImageSettings> *)settings:(BRLMPrinterModel) model paperSettingsPath:(NSString *) paperSettingsPath labelSize:(NSString *) labelSize
{
  switch (model)
    {
    case BRLMPrinterModelPJ_673:
    case BRLMPrinterModelPJ_763MFi:
    case BRLMPrinterModelPJ_773:
      {
    BRLMPJPrintSettings *settings = [[BRLMPJPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:model];
    return settings;
      }
      break;
    case BRLMPrinterModelMW_145MFi:
    case BRLMPrinterModelMW_260MFi:
    case BRLMPrinterModelMW_170:
    case BRLMPrinterModelMW_270:
      {
      BRLMMWPrintSettings *settings = [[BRLMMWPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:model];
    return settings;
      }
      break;
    case BRLMPrinterModelRJ_4030Ai:
    case BRLMPrinterModelRJ_4040:
    case BRLMPrinterModelRJ_3050:
    case BRLMPrinterModelRJ_3150:
    case BRLMPrinterModelRJ_3050Ai:
    case BRLMPrinterModelRJ_3150Ai:
    case BRLMPrinterModelRJ_2050:
    case BRLMPrinterModelRJ_2140:
    case BRLMPrinterModelRJ_2150:
    case BRLMPrinterModelRJ_4230B:
    case BRLMPrinterModelRJ_4250WB:
      {
      BRLMRJPrintSettings *settings = [[BRLMRJPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:model];
    return settings;
      }
      break;
    case BRLMPrinterModelTD_2120N:
    case BRLMPrinterModelTD_2130N:
    case BRLMPrinterModelTD_4100N:
    case BRLMPrinterModelTD_4420DN:
    case BRLMPrinterModelTD_4520DN:
    case BRLMPrinterModelTD_4550DNWB:
      {
          BRLMTDPrintSettings *settings = [[BRLMTDPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:model];

          if (paperSettingsPath != nil && paperSettingsPath != [NSNull null]) {
            NSURL *customPaperFileUrl = [NSURL URLWithString:paperSettingsPath];
            BRLMCustomPaperSize *paperSize = [[BRLMCustomPaperSize alloc] initWithFile:customPaperFileUrl];

            [settings setCustomPaperSize:paperSize];
          }

          [settings setPeelLabel:TRUE];
          
          return settings;
      }
      break;
    case BRLMPrinterModelQL_710W:
    case BRLMPrinterModelQL_720NW:
    case BRLMPrinterModelQL_810W:
    case BRLMPrinterModelQL_820NWB:
    case BRLMPrinterModelQL_1110NWB:
    case BRLMPrinterModelQL_1115NWB:
      {
      BRLMQLPrintSettings *settings = [[BRLMQLPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:model];

      if (labelSize != nil && labelSize != [NSNull null]) {
        BRLMQLPrintSettingsLabelSize qlLabelSize;

        if ([labelSize isEqualToString:@"DieCutW17H54"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW17H54;
        }
        else if ([labelSize isEqualToString:@"DieCutW17H87"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW17H87;
        }
        else if ([labelSize isEqualToString:@"DieCutW23H23"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW23H23;
        }
        else if ([labelSize isEqualToString:@"DieCutW29H42"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW29H42;
        }
        else if ([labelSize isEqualToString:@"DieCutW29H90"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW29H90;
        }
        else if ([labelSize isEqualToString:@"DieCutW38H90"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW38H90;
        }
        else if ([labelSize isEqualToString:@"DieCutW39H48"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW39H48;
        }
        else if ([labelSize isEqualToString:@"DieCutW52H29"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW52H29;
        }
        else if ([labelSize isEqualToString:@"DieCutW62H29"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW62H29;
        }
        else if ([labelSize isEqualToString:@"DieCutW62H100"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW62H100;
        }
        else if ([labelSize isEqualToString:@"DieCutW60H86"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW60H86;
        }
        else if ([labelSize isEqualToString:@"DieCutW54H29"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW54H29;
        }
        else if ([labelSize isEqualToString:@"DieCutW102H51"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW102H51;
        }
        else if ([labelSize isEqualToString:@"DieCutW102H152"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW102H152;
        }
        else if ([labelSize isEqualToString:@"DieCutW103H164"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDieCutW103H164;
        }
        else if ([labelSize isEqualToString:@"RollW12"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeRollW12;
        }
        else if ([labelSize isEqualToString:@"RollW29"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeRollW29;
        }
        else if ([labelSize isEqualToString:@"RollW38"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeRollW38;
        }
        else if ([labelSize isEqualToString:@"RollW50"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeRollW50;
        }
        else if ([labelSize isEqualToString:@"RollW54"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeRollW54;
        }
        else if ([labelSize isEqualToString:@"RollW62"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeRollW62;
        }
        else if ([labelSize isEqualToString:@"RollW62RB"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeRollW62RB;
        }
        else if ([labelSize isEqualToString:@"RollW102"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeRollW102;
        }
        else if ([labelSize isEqualToString:@"RollW103"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeRollW103;
        }
        else if ([labelSize isEqualToString:@"DTRollW90"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDTRollW90;
        }
        else if ([labelSize isEqualToString:@"DTRollW102"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDTRollW102;
        }
        else if ([labelSize isEqualToString:@"DTRollW102H51"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDTRollW102H51;
        }
        else if ([labelSize isEqualToString:@"DTRollW102H152"]) {
          qlLabelSize = BRLMQLPrintSettingsLabelSizeDTRollW102H152;
        }

        [settings setLabelSize:qlLabelSize];

      }

      [settings setAutoCut:TRUE];
      return settings;
      }
      break;
    case BRLMPrinterModelPT_E550W:
    case BRLMPrinterModelPT_P750W:
    case BRLMPrinterModelPT_D800W:
    case BRLMPrinterModelPT_E800W:
    case BRLMPrinterModelPT_E850TKW:
    case BRLMPrinterModelPT_P900W:
    case BRLMPrinterModelPT_P950NW:
    case BRLMPrinterModelPT_P300BT:
    case BRLMPrinterModelPT_P710BT:
    case BRLMPrinterModelPT_P715eBT:
    case BRLMPrinterModelPT_P910BT:
      {
      BRLMPTPrintSettings *settings = [[BRLMPTPrintSettings alloc] initDefaultPrintSettingsWithPrinterModel:model];

      if (labelSize != nil && labelSize != [NSNull null]) {
        BRLMPTPrintSettingsLabelSize printerLabelSize;

        if ([labelSize isEqualToString:@"3_5mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidth3_5mm;
        }
        else if ([labelSize isEqualToString:@"6mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidth6mm;
        }
        else if ([labelSize isEqualToString:@"9mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidth9mm;
        }
        else if ([labelSize isEqualToString:@"12mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidth12mm;
        }
        else if ([labelSize isEqualToString:@"18mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidth18mm;
        }
        else if ([labelSize isEqualToString:@"24mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidth24mm;
        }
        else if ([labelSize isEqualToString:@"36mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidth36mm;
        }
        else if ([labelSize isEqualToString:@"HS_5_8mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidthHS_5_8mm;
        }
        else if ([labelSize isEqualToString:@"HS_8_8mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidthHS_8_8mm;
        }
        else if ([labelSize isEqualToString:@"HS_11_7mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidthHS_11_7mm;
        }
        else if ([labelSize isEqualToString:@"HS_17_7mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidthHS_17_7mm;
        }
        else if ([labelSize isEqualToString:@"HS_23_6mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidthHS_23_6mm;
        }
        else if ([labelSize isEqualToString:@"FL_21x45mm"]) {
          printerLabelSize = BRLMPTPrintSettingsLabelSizeWidthFL_21x45mm;
        }

        [settings setLabelSize:printerLabelSize];
      }

      [settings setAutoCut:TRUE];
      return settings;
      }
      break;
    case BRLMPrinterModelUnknown:
    default:
        return nil;
    }
}

@end
