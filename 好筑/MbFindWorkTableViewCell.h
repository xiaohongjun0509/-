//
//  MbFindWorkTableViewCell.h
//  Recruitment
//
//  Created by tusm on 15/10/23.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbUserInfo.h"
@interface MbFindWorkTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* titleLabel;           //标题
@property(nonatomic,strong)UILabel* moneyLabel;           //工资
@property(nonatomic,strong)UILabel* projectManagerLabel;  //项目经理
@property(nonatomic,strong)UILabel* placeLabel;           //地点
@property(nonatomic,strong)UILabel* nameLabel;            //公司名字
@property(nonatomic,strong)UILabel* dateLabel;            //日期
- (void)loadContent:(MbUserInfo*)data;
@property (nonatomic, readonly) CGFloat finalH;


@property (nonatomic, strong)  UIViewController *delegate;
@end
