//
//  MbEnterpriseinformationViewController.h
//  Recruitment
//
//  Created by tusm on 15/11/3.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbUserInfo.h"
#import "MbPaser.h"
@interface MbEnterpriseinformationViewController : UIViewController{
    

    UISearchDisplayController * searchDisplayController_;
    
    NSMutableArray * resultItems;
    NSArray * suggestItems;
}
@property(nonatomic,strong)NSString* cityName;

@end
