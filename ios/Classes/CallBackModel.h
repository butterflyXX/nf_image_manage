//
//  CallBackModel.h
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/20.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(NSData *data);

@interface CallBackModel : NSObject

@property(nonatomic, weak) id key;
@property(nonatomic, copy) CallBack callBack;

-(void)doCallBack:(NSData *)data;

@end
