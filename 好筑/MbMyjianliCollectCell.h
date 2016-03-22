//
//  MbMyjianliCollectCell.h
//  好筑
//
//  Created by tusm on 16/1/4.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbUserInfo.h"
#import "MbMyCollectionModel.h"
@interface MbMyjianliCollectCell : UITableViewCell{
    BOOL m_checked;
    UIImageView* m_checkImageView;
    
}
@property(nonatomic,strong)UILabel* nameLabel;           //姓名
@property(nonatomic,strong)UILabel* typeLabel;           //类别
@property(nonatomic,strong)UILabel* moneyLabel;          //薪资
@property(nonatomic,strong)UILabel* sexLabel;            //性别
@property(nonatomic,strong)UILabel* ageLabel;            //年龄
@property(nonatomic,strong)UILabel* educationLabel;      //学历
@property(nonatomic,strong)UILabel* yearsLabel;          //年限
@property(nonatomic,strong)UILabel* introductionLabel;   //自我介绍
@property(nonatomic,strong)UILabel* dateLabel;           //日期
@property(nonatomic,strong)UIButton* seleteBtn;          //对号按钮
@property(nonatomic,strong)UIImageView* seleteImage;      //选中按钮
@property (nonatomic, strong)  UIViewController *delegate;
- (void)setChecked:(BOOL)checked;
- (void)loadContent:(MbUserInfo*)data;
@property(assign,nonatomic)BOOL selectState;//选中状态

//赋值
-(void)addTheValue:(MbMyCollectionModel *)goodsModel;
@end
