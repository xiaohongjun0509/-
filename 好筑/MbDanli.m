//
//  MbDanli.m
//  好筑
//
//  Created by tusm on 16/1/21.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import "MbDanli.h"




static MbDanli * _userInfo;
@implementation MbDanli
+ (id)sharedManager{
    
    if (!_userInfo) {
        
        _userInfo = [[MbDanli alloc]init];
        
    }
    
    return _userInfo;
    
}
@end
