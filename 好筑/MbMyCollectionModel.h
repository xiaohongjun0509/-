//
//  MbMyCollectionModel.h
//  好筑
//
//  Created by tusm on 16/1/22.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MbMyCollectionModel : NSObject
@property(assign,nonatomic)BOOL selectState;//是否选中状态
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
