//
//  FlutterImageTaskItem.h
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBack)(NSData *data);
@interface FlutterImageTaskItem : NSObject

@property(nonatomic, strong) NSMutableDictionary<NSString *,NSData *> *datas;
@property(nonatomic, strong) NSMutableArray<CallBack> *callBacks;
@property(nonatomic, assign) NSInteger length;
@property(nonatomic, assign) NSInteger partCount;
@property(nonatomic, strong) NSData *fullData;

-(void)doTask;

-(void)addTaskCallBackWithCallBack:(CallBack) callBack;

-(void)removeTaskCallBackWithCallBack:(CallBack) callBack;

@end

NS_ASSUME_NONNULL_END
