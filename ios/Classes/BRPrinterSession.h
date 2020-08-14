#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRPrinterSession : NSObject

- (void)printPDF:(nonnull NSString*) path model:(NSInteger)model ipAddress:(nonnull NSString*) ipAddress error:(NSError **)error;
- (void)printPDF:(nonnull NSString*) path model:(NSInteger)model serialNumber:(nonnull NSString*) serialNumber error:(NSError **)error;
- (void)printPDF:(nonnull NSString*) path model:(NSInteger)model bleAdvertiseLocalName:(nonnull NSString*) bleAdvertiseLocalName error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
