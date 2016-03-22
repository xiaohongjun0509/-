//
//  MbMyCollectionTableViewCell.h
//  Recruitment
//
//  Created by tusm on 15/10/29.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbUserInfo.h"
#import "MbMyCollectionModel.h"
//添加代理，用于按钮加减的实现
@protocol MbMyCollectionTableViewCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;

@end


@interface MbMyCollectionTableViewCell : UITableViewCell{
    BOOL m_checked;
    UIImageView* m_checkImageView;

}
@property(nonatomic,assign)id<MbMyCollectionTableViewCellDelegate>delegate1;
@property(nonatomic,strong)UILabel* titleLabel;           //标题
@property(nonatomic,strong)UILabel* moneyLabel;           //工资
@property(nonatomic,strong)UILabel* projectManagerLabel;  //项目经理
@property(nonatomic,strong)UILabel* placeLabel;           //地点
@property(nonatomic,strong)UILabel* nameLabel;            //公司名字
@property(nonatomic,strong)UILabel* dateLabel;            //日期
@property(nonatomic,strong)UIButton* seleteBtn;           //对号按钮
@property(nonatomic,strong)UIImageView* seleteImage;      //选中按钮
@property (nonatomic,strong)UIViewController *delegate;
- (void)setChecked:(BOOL)checked;
- (void)loadContent:(MbUserInfo*)data;
@property(assign,nonatomic)BOOL selectState;//选中状态

//赋值
-(void)addTheValue:(MbMyCollectionModel *)goodsModel;
@end
