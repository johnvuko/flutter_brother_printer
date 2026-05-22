#import "BrotherPrinterPlugin.h"

#import <BRLMPrinterKit/BRPtouchDeviceInfo.h>

#import "BRPrinterDiscovery.h"
#import "BRPrinterSession.h"
#import "BRError.h"

@implementation BrotherPrinterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"brother_printer" binaryMessenger:[registrar messenger]];
  BrotherPrinterPlugin* instance = [BrotherPrinterPlugin new];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"searchDevices" isEqualToString:call.method]) {
      [self searchDevices:call result:result];
  } else if ([@"printPDF" isEqualToString:call.method]) {
      @try {
          [self printPDF:call result:result];
      }
      @catch (NSError *error) {
          result([FlutterError errorWithCode:@"Unknown error" message:[error localizedDescription] details:nil]);
      }
      @catch (NSException *exception) {
        result([FlutterError errorWithCode:[exception name] message:[exception reason] details:nil]);
      }
  } else {
      result(FlutterMethodNotImplemented);
  }
}

- (void)searchDevices:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSNumber *delay = [[call arguments] objectForKey:@"delay"];
    NSNumber *isEnableIPv6Search = [[call arguments] objectForKey:@"isEnableIPv6Search"];
    NSArray *printerNames = [[call arguments] objectForKey:@"printerNames"];
    
    [[BRPrinterDiscovery sharedInstance] start:[delay intValue] printerNames:printerNames isEnableIPv6Search:[isEnableIPv6Search boolValue] completion:^(NSArray<BRPtouchDeviceInfo *> * _Nullable devices, NSError * _Nullable error) {
        if (error != nil) {
            result([self handleError:error]);
            return;
        }
                
        result(devices);
    }];
}

- (void)printPDF:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *path = [[call arguments] objectForKey:@"path"];
    NSNumber *copies = [[call arguments] objectForKey:@"copies"];
    NSNumber *model = [[call arguments] objectForKey:@"modelCode"];
    NSString *ipAddress = [[call arguments] objectForKey:@"ipAddress"];
    NSString *serialNumber = [[call arguments] objectForKey:@"serialNumber"];
    NSString *bleAdvertiseLocalName = [[call arguments] objectForKey:@"bleAdvertiseLocalName"];
    NSString *paperSettingsPath = [[call arguments] objectForKey:@"paperSettingsPath"];
    NSString *labelSize = [[call arguments] objectForKey:@"labelSize"];
    
    BRPrinterSession *session = [BRPrinterSession new];
    NSError *error;
    
    if (ipAddress != nil && ipAddress != [NSNull null]) {
        [session printPDF:path copies:[copies unsignedIntegerValue] model:[model integerValue] paperSettingsPath:paperSettingsPath labelSize:labelSize ipAddress:ipAddress error:&error];
    }
    else if (serialNumber != nil && serialNumber != [NSNull null]) {
        [session printPDF:path copies:[copies unsignedIntegerValue] model:[model integerValue] paperSettingsPath:paperSettingsPath labelSize:labelSize serialNumber:serialNumber error:&error];
    }
    else if (bleAdvertiseLocalName != nil && bleAdvertiseLocalName != [NSNull null]) {
        [session printPDF:path copies:[copies unsignedIntegerValue] model:[model integerValue] paperSettingsPath:paperSettingsPath labelSize:labelSize bleAdvertiseLocalName:bleAdvertiseLocalName error:&error];
    }
    else {
        result([self handleError:[NSError errorWithDomain:BRErrorDomain code:BRPrintErrorCodeMissingParameterError userInfo:nil]]);
        return;
    }
    
    if (error != nil) {
        result([self handleError:error]);
    }
    else {
        result([NSNull null]);
    }
}

