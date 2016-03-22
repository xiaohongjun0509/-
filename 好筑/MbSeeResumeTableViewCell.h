//
//  MbSeeResumeTableViewCell.h
//  Recruitment
//
//  Created by tusm on 15/10/23.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbUserInfo.h"
@interface MbSeeResumeTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* nameLabel;           //姓名
@property(nonatomic,strong)UILabel* typeLabel;           //类别
@property(nonatomic,strong)UILabel* moneyLabel;          //薪资
@property(nonatomic,strong)UILabel* sexLabel;            //性别
@property(nonatomic,strong)UILabel* ageLabel;            //年龄
@property(nonatomic,strong)UILabel* educationLabel;      //学历
@property(nonatomic,strong)UILabel* yearsLabel;          //年限
@property(nonatomic,strong)UILabel* introductionLabel;   //自我介绍
@property(nonatomic,strong)UILabel* dateLabel;           //日期
@property(nonatomic,strong)UIViewController* delegate;
- (void)loadContent:(MbUserInfo*)data;
@end
