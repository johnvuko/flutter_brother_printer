#ifndef BRPrinterDiscovery_h
#define BRPrinterDiscovery_h

#import <Foundation/Foundation.h>

typedef void (^BRPrinterDiscoveryCompletion)(NSArray * _Nullable devices,  NSError * _Nullable  error);

@interface BRPrinterDiscovery: NSObject

+ (nonnull instancetype)sharedInstance;
- (void)start:(int)delay printerNames:(NSArray *_Nonnull)printerNames isEnableIPv6Search:(BOOL)isEnableIPv6Search completion:(nonnull BRPrinterDiscoveryCompletion) completion;

@end

#endif /* BRPrinterDiscovery_h */
