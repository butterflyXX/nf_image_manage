//
//  NFImageManage.h
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/18.
//

#import <Foundation/Foundation.h>
#import "FlutterImageTaskItem.h"
#import <Flutter/Flutter.h>



@interface NFImageManage : NSObject

+ (instancetype)shared;

+(void)setChannel:(FlutterMethodChannel *)channel;

+(FlutterImageTaskItem *)getFlutterImageWithImageName:(NSString *)imageName
                                          packageName:(NSString *)packageName
                                          compression:(double) compression
                                             callBack:(CallBackModel *) callBack;

+(FlutterImageTaskItem *)getTaskWithKey:(NSString *)key;

+(void)addCache;

@end
