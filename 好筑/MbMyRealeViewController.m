//
//  MbMyRealeViewController.m
//  好筑
//
//  Created by tusm on 15/12/7.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbMyRealeViewController.h"
#import "JZQCommon.h"
#import "MbSeeResumeTableViewCell.h"
#import "MbEnterpriseTableViewCell.h"
@interface MbMyRealeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@end

@implementation MbMyRealeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-110)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    MbEnterpriseTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[MbEnterpriseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
return (viewHeight-110)/5;

}
@end
