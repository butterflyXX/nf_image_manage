//
//  UIView+NFImage.h
//  integration_test
//
//  Created by 刘晓晨 on 2024/3/20.
//

#import <UIKit/UIKit.h>

@interface UIImageView(NFImage)

-(void)nf_setImageWithImageName:(NSString *)imageName packageName:(NSString *)packageName compression:(double)compression;

-(void)nf_setImageWithImageName:(NSString *)imageName;


@end
