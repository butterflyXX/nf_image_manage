//
//  NFImageManage.m
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/18.
//

#import "NFImageManage.h"

static NFImageManage *_manage = nil;

@implementation NFImageManage

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manage = [[self alloc] init];
        _manage.tasks = [[NSMutableDictionary alloc] init];
    });
    return _manage;
}

-(void)putTaskWithImageName:(NSString *)imageName callBack:(void(^)(NSData *data)) callBack {
    FlutterImageTaskItem *item = [[FlutterImageTaskItem alloc] init];
   item.callBack = callBack;
   [self.tasks setValue:item forKey:imageName];
}

+(void)getImageWithImageName:(NSString *)imageName callBack:(void(^)(NSData *data)) callBack{
//   [[FlutterImageManage shared] putTaskWithImageName:imageName callBack:callBack];
//   [[AppDelegate getMethodChannel] invokeMethod:@"getFlutterImage" arguments:imageName];
}

@end
