//
//  MbDanli.h
//  好筑
//
//  Created by tusm on 16/1/21.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MbDanli : NSObject
@property(nonatomic,strong)NSString* cityName;
+ (id)sharedManager;
-(void)setCityName:(NSString*)CityName;
@end
