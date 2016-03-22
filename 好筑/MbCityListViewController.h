//
//  MbCityListViewController.h
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbHomePageViewController.h"
#import "MbReleaseViewController.h"
@interface MbCityListViewController : UIViewController
@property (nonatomic,strong)MbHomePageViewController* homeVC;  //首页
@property (nonatomic,strong)MbReleaseViewController* releaseVC;
@end
