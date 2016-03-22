//
//  AppDelegate.h
//  好筑
//
//  Created by tusm on 15/12/4.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbHomePageViewController.h"
#import "MbReleaseViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)MbHomePageViewController* homeVC;
@property(nonatomic,strong)MbReleaseViewController* releaseVC;
@end