- (FlutterError *)handleError:(NSError * _Nonnull) error {
    if ([[error domain] isEqualToString:BRErrorDomain]) {
        NSString *code;
        switch (error.code) {
            case BRFailedToStartDiscoveryError:
                code = @"BRFailedToStartDiscoveryError";
                break;
            case BRDiscoveryInProgressError:
                code = @"BRDiscoveryInProgressError";
                break;
            case BROpenChannelErrorCodeOpenStreamFailure:
                code = @"BROpenChannelErrorCodeOpenStreamFailure";
                break;
            case BROpenChannelErrorCodeTimeout:
                code = @"BROpenChannelErrorCodeTimeout";
                break;
            case BRPrintErrorCodeMissingParameterError:
                code = @"BRPrintErrorCodeMissingParameterError";
                break;
            case BRPrintErrorCodePrintSettingsError:
                code = @"BRPrintErrorCodePrintSettingsError";
                break;
            case BRPrintErrorCodeFilepathURLError:
                code = @"BRPrintErrorCodeFilepathURLError";
                break;
            case BRPrintErrorCodePDFPageError:
                code = @"BRPrintErrorCodePDFPageError";
                break;
            case BRPrintErrorCodePrintSettingsNotSupportError:
                code = @"BRPrintErrorCodePrintSettingsNotSupportError";
                break;
            case BRPrintErrorCodeDataBufferError:
                code = @"BRPrintErrorCodeDataBufferError";
                break;
            case BRPrintErrorCodePrinterModelError:
                code = @"BRPrintErrorCodePrinterModelError";
                break;
            case BRPrintErrorCodeCanceled:
                code = @"BRPrintErrorCodeCanceled";
                break;
            case BRPrintErrorCodeChannelTimeout:
                code = @"BRPrintErrorCodeChannelTimeout";
                break;
            case BRPrintErrorCodeSetModelError:
                code = @"BRPrintErrorCodeSetModelError";
                break;
            case BRPrintErrorCodeUnsupportedFile:
                code = @"BRPrintErrorCodeUnsupportedFile";
                break;
            case BRPrintErrorCodeSetMarginError:
                code = @"BRPrintErrorCodeSetMarginError";
                break;
            case BRPrintErrorCodeSetLabelSizeError:
                code = @"BRPrintErrorCodeSetLabelSizeError";
                break;
            case BRPrintErrorCodeCustomPaperSizeError:
                code = @"BRPrintErrorCodeCustomPaperSizeError";
                break;
            case BRPrintErrorCodeSetLengthError:
                code = @"BRPrintErrorCodeSetLengthError";
                break;
            case BRPrintErrorCodeTubeSettingError:
                code = @"BRPrintErrorCodeTubeSettingError";
                break;
            case BRPrintErrorCodeChannelErrorStreamStatusError:
                code = @"BRPrintErrorCodeChannelErrorStreamStatusError";
                break;
            case BRPrintErrorCodeChannelErrorUnsupportedChannel:
                code = @"BRPrintErrorCodeChannelErrorUnsupportedChannel";
                break;
            case BRPrintErrorCodePrinterStatusErrorPaperEmpty:
                code = @"BRPrintErrorCodePrinterStatusErrorPaperEmpty";
                break;
            case BRPrintErrorCodePrinterStatusErrorCoverOpen:
                code = @"BRPrintErrorCodePrinterStatusErrorCoverOpen";
                break;
            case BRPrintErrorCodePrinterStatusErrorBusy:
                code = @"BRPrintErrorCodePrinterStatusErrorBusy";
                break;
            case BRPrintErrorCodePrinterStatusErrorPrinterTurnedOff:
                code = @"BRPrintErrorCodePrinterStatusErrorPrinterTurnedOff";
                break;
            case BRPrintErrorCodePrinterStatusErrorBatteryWeak:
                code = @"BRPrintErrorCodePrinterStatusErrorBatteryWeak";
                break;
            case BRPrintErrorCodePrinterStatusErrorExpansionBufferFull:
                code = @"BRPrintErrorCodePrinterStatusErrorExpansionBufferFull";
                break;
            case BRPrintErrorCodePrinterStatusErrorCommunicationError:
                code = @"BRPrintErrorCodePrinterStatusErrorCommunicationError";
                break;
            case BRPrintErrorCodePrinterStatusErrorPaperJam:
                code = @"BRPrintErrorCodePrinterStatusErrorPaperJam";
                break;
            case BRPrintErrorCodePrinterStatusErrorMediaCannotBeFed:
                code = @"BRPrintErrorCodePrinterStatusErrorMediaCannotBeFed";
                break;
            case BRPrintErrorCodePrinterStatusErrorOverHeat:
                code = @"BRPrintErrorCodePrinterStatusErrorOverHeat";
                break;
            case BRPrintErrorCodePrinterStatusErrorHighVoltageAdapter:
                code = @"BRPrintErrorCodePrinterStatusErrorHighVoltageAdapter";
                break;
            case BRPrintErrorCodePrinterStatusErrorUnknownError:
                code = @"BRPrintErrorCodePrinterStatusErrorUnknownError";
                break;
            case BRPrintErrorCodeUnknownError:
                code = @"BRPrintErrorCodeUnknownError";
                break;
        }
        
        return [FlutterError errorWithCode:code message:nil details:nil];
    }
    else {
        return [FlutterError errorWithCode:@"Unknown error" message:[error localizedDescription] details:nil];
    }
}

@end

