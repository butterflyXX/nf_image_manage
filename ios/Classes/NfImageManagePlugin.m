#import "NfImageManagePlugin.h"

@interface NfImageManagePlugin ()

@property(nonatomic, strong) FlutterMethodChannel *channel;

@end

@implementation NfImageManagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"nf_native_flutter_image_manage_channel"
            binaryMessenger:[registrar messenger]];
  NfImageManagePlugin* instance = [[NfImageManagePlugin alloc] init];
    instance.channel = channel;
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getNativeImage" isEqualToString:call.method]) {
      [self getNativeImageTask:call result:result];
  } else if ([@"flutterImage" isEqualToString:call.method]) {
    result(FlutterMethodNotImplemented);
  }
}

- (void)getNativeImageTask:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *name = call.arguments[@"imageName"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        double compression = 1.0;
        if (call.arguments[@"compression"]) {
            compression = [call.arguments[@"compression"] doubleValue];
        }
        UIImage *image = [UIImage imageNamed:name];
        NSData *data = UIImageJPEGRepresentation(image, compression);
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"AZ7A6708" ofType:@"JPG"];
//        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSUInteger maxLength = 1024*1024 << 2;
        NSUInteger totalLength = data.length;
        int count = ceil((totalLength*1.0)/maxLength);
        for (int i = 0; i < count; i++) {
            NSUInteger length = maxLength;
            if (i == count - 1) {
                length = totalLength - i*maxLength;
            }
            NSData *subData;
            if (i == 0) {
                subData = [data subdataWithRange:NSMakeRange(0, length)];
            } else {
                subData = [data subdataWithRange:NSMakeRange(i*maxLength, length)];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.channel invokeMethod:@"nativeImage" arguments:@{@"id":name,
                                                                      @"index":@(i),
                                                                      @"data":subData,
                                                                      @"length":@(totalLength),
                                                                      @"partCount":@(count),
                                                                    }];
            });
        }
    });
    
    
    result(@1);
}

@end
