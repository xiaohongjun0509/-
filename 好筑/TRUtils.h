//
//  TRUtils.h
//  导航条
//
//  Created by zhanghongxing on 14-7-28.
//  Copyright (c) 2014年 zhanghongxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRUtils : NSObject
+(NSMutableDictionary*)getDicWithArray:(NSArray*)nameArray;
+(NSArray*)getArrayWithArray:(NSArray*)nameArray;
+(NSString*)changeCharacterToAlphabet:(NSString*)name;
+(BOOL)searchResult:(NSString*)contactName searchText:(NSString*)searchT;
@end
