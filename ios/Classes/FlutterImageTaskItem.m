//
//  FlutterImageTaskItem.m
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/18.
//

#import "FlutterImageTaskItem.h"

@implementation FlutterImageTaskItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.datas = [[NSMutableDictionary alloc] init];
        self.callBacks = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)doTask {
    NSMutableData *data = [NSMutableData data];
    for (int i = 0; i < _datas.count; i++) {
        [data appendData:_datas[@(i).description]];
    }
    [self.datas removeAllObjects];
    self.fullData = data;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        while (self.callBacks.count > 0) {
            [self.callBacks.lastObject doCallBack:data];
            [self.callBacks removeLastObject];
        }
    });
}

-(void)addTaskCallBackWithCallBack:(CallBackModel *) callBack {
    if (self.fullData) {
        [callBack doCallBack:self.fullData];
    } else {
        [self.callBacks addObject:callBack];
        
    }
}

-(void)removeTaskCallBackWithCallBack:(CallBackModel *) callBack {
    if ([self.callBacks containsObject:callBack]) {
        NSLog(@"-----");
    }
    [self.callBacks removeObject:callBack];
}

@end
