//
//  FlutterImageTaskItem.h
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlutterImageTaskItem : NSObject

@property(nonatomic, strong) NSMutableDictionary<NSString *,NSData *> *datas;
@property(nonatomic, copy) void(^callBack)(NSData *data);
@property(nonatomic, assign) NSInteger length;

-(void)doTask;

@end

NS_ASSUME_NONNULL_END
