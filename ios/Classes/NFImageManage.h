//
//  NFImageManage.h
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/18.
//

#import <Foundation/Foundation.h>
#import "FlutterImageTaskItem.h"

NS_ASSUME_NONNULL_BEGIN



@interface NFImageManage : NSObject

@property(nonatomic, strong) NSMutableDictionary<NSString *, FlutterImageTaskItem *> *tasks;

+ (instancetype)shared;

+(void)getImageWithImageName:(NSString *)imageName callBack:(void(^)(NSData *data)) callBack;

@end

NS_ASSUME_NONNULL_END
