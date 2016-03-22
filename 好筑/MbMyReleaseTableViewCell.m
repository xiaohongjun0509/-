//
//  MbMyReleaseTableViewCell.m
//  Recruitment
//
//  Created by tusm on 15/10/29.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbMyReleaseTableViewCell.h"
#import "JZQCommon.h"
@implementation MbMyReleaseTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //姓名
        self.nameLabel = [UILabel new];
        self.nameLabel.text = @"王尼玛";
        self.nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.nameLabel.font = [UIFont systemFontOfSize:labelText+2];
        CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.nameLabel.frame = CGRectMake(15, 7, nameSize.width, nameSize.height);
        [self addSubview:self.nameLabel];
        
        //类型
        self.typeLabel = [UILabel new];
        self.typeLabel.text = @"施工员";
        self.typeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.typeLabel.font = [UIFont systemFontOfSize:labelText+2];
        CGSize typeSize = [self.typeLabel.text sizeWithFont:self.typeLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.typeLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+20, self.nameLabel.frame.origin.y, typeSize.width, typeSize.height);
        [self addSubview:self.typeLabel];
        
        //工资
        self.moneyLabel = [UILabel new];
        self.moneyLabel.text = @"3000-5000/月";
        self.moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:159/255.0 blue:48/255.0 alpha:1];
        self.moneyLabel.font = [UIFont systemFontOfSize:labelText+2];
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        CGSize moneyLableSize = [self.moneyLabel.text sizeWithFont:self.moneyLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.moneyLabel.frame = CGRectMake(viewWidth-15-moneyLableSize.width, self.typeLabel.frame.origin.y, moneyLableSize.width, moneyLableSize.height);
        [self.contentView addSubview:self.moneyLabel];
        
        //性别
        self.sexLabel = [UILabel new];
        self.sexLabel.text = @"男";
        self.sexLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.sexLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.sexLabel.textAlignment = NSTextAlignmentRight;
        CGSize sexLabelSize = [self.sexLabel.text sizeWithFont:self.sexLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.sexLabel.frame = CGRectMake(15, (viewHeight-64)/12-sexLabelSize.height/2, sexLabelSize.width, sexLabelSize.height);
        [self.contentView addSubview:self.sexLabel];
        //年龄
        self.ageLabel = [UILabel new];
        self.ageLabel.text = @"29岁";
        self.ageLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.ageLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.ageLabel.textAlignment = NSTextAlignmentRight;
        CGSize ageLableSize = [self.ageLabel.text sizeWithFont:self.ageLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.ageLabel.frame = CGRectMake(CGRectGetMaxX(self.sexLabel.frame)+20, self.sexLabel.frame.origin.y, ageLableSize.width, ageLableSize.height);
        [self.contentView addSubview:self.ageLabel];
        //学历
        self.educationLabel = [UILabel new];
        self.educationLabel.text = @"本科";
        self.educationLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.educationLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.educationLabel.textAlignment = NSTextAlignmentRight;
        CGSize educationLabelSize = [self.educationLabel.text sizeWithFont:self.educationLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.educationLabel.frame = CGRectMake(CGRectGetMaxX(self.ageLabel.frame)+20, self.sexLabel.frame.origin.y, educationLabelSize.width, educationLabelSize.height);
        [self.contentView addSubview:self.educationLabel];
        
        //年限
        self.yearsLabel = [[UILabel alloc]init];
        self.yearsLabel.text = @"5-8年";
        self.yearsLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.yearsLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        CGSize yearsLabelSize = [self.yearsLabel.text sizeWithFont:self.yearsLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.yearsLabel.frame = CGRectMake(CGRectGetMaxX(self.educationLabel.frame)+20, self.sexLabel.frame.origin.y, yearsLabelSize.width, yearsLabelSize.height);
        [self addSubview:self.yearsLabel];
        
        //自我介绍
        self.introductionLabel = [UILabel new];
        self.introductionLabel.text = @"(自我介绍)本人特别牛";
        self.introductionLabel.font = [UIFont systemFontOfSize:labelText];
        self.introductionLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        CGSize introductionSize = [self.introductionLabel.text sizeWithFont:self.introductionLabel.font constrainedToSize:CGSizeMake(400, 400) lineBreakMode:NSLineBreakByWordWrapping];
        self.introductionLabel.frame = CGRectMake(15, (viewHeight-64)/6-7-introductionSize.height, introductionSize.width, introductionSize.height);
        [self addSubview:self.introductionLabel];
        //日期
        self.dateLabel = [UILabel new];
        self.dateLabel.text = @"2015-01-01";
        self.dateLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        self.dateLabel.font = [UIFont systemFontOfSize:labelText];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        CGSize dateLabelSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        self.dateLabel.frame = CGRectMake(viewWidth-15-dateLabelSize.width, self.introductionLabel.frame.origin.y, dateLabelSize.width, dateLabelSize.height);
        [self.contentView addSubview:self.dateLabel];
    }
    return self;
    
}
@end
