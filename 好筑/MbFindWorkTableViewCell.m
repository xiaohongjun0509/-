//
//  MbFindWorkTableViewCell.m
//  Recruitment
//
//  Created by tusm on 15/10/23.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbFindWorkTableViewCell.h"
#import "JZQCommon.h"
@interface MbFindWorkTableViewCell()


@end
@implementation MbFindWorkTableViewCell
@synthesize delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         //标题
        self.titleLabel = [UILabel new];
        //self.titleLabel.text = @"本公司长期招项目经理";
        self.titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.titleLabel.font = [UIFont systemFontOfSize:labelText+2];
        
        [self.contentView addSubview:self.titleLabel];
        
        //工资
        self.moneyLabel = [UILabel new];
        //self.moneyLabel.text = @"12000-20000/月";
        self.moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:159/255.0 blue:48/255.0 alpha:1];
        self.moneyLabel.font = [UIFont systemFontOfSize:labelText+2];
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        //CGSize moneyLableSize = [self.moneyLabel.text sizeWithFont:self.moneyLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        //self.moneyLabel.frame = CGRectMake(viewWidth-15-moneyLableSize.width, self.titleLabel.frame.origin.y, moneyLableSize.width, moneyLableSize.height);
        [self.contentView addSubview:self.moneyLabel];
        
        //项目经理
        self.projectManagerLabel = [UILabel new];
        //self.projectManagerLabel.text = @"项目经理";
        self.projectManagerLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
        self.projectManagerLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.projectManagerLabel.textAlignment = NSTextAlignmentLeft;
        //CGSize projectManagerSize = [self.projectManagerLabel.text sizeWithFont:self.projectManagerLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        //self.projectManagerLabel.frame = CGRectMake(15, (viewHeight-109)/12-projectManagerSize.height/2, projectManagerSize.width, projectManagerSize.height);
        [self.contentView addSubview:self.projectManagerLabel];
        //地点
        self.placeLabel = [UILabel new];
        //self.placeLabel.text = @"朝阳";
        self.placeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.placeLabel.font = [UIFont systemFontOfSize:labelText+1];
        self.placeLabel.textAlignment = NSTextAlignmentRight;
        //CGSize placeLableSize = [self.placeLabel.text sizeWithFont:self.placeLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        //self.placeLabel.frame = CGRectMake(viewWidth-15-placeLableSize.width, self.projectManagerLabel.frame.origin.y, placeLableSize.width, placeLableSize.height);
        [self.contentView addSubview:self.placeLabel];
        //公司名称
        self.nameLabel = [UILabel new];
        //self.nameLabel.text = @"浙江";
     
        self.nameLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        self.nameLabel.font = [UIFont systemFontOfSize:labelText];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        //CGSize nameLableSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        //self.nameLabel.frame = CGRectMake(15, (viewHeight-109)/6-projectManagerSize.height-7, nameLableSize.width, nameLableSize.height);
        [self.contentView addSubview:self.nameLabel];
        //日期
        self.dateLabel = [UILabel new];
        //self.dateLabel.text = @"2015-01-01";
        self.dateLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        self.dateLabel.font = [UIFont systemFontOfSize:labelText];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        //CGSize dateLableSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        //self.dateLabel.frame = CGRectMake(viewWidth-15-dateLableSize.width, self.nameLabel.frame.origin.y, dateLableSize.width, dateLableSize.height);
        [self.contentView addSubview:self.dateLabel];
        }
        return self;
    
}

- (void)loadContent:(MbUserInfo*)data
{
    self.titleLabel.text = data.title;
    CGSize titleLabelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.titleLabel.frame = CGRectMake(15, 7, viewWidth/3*2, titleLabelSize.height);
    self.moneyLabel.text = data.wages;
    CGSize moneyLableSize = [self.moneyLabel.text sizeWithFont:self.moneyLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.moneyLabel.frame = CGRectMake(viewWidth-15-moneyLableSize.width, self.titleLabel.frame.origin.y, moneyLableSize.width, moneyLableSize.height);

    self.projectManagerLabel.text = data.position;
    
    CGSize projectManagerSize = [self.projectManagerLabel.text sizeWithFont:self.projectManagerLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.projectManagerLabel.frame = CGRectMake(15, (viewHeight-109)/12-projectManagerSize.height/2, projectManagerSize.width, projectManagerSize.height);
    
    
    self.placeLabel.text = data.address;
    
    CGSize placeLableSize = [self.placeLabel.text sizeWithFont:self.placeLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.placeLabel.frame = CGRectMake(viewWidth-15-placeLableSize.width, self.projectManagerLabel.frame.origin.y, placeLableSize.width, placeLableSize.height);
    
    self.nameLabel.text = data.company;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;

    CGSize nameLableSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.nameLabel.frame = CGRectMake(15, (viewHeight-109)/6-projectManagerSize.height-7, viewWidth/5*3, nameLableSize.height);
    NSTimeInterval time=[data.rectime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
   
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    self.dateLabel.text = currentDateStr;
    CGSize dateLableSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.dateLabel.frame = CGRectMake(viewWidth-15-dateLableSize.width, self.nameLabel.frame.origin.y, dateLableSize.width, dateLableSize.height);
}


@end
