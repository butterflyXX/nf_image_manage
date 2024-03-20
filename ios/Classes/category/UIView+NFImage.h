//
//  UIView+NFImage.h
//  integration_test
//
//  Created by 刘晓晨 on 2024/3/20.
//

#import <UIKit/UIKit.h>
#import "nf_image_manage/NFImageManage.h"


@interface UIView(NFImage)

-(void)nf_setImageWithImageName:(NSString *)imageName
                    packageName:(NSString *)packageName
                    compression:(double) compression
                       callBack:(CallBack) callBack;

-(void)nf_setImageWithImageName:(NSString *)imageName callBack:(CallBack) callBack;

@end
