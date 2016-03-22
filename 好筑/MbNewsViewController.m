//
//  MbNewsViewController.m
//  好筑
//
//  Created by tusm on 16/2/4.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import "MbNewsViewController.h"
#import "JZQCommon.h"
#import "MbNewsTableViewCell.h"
@interface MbNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@end

@implementation MbNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-49-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString* identifire = @"Cell";
    MbNewsTableViewCell* cell = [self.tableView  dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[MbNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0.0f;
    MbNewsTableViewCell *cell = (MbNewsTableViewCell *)[self tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath];
    cellHeight = cell.finalH;
    return cellHeight;
}
@end
