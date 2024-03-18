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
    }
    return self;
}

-(void)doTask {
    NSMutableData *data = [NSMutableData data];
    for (int i = 0; i < _datas.count; i++) {
        [data appendData:_datas[@(i).description]];
    }
    self.callBack(data);
}

@end
