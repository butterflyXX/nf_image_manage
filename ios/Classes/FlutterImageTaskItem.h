//
//  FlutterImageTaskItem.h
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/18.
//

#import <Foundation/Foundation.h>
#import "CallBackModel.h"

@interface FlutterImageTaskItem : NSObject

@property(nonatomic, strong) NSMutableDictionary<NSString *,NSData *> *datas;
@property(nonatomic, strong) NSMutableArray<CallBackModel *> *callBacks;
@property(nonatomic, assign) NSInteger length;
@property(nonatomic, assign) NSInteger partCount;
@property(nonatomic, strong) NSData *fullData;

-(void)doTask;

-(void)addTaskCallBackWithCallBack:(CallBackModel *) callBack;

-(void)removeTaskCallBackWithCallBack:(CallBackModel *) callBack;

@end
