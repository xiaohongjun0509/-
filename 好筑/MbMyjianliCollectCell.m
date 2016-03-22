//
//  MbMyjianliCollectCell.m
//  好筑
//
//  Created by tusm on 16/1/4.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import "MbMyjianliCollectCell.h"
#import "JZQCommon.h"
@implementation MbMyjianliCollectCell
@synthesize delegate;
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
        self.sexLabel.frame = CGRectMake(15, (viewHeight-109)/12-sexLabelSize.height/2, sexLabelSize.width, sexLabelSize.height);
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
        
        //选中按钮
        //self.seleteImage = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth-17-yearsLabelSize.height, self.yearsLabel.frame.origin.y, yearsLabelSize.height+2, yearsLabelSize.height+2)];
        //[self addSubview:self.seleteImage];
        
        //对号按钮
        //self.seleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-17-yearsLabelSize.height, self.yearsLabel.frame.origin.y, yearsLabelSize.height+2, yearsLabelSize.height+2)];
        //[self.seleteBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
        //[self.seleteBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co_col.png"] forState:UIControlStateSelected];
        //[self.seleteBtn addTarget:self action:@selector(seletedBtn2:) forControlEvents:UIControlEventTouchUpInside];
      
        //[self addSubview:self.seleteBtn];
        
        
        //自我介绍
        self.introductionLabel = [UILabel new];
        self.introductionLabel.text = @"(自我介绍)本人特别牛";
        self.introductionLabel.font = [UIFont systemFontOfSize:labelText];
        self.introductionLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        CGSize introductionSize = [self.introductionLabel.text sizeWithFont:self.introductionLabel.font constrainedToSize:CGSizeMake(400, 400) lineBreakMode:NSLineBreakByWordWrapping];
        self.introductionLabel.frame = CGRectMake(15, (viewHeight-109)/6-7-introductionSize.height, introductionSize.width, introductionSize.height);
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
//- (void)setChecked:(BOOL)checked{
//    
//    
//    if (checked)
//    {
//        self.seleteBtn.selected = checked;
//        [self.seleteBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co_col.png"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [self.seleteBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
//        
//    }
//    m_checked = checked;
//    
//    
//}
//-(void)seletedBtn2:(UIButton*)sender{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(seletedBtn2:)])
//    {
//        [self.delegate performSelector:@selector(seletedBtn2:) withObject:sender];
//    }
//    
//    
//    sender.selected = !sender.selected;
//    if (sender.selected==YES) {
//        [self.seleteBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co_col.png"] forState:UIControlStateNormal];
//    }else{
//        [self.seleteBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
//        
//    }
//    
//}

/**
 *  给单元格赋值
 *
 *  @param goodsModel 里面存放各个控件需要的数值
 */
-(void)addTheValue:(MbMyCollectionModel *)goodsModel
{
    
    
    if (goodsModel.selectState)
    {
        _selectState = YES;
        self.seleteImage.image = [UIImage imageNamed:@"home_7_co_col.png"];
    }else{
        _selectState = NO;
        self.seleteImage.image = [UIImage imageNamed:@"home_7_co.png"];
    }
    
}
- (void)loadContent:(MbUserInfo*)data{
    self.nameLabel.text = data.username;
    CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.nameLabel.frame = CGRectMake(15, 7, nameSize.width, nameSize.height);
    self.typeLabel.text = data.positioname;
    if (data.sex==1) {
        self.sexLabel.text = @"男";
    }else if (data.sex==2){
        self.sexLabel.text = @"女";
    }
    self.ageLabel.text = [NSString stringWithFormat:@"%d岁",data.age];
    self.educationLabel.text = data.diploma;
    CGSize educationLabelSize = [self.educationLabel.text sizeWithFont:self.educationLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.educationLabel.frame = CGRectMake(CGRectGetMaxX(self.ageLabel.frame)+20, self.sexLabel.frame.origin.y, educationLabelSize.width, educationLabelSize.height);
    
    
    CGSize yearsLabelSize = [data.suffer sizeWithFont:self.yearsLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.yearsLabel.frame = CGRectMake(CGRectGetMaxX(self.educationLabel.frame)+20, self.sexLabel.frame.origin.y, yearsLabelSize.width, yearsLabelSize.height);
    self.introductionLabel.text = data.title;
    CGSize introductionSize = [self.introductionLabel.text sizeWithFont:self.introductionLabel.font constrainedToSize:CGSizeMake(400, 400) lineBreakMode:NSLineBreakByWordWrapping];
    self.introductionLabel.frame = CGRectMake(15, (viewHeight-109)/6-7-introductionSize.height, viewWidth-120, introductionSize.height);
    
    
    NSTimeInterval time=[data.restime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    self.dateLabel.text = currentDateStr;
}
@end
