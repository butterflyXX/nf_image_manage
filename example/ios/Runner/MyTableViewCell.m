//
//  MyTableViewCell.m
//  Runner
//
//  Created by 刘晓晨 on 2024/3/20.
//

#import "MyTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+NFImage.h"

@interface MyTableViewCell ()

@property(nonatomic, weak) UIImageView *iconImageView;

@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

-(void)setupUI {
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView = imageView;
    [self.contentView addSubview:self.iconImageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

-(void)setName:(NSString *)name {
    [self.iconImageView nf_setImageWithImageName:name];
}

@end
