#import "BRPrinterSession.h"

#import "BRError.h"

#import <BRLMPrinterKit/BRLMPrinterKit.h>
#import <BRLMPrinterKit/BRLMPJPrintSettingsPaperSize.h>

@implementation BRPrinterSession

- (void)printPDF:(nonnull NSString*) path copies:(NSUInteger)copies model:(NSInteger)model ipAddress:(nonnull NSString*) ipAddress error:(NSError **)error {
    BRLMChannel *channel = [[BRLMChannel alloc] initWithWifiIPAddress:ipAddress];
    [self connect:channel path:path copies:copies model:model error:error];
}

- (void)printPDF:(nonnull NSString*) path copies:(NSUInteger)copies model:(NSInteger)model serialNumber:(nonnull NSString*) serialNumber error:(NSError **)error {
    BRLMChannel *channel = [[BRLMChannel alloc] initWithBluetoothSerialNumber:serialNumber];
    [self connect:channel path:path copies:copies model:model error:error];
}

- (void)printPDF:(nonnull NSString*) path copies:(NSUInteger)copies model:(NSInteger)model bleAdvertiseLocalName:(nonnull NSString*) bleAdvertiseLocalName error:(NSError **)error {
    BRLMChannel *channel = [[BRLMChannel alloc] initWithBLELocalName:bleAdvertiseLocalName];
    [self connect:channel path:path copies:copies model:model error:error];
}

- (void)connect:(nonnull BRLMChannel*) channel path:(nonnull NSString*) path  copies:(NSUInteger)copies model:(BRLMPrinterModel)model error:(NSError **)error {
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
    [self process:printerDriver path:path copies:copies model:model error:error];
    [printerDriver closeChannel];
}

- (void)process:(nonnull BRLMPrinterDriver *) printerDriver path:(nonnull NSString*) path copies:(NSUInteger)copies model:(BRLMPrinterModel)model error:(NSError **)error {
    NSURL *url = [NSURL URLWithString:path];

    NSObject <NSCoding, BRLMPrintSettingsProtocol, BRLMPrintImageSettings> * settings = [self settings:model];
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
-(NSObject <NSCoding, BRLMPrintSettingsProtocol, BRLMPrintImageSettings> *)settings:(BRLMPrinterModel) model
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
          BRLMCustomPaperSize *paperSize = [[BRLMCustomPaperSize alloc] initDieCutWithTapeWidth:51
                                                                                     tapeLength:26
                                                                                        margins:BRLMCustomPaperSizeMarginsMake(0, 0, 0, 0)
                                                                                      gapLength:3
                                                                                   unitOfLength:BRLMCustomPaperSizeLengthUnitMm];
          [settings setCustomPaperSize:paperSize];
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
          [settings setLabelSize:BRLMQLPrintSettingsLabelSizeRollW62RB];
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
    return settings;
      }
      break;
    case BRLMPrinterModelUnknown:
    default:
        return nil;
    }
}

@end
