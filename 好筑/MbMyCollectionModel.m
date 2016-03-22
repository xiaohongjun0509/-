//
//  MbMyCollectionModel.m
//  好筑
//
//  Created by tusm on 16/1/22.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import "MbMyCollectionModel.h"

@implementation MbMyCollectionModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {

        self.selectState = [dict[@"selectState"]boolValue];
    }
    return  self;
}
@end
