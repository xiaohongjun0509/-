//
//  MbMyCollectionViewController.h
//  Recruitment
//
//  Created by tusm on 15/10/26.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbPaser.h"
#import "MbUserInfo.h"
@interface MbMyCollectionViewController : UIViewController
@property (strong, nonatomic) UITableView* tableView1;
@property (strong, nonatomic) UITableView* tableView2;
@property (strong, nonatomic) UITableView* tableView3;
@property (strong, nonatomic) MbUserInfo* info;
@property (strong, nonatomic) NSMutableArray* senderArray1;    //列表1的tag值

@end
