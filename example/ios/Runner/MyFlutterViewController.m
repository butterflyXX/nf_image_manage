//
//  MyFlutterViewController.m
//  Runner
//
//  Created by 刘晓晨 on 2024/3/20.
//

#import "MyFlutterViewController.h"
#import "Masonry.h"
#import "NFImageManage.h"
#import "TwoViewController.h"

@interface MyFlutterViewController ()

@property(nonatomic, strong) UIButton *button;

@end

@implementation MyFlutterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

-(void)buttonClicked {
    [self presentViewController:[TwoViewController new] animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
