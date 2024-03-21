//
//  CallBackModel.m
//  nf_image_manage
//
//  Created by 刘晓晨 on 2024/3/20.
//

#import "CallBackModel.h"

@implementation CallBackModel

-(void)doCallBack:(NSData *)data {
    if (self.key && self.callBack) {
        self.callBack(data);
    }
}

@end
