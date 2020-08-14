#import "BRError.h"
#import "BRPrinterDiscovery.h"

#import <BRLMPrinterKit/BRLMPrinterKit.h>
#import <BRLMPrinterKit/BRPtouchNetworkManager.h>
#import <BRLMPrinterKit/BRPtouchBluetoothManager.h>
#import <BRLMPrinterKit/BRPtouchBLEManager.h>

@interface BRPrinterDiscovery()<BRPtouchNetworkDelegate>

@end

@implementation BRPrinterDiscovery {
    BRPtouchNetworkManager *_networkManager;
    BRPrinterDiscoveryCompletion _completion;
    NSMutableArray<BRPtouchDeviceInfo *> *_bleDevices;
}

+ (nonnull instancetype)sharedInstance
{
    static BRPrinterDiscovery *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [BRPrinterDiscovery new];
    });
    return sharedInstance;
}

- (void)start:(int)delay printerNames:(NSArray *_Nonnull)printerNames isEnableIPv6Search:(BOOL)isEnableIPv6Search completion:(nonnull BRPrinterDiscoveryCompletion) completion
{
    assert(completion != nil);
    assert(delay > 0);

    if (_networkManager == nil) {
        _networkManager = [BRPtouchNetworkManager new];
        _networkManager.delegate = self;
        
        _bleDevices = [NSMutableArray<BRPtouchDeviceInfo *> new];
    }
    
    [_networkManager setIsEnableIPv6Search:isEnableIPv6Search];
    [_networkManager setPrinterNames:printerNames]; // if empty doesn't seems to work
    
    // Already in progress
    if (_completion != nil) {
        _completion(nil, [NSError errorWithDomain:BRErrorDomain code:BRDiscoveryInProgressError userInfo:nil]);
        return;
    }
    _completion = completion;

    int ret = [_networkManager startSearch:delay];
    if (ret != RET_TRUE) {
        _completion(nil, [NSError errorWithDomain:BRErrorDomain code:BRFailedToStartDiscoveryError userInfo:nil]);
        _completion = nil;
    }

    [_bleDevices removeAllObjects];
    [BRPtouchBLEManager.sharedManager startSearchWithCompletionHandler:^(BRPtouchDeviceInfo *device) {
        [self->_bleDevices addObject:device];
     }];
}

- (void)didFinishSearch:(BRPtouchNetworkManager *)manager {
    [BRPtouchBLEManager.sharedManager stopSearch];
    
    NSMutableArray *devicesJSON = [NSMutableArray new];
    
    for (BRPtouchDeviceInfo *device in [manager getPrinterNetInfo]) {
        [devicesJSON addObject:[self convertDeviceInfoToJson:device source:@"network"]];
    }

    for (BRPtouchDeviceInfo *device in _bleDevices) {
        [devicesJSON addObject:[self convertDeviceInfoToJson:device source:@"ble"]];
    }

    for (BRPtouchDeviceInfo *device in [BRPtouchBluetoothManager.sharedManager pairedDevices]) {
        [devicesJSON addObject:[self convertDeviceInfoToJson:device source:@"bluetooth"]];
    }
    
    _completion(devicesJSON, nil);
    _completion = nil;
}

-(NSDictionary *)convertDeviceInfoToJson:(BRPtouchDeviceInfo *)device source:(NSString *)source {
    return @{
        @"source": source,
        @"ipAddress": device.strIPAddress ? device.strIPAddress : [NSNull null],
        @"location": device.strLocation ? device.strLocation : [NSNull null],
        @"modelName": device.strModelName ? device.strModelName : [NSNull null],
        @"printerName": device.strPrinterName ? device.strPrinterName : [NSNull null],
        @"serialNumber": device.strSerialNumber ? device.strSerialNumber : [NSNull null],
        @"nodeName": device.strNodeName ? device.strNodeName : [NSNull null],
        @"macAddress": device.strMACAddress ? device.strMACAddress : [NSNull null],
        @"bleAdvertiseLocalName": device.strBLEAdvertiseLocalName ? device.strBLEAdvertiseLocalName : [NSNull null],
    };
}

@end

