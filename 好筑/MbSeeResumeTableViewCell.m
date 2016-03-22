//
//  MbSeeResumeTableViewCell.m
//  Recruitment
//
//  Created by tusm on 15/10/23.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbSeeResumeTableViewCell.h"
#import "JZQCommon.h"
@interface MbSeeResumeTableViewCell()

@end
@implementation MbSeeResumeTableViewCell
@synthesize delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //姓名
        self.nameLabel = [UILabel new];
       
        self.nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.nameLabel.font = [UIFont systemFontOfSize:labelText+2];
 
        [self addSubview:self.nameLabel];
        
        //类型
        self.typeLabel = [UILabel new];
 
        self.typeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.typeLabel.font = [UIFont systemFontOfSize:labelText+2];
        
        [self addSubview:self.typeLabel];
        
        //工资
        self.moneyLabel = [UILabel new];
       
        self.moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:159/255.0 blue:48/255.0 alpha:1];
        self.moneyLabel.font = [UIFont systemFontOfSize:labelText+2];
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.moneyLabel];
        
        //性别
        self.sexLabel = [UILabel new];
   
        self.sexLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.sexLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.sexLabel.textAlignment = NSTextAlignmentRight;
    
        [self.contentView addSubview:self.sexLabel];
        //年龄
        self.ageLabel = [UILabel new];
        
        self.ageLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.ageLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.ageLabel.textAlignment = NSTextAlignmentRight;
      
        [self.contentView addSubview:self.ageLabel];
        //学历
        self.educationLabel = [UILabel new];
        
        self.educationLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.educationLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.educationLabel.textAlignment = NSTextAlignmentRight;
 
        [self.contentView addSubview:self.educationLabel];
        
        //年限
        self.yearsLabel = [[UILabel alloc]init];
      
        self.yearsLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.yearsLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    
        [self addSubview:self.yearsLabel];
        
        //自我介绍
        self.introductionLabel = [UILabel new];
   
        self.introductionLabel.font = [UIFont systemFontOfSize:labelText];
        self.introductionLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
   
        [self addSubview:self.introductionLabel];
        //日期
        self.dateLabel = [UILabel new];
        
        self.dateLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        self.dateLabel.font = [UIFont systemFontOfSize:labelText];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.dateLabel];
    }
    return self;
    
}
- (void)loadContent:(MbUserInfo*)data{
    self.nameLabel.text = data.username;
    UILabel* label = [[UILabel alloc]init];
    label.text = @"地方了感觉";
    label.font = [UIFont systemFontOfSize:labelText];
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByCharWrapping];
    
    
    CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(200, size.height) lineBreakMode:NSLineBreakByWordWrapping];
    self.nameLabel.frame = CGRectMake(15, 7, viewWidth/2, size.height);
    self.moneyLabel.text = data.wages;
    
    CGSize moneyLableSize = [self.moneyLabel.text sizeWithFont:self.moneyLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.moneyLabel.frame = CGRectMake(viewWidth-15-moneyLableSize.width, self.typeLabel.frame.origin.y, moneyLableSize.width, moneyLableSize.height);
    

    self.typeLabel.text = data.positioname;
    CGSize typeSize = [self.typeLabel.text sizeWithFont:self.typeLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.typeLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+20, self.nameLabel.frame.origin.y, typeSize.width, typeSize.height);
    if (data.sex==1) {
        self.sexLabel.text = @"男";
    }else if (data.sex==2){
    self.sexLabel.text = @"女";
    }
    CGSize sexLabelSize = [self.sexLabel.text sizeWithFont:self.sexLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.sexLabel.frame = CGRectMake(15, (viewHeight-109)/12-sexLabelSize.height/2, sexLabelSize.width, sexLabelSize.height);
    self.ageLabel.text = [NSString stringWithFormat:@"%d岁",data.age];
    CGSize ageLableSize = [self.ageLabel.text sizeWithFont:self.ageLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.ageLabel.frame = CGRectMake(CGRectGetMaxX(self.sexLabel.frame)+20, self.sexLabel.frame.origin.y, ageLableSize.width, ageLableSize.height);
    
    self.educationLabel.text = data.diploma;
    
    CGSize educationLabelSize = [self.educationLabel.text sizeWithFont:self.educationLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.educationLabel.frame = CGRectMake(CGRectGetMaxX(self.ageLabel.frame)+20, self.sexLabel.frame.origin.y, educationLabelSize.width, educationLabelSize.height);

    self.yearsLabel.text = data.suffer;
    
    CGSize yearsLabelSize = [self.yearsLabel.text sizeWithFont:self.yearsLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.yearsLabel.frame = CGRectMake(CGRectGetMaxX(self.educationLabel.frame)+20, self.sexLabel.frame.origin.y, yearsLabelSize.width, yearsLabelSize.height);
    self.introductionLabel.text = data.title;
    CGSize introductionSize = [self.introductionLabel.text sizeWithFont:self.introductionLabel.font constrainedToSize:CGSizeMake(400, 400) lineBreakMode:NSLineBreakByWordWrapping];
    self.introductionLabel.frame = CGRectMake(15, (viewHeight-109)/6-7-introductionSize.height, introductionSize.width, introductionSize.height);
    NSTimeInterval time=[data.restime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    self.dateLabel.text = currentDateStr;
    CGSize dateLabelSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.dateLabel.frame = CGRectMake(viewWidth-15-dateLabelSize.width, self.introductionLabel.frame.origin.y, dateLabelSize.width, dateLabelSize.height);
}
@end
