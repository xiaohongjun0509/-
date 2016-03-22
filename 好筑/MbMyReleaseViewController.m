//
//  MbMyReleaseViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/29.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbMyReleaseViewController.h"
#import "JZQCommon.h"
#import "MbMyReleaseTableViewCell.h"
#import "MbFindWorkTableViewCell.h"
@interface MbMyReleaseViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;

@end

@implementation MbMyReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的发布";
    self.view.backgroundColor = [UIColor whiteColor];
    
  
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-110)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString* identifire = @"Cell";
    MbFindWorkTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[MbFindWorkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (viewHeight-110)/6;
    
}
@end
