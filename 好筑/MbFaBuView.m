//
//  MbFaBuView.m
//  好筑
//
//  Created by tusm on 15/12/10.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbFaBuView.h"
#define frameWidth self.frame.size.width
#define frameHeight self.frame.size.height
@implementation MbFaBuView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self mainCreate];
    }
    return self;
}
#pragma mark 主界面控件
-(void)mainCreate
{
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0 , 0, frameWidth, frameHeight) style:UITableViewStylePlain];
    _tableView1.backgroundColor = [UIColor blackColor];
    _tableView1.showsHorizontalScrollIndicator = NO;
    _tableView1.showsVerticalScrollIndicator = NO;
    _tableView1.pagingEnabled = NO;
    _tableView1.bounces = YES;
    [self addSubview:_tableView1];
    
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0 , 0, frameWidth, frameHeight) style:UITableViewStylePlain];
    _tableView2.backgroundColor = [UIColor blackColor];
    _tableView2.showsHorizontalScrollIndicator = NO;
    _tableView2.showsVerticalScrollIndicator = NO;
    _tableView2.pagingEnabled = NO;
    _tableView2.bounces = YES;
    [self addSubview:_tableView2];
    _tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(0 , 0, frameWidth, frameHeight) style:UITableViewStylePlain];
    _tableView3.backgroundColor = [UIColor blackColor];
    _tableView3.showsHorizontalScrollIndicator = NO;
    _tableView3.showsVerticalScrollIndicator = NO;
    _tableView3.pagingEnabled = NO;
    _tableView3.bounces = YES;
    [self addSubview:_tableView3];
    
}



@end
