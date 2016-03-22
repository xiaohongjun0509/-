//
//  MbNavViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/22.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbNavViewController.h"

@interface MbNavViewController ()



@end

@implementation MbNavViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationBar *nacbar = [UINavigationBar appearance];
    UIBarButtonItem *button = [UIBarButtonItem appearance];
    [button setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    
    [nacbar setBackgroundImage:[UIImage imageNamed:@"nav_backgound"] forBarMetrics:UIBarMetricsDefault];
    //[nacbar setBackgroundColor:[UIColor colorWithRed:52/255.0 green:142/255.0 blue:221/255.0 alpha:1]];
    //导航栏文字大小和颜色
    [nacbar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    self.navigationBar.translucent = NO;
    //开启滑动返回
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
   

    
}

#pragma mark 重写barbutton
-(UIBarButtonItem *)createBackButton
{
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
}

-(void)popself
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1)
    {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
}


@end
