//
//  MbReViewController.h
//  好筑
//
//  Created by tusm on 15/12/7.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbMyReleaseViewController.h"
#import "MbMyRealViewController.h"
#import "MbMyRealeViewController.h"
#import "MbFaBuView.h"
#import "MbUserInfo.h"
#import "MbPaser.h"
@interface MbReViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *viewControllers;
@property (strong, nonatomic) UITableView* tableView1;
@property (strong, nonatomic) UITableView* tableView2;
@property (strong, nonatomic) UITableView* tableView3;
@property (strong, nonatomic) MbUserInfo* info;
@end
