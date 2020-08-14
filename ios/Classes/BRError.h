#ifndef BRError_h
#define BRError_h

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const BRErrorDomain;

enum {
    BRFailedToStartDiscoveryError = 1,
    BRDiscoveryInProgressError,
    BROpenChannelErrorCodeOpenStreamFailure,
    BROpenChannelErrorCodeTimeout,
    BRPrintErrorCodeMissingParameterError,
    BRPrintErrorCodePrintSettingsError,
    BRPrintErrorCodeFilepathURLError,
    BRPrintErrorCodePDFPageError,
    BRPrintErrorCodePrintSettingsNotSupportError,
    BRPrintErrorCodeDataBufferError,
    BRPrintErrorCodePrinterModelError,
    BRPrintErrorCodeCanceled,
    BRPrintErrorCodeChannelTimeout,
    BRPrintErrorCodeSetModelError,
    BRPrintErrorCodeUnsupportedFile,
    BRPrintErrorCodeSetMarginError,
    BRPrintErrorCodeSetLabelSizeError,
    BRPrintErrorCodeCustomPaperSizeError,
    BRPrintErrorCodeSetLengthError,
    BRPrintErrorCodeTubeSettingError,
    BRPrintErrorCodeChannelErrorStreamStatusError,
    BRPrintErrorCodeChannelErrorUnsupportedChannel,
    BRPrintErrorCodePrinterStatusErrorPaperEmpty,
    BRPrintErrorCodePrinterStatusErrorCoverOpen,
    BRPrintErrorCodePrinterStatusErrorBusy,
    BRPrintErrorCodePrinterStatusErrorPrinterTurnedOff,
    BRPrintErrorCodePrinterStatusErrorBatteryWeak,
    BRPrintErrorCodePrinterStatusErrorExpansionBufferFull,
    BRPrintErrorCodePrinterStatusErrorCommunicationError,
    BRPrintErrorCodePrinterStatusErrorPaperJam,
    BRPrintErrorCodePrinterStatusErrorMediaCannotBeFed,
    BRPrintErrorCodePrinterStatusErrorOverHeat,
    BRPrintErrorCodePrinterStatusErrorHighVoltageAdapter,
    BRPrintErrorCodePrinterStatusErrorUnknownError,
    BRPrintErrorCodeUnknownError
};

#endif /* BRError_h */
