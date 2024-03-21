//
//  UIView+NFImage.m
//  integration_test
//
//  Created by 刘晓晨 on 2024/3/20.
//

#import "UIView+NFImage.h"
#import <objc/runtime.h>

const void *descriptionPtr = &descriptionPtr;

@interface TaskDescription : NSObject

@property(nonatomic, weak) FlutterImageTaskItem *task;
@property(nonatomic, weak) CallBackModel *callback;

@end

@implementation TaskDescription

-(void)remove {
    [self.task removeTaskCallBackWithCallBack:self.callback];
}

-(void)dealloc {
    NSLog(@"dealloc");
}

@end

@implementation UIView(NFImage)

-(void)nf_setImageWithImageName:(NSString *)imageName
                    packageName:(NSString *)packageName
                    compression:(double) compression
                       callBack:(CallBack) callBack {
    TaskDescription *description = objc_getAssociatedObject(self, descriptionPtr);
    if (description) {
        [description remove];
    }
    CallBackModel *model = [[CallBackModel alloc] init];
    model.key = self;
    model.callBack = callBack;
    FlutterImageTaskItem *task = [NFImageManage getFlutterImageWithImageName:imageName packageName:packageName compression:compression callBack:model];
    description = [[TaskDescription alloc] init];
    description.task = task;
    description.callback = model;
    objc_setAssociatedObject(self, descriptionPtr, description, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)nf_setImageWithImageName:(NSString *)imageName callBack:(CallBack) callBack {
    [self nf_setImageWithImageName:imageName packageName:nil compression:1 callBack:callBack];
}

@end
