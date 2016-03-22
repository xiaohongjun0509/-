//
//  MbWorkDetailsTableViewCell.m
//  Recruitment
//
//  Created by tusm on 15/10/23.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbWorkDetailsTableViewCell.h"
#import "JZQCommon.h"
@interface MbWorkDetailsTableViewCell()
@property(nonatomic,strong)UILabel* title;                //标题
@property(nonatomic,strong)UILabel* titleDetail;          //具体标题
@property(nonatomic,strong)UILabel* recruitment;          //招聘职位
@property(nonatomic,strong)UILabel* type;                 //类型
@property(nonatomic,strong)UILabel* company;              //公司名称
@property(nonatomic,strong)UILabel* dateLabel;            //日期
@property(nonatomic,strong)UITextField* companyField;     //输入公司名称
@property(nonatomic,strong)UIButton* recruitmentBtn;      //直招
@property(nonatomic,strong)UILabel* salary;               //薪资
@property(nonatomic,strong)UILabel* money;                //工资
@property(nonatomic,strong)UILabel* educationRequirement; //学历要求
@property(nonatomic,strong)UILabel* education;            //学历
@property(nonatomic,strong)UILabel* experienceRequirement; //经验要求
@property(nonatomic,strong)UILabel* years;                 //年限
@property(nonatomic,strong)UILabel* workLocation;          //工作地点
@property(nonatomic,strong)UILabel* place;                 //地区
@property(nonatomic,strong)UITextField* placeField;        //输入地点
@property(nonatomic,strong)UILabel* officeRequirement;     //任职要求
@property(nonatomic,strong)UILabel* requirement;           //具体要求
@property(nonatomic,strong)UILabel* companyIntroduction;   //公司简介
@property(nonatomic,strong)UILabel* introduction;          //公司具体简介
@property(nonatomic,strong)UILabel* contactPerson;         //联系人
@property(nonatomic,strong)UILabel* name;                  //联系人姓名
@property(nonatomic,strong)UILabel* telephone;             //电话
@property(nonatomic,strong)UILabel* telephoneNumber;       //号码
@property(nonatomic,strong)UILabel* confidential;          //保密
@property(nonatomic,strong)UILabel* line1;
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UILabel* line5;
@property(nonatomic,strong)UILabel* line6;
@property(nonatomic,strong)UILabel* line7;
@property(nonatomic,strong)UILabel* line8;
@property(nonatomic,strong)UILabel* line9;
@property(nonatomic,strong)UILabel* line10;
@property(nonatomic,strong)UILabel* line11;

@end
@implementation MbWorkDetailsTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  //标题
        self.title = [UILabel new];
        self.title.text = @"标题";
        self.title.font = [UIFont systemFontOfSize:labelText];
        CGSize titleSize = [self.title.text sizeWithFont:self.title.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        
      //招聘职位
        self.recruitment = [UILabel new];
        self.recruitment.text = @"招聘职位";
        self.recruitment.font = [UIFont systemFontOfSize:labelText];
        CGSize recruitmentSize = [self.recruitment.text sizeWithFont:self.recruitment.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.recruitment.frame = CGRectMake(15, 15, recruitmentSize.width, recruitmentSize.height);
        [self addSubview:self.recruitment];
        
    }
    return self;
    
}

@end
