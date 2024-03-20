//
//  TwoViewController.m
//  Runner
//
//  Created by 刘晓晨 on 2024/3/20.
//

#import "TwoViewController.h"
#import "Masonry.h"
#import "UIImageView+NFImage.h"
#import "MyTableViewCell.h"

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *list;

@end

NSString *cellId = @"cellId";

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:cellId];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    self.list = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 29; i++) {
        [self.list addObject:[NSString stringWithFormat:@"%d.png",i]];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.name = self.list[indexPath.row];
    return cell;
}

@end
