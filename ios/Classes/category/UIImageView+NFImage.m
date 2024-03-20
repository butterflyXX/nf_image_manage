//
//  UIView+NFImage.m
//  integration_test
//
//  Created by 刘晓晨 on 2024/3/20.
//

#import "UIImageView+NFImage.h"
#import "UIView+NFImage.h"

@implementation UIImageView(NFImage)

-(void)nf_setImageWithImageName:(NSString *)imageName packageName:(NSString *)packageName compression:(double)compression {
    self.image = nil;
    [super nf_setImageWithImageName:imageName packageName:packageName compression:compression callBack:^(NSData * _Nonnull data) {
        self.image = [UIImage imageWithData:data];
    }];
}

-(void)nf_setImageWithImageName:(NSString *)imageName {
    self.image = nil;
    [super nf_setImageWithImageName:imageName callBack:^(NSData * _Nonnull data) {
        self.image = [UIImage imageWithData:data];
    }];
}

@end
