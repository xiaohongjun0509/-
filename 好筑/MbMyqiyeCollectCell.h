//
//  MbMyqiyeCollectCell.h
//  好筑
//
//  Created by tusm on 16/1/4.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbUserInfo.h"
#import "MbMyCollectionModel.h"
@interface MbMyqiyeCollectCell : UITableViewCell{
    BOOL m_checked;
    UIImageView* m_checkImageView;
    
}
@property(nonatomic,strong)UILabel* nameLabel;    //公司名称
@property(nonatomic,strong)UILabel* placeLabel;   //地区
@property(nonatomic,strong)UILabel* dateLabel;    //日期
@property(nonatomic,strong)UIButton* seleteBtn;   //对号按钮
@property(nonatomic,strong)UIImageView* seleteImage;      //选中按钮
@property(nonatomic, strong)  UIViewController *delegate;
- (void)setChecked:(BOOL)checked;
@property(nonatomic,strong)NSArray* array;
@property(nonatomic, readonly) CGFloat finalH;
- (void)loadContent:(MbUserInfo*)data;
@property(assign,nonatomic)BOOL selectState;//选中状态

//赋值
-(void)addTheValue:(MbMyCollectionModel *)goodsModel;
@end
