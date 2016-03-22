//
//  TRUtils.m
//  导航条
//
//  Created by zhanghongxing on 14-7-28.
//  Copyright (c) 2014年 zhanghongxing. All rights reserved.
//

#import "TRUtils.h"
#import "pinyin.h"
@implementation TRUtils
+(NSString*)changeCharacterToAlphabet:(NSString*)name
{
    char first = pinyinFirstLetter([name characterAtIndex:0]);
    NSString *sectionName;
    if ((first >='a' && first <'z') || (first >='A' && first <='Z')) {
        if ([self searchResult:name searchText:@"曾"]) {
            sectionName = @"Z";
        }else if ([self searchResult:name searchText:@"解"]) {
            sectionName = @"X";
        }else if ([self searchResult:name searchText:@"仇"]) {
            sectionName = @"Q";
        }else if ([self searchResult:name searchText:@"朴"]) {
            sectionName = @"P";
        }else if ([self searchResult:name searchText:@"查"]) {
            sectionName = @"Z";
        }else if ([self searchResult:name searchText:@"能"]) {
            sectionName = @"N";
        }else if ([self searchResult:name searchText:@"乐"]) {
            sectionName = @"Y";
        }else if ([self searchResult:name searchText:@"单"]) {
            sectionName = @"S";
        }else if ([self searchResult:name searchText:@"沈"]) {
            sectionName = @"S";
        }else{
            sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([name characterAtIndex:0])]uppercaseString];
        }
    }
    return sectionName;
}

+(BOOL)searchResult:(NSString*)contactName searchText:(NSString*)searchT
{
    NSComparisonResult result = [contactName compare:searchT options:NSCaseInsensitiveSearch range:NSMakeRange(0, searchT.length)];
    if (result == NSOrderedSame) {
        return YES;
    }else
        return NO;
}

+(NSMutableDictionary*)getDicWithArray:(NSArray*)nameArray
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *array = nil;
    
    array = [NSMutableArray array];
    for (int i = 'A'; i<'Z'; i++) {
        NSMutableArray *array = nil;
        
        array = [NSMutableArray array];
        bool isSame = NO;
        NSString *header = nil;
        for (NSString *str in nameArray) {
            header = [self  changeCharacterToAlphabet:str];
            if ([header isEqualToString:[NSString stringWithFormat:@"%c",i]]) {
                [array addObject:str];
                isSame = YES;
                
            }
          
        }
       
        if (isSame == YES) {
            [dic setObject:array forKey:[NSString stringWithFormat:@"%c",i]];
        }
}

   // NSLog(@"%@",dic);
    return dic;
}
+(NSArray*)getArrayWithArray:(NSArray*)nameArray
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *array = nil;
    array = [NSMutableArray array];
    
    for (int i = 'A'; i <= 'Z'; i++) {
        NSString *header = nil;
        bool isSame = NO;
        for (NSString *str in nameArray) {
            header = [self changeCharacterToAlphabet:str];
            if ([header  isEqualToString:[NSString stringWithFormat:@"%c",i]]) {
                [array addObject:str];
                isSame = YES;
            }
        }
        if (isSame == YES) {
            [dic setObject:array forKey:[NSString stringWithFormat:@"%c",i]];
        }
    }
    NSArray *allKey = dic.allKeys;
    allKey = [allKey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    return allKey;
}
@end
