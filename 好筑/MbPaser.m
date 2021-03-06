//
//  MbPaser.m
//  好筑
//
//  Created by tusm on 15/12/14.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbPaser.h"
#import "AFNetworking.h"
@implementation MbPaser
//轮播图
+(NSMutableArray*)paserBannerByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    NSDictionary* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.imageString = [dictionary objectForKey:@"image"];
        info.imageUrl = [dictionary objectForKey:@"url"];
        [list addObject:info];
    }
    return list;
}


//eduArray:(NSMutableArray*)eduArray workArray:(NSMutableArray*)workArray
+(void)sendResumeInformationByUserid:(NSString*)userId area:(NSString*)area introduces:(NSString* )introduces name:(NSString* )name sex:(int)sex age:(int)age education:(NSString*)education experience:(NSString*)experience position:(NSString*)position salary:(NSString*)salary telephone:(NSString*)telephone addeduArray:(NSString*)addeduArray addworkArray:(NSString*)addworkArray jieshao:(NSString*)jieshao result:(void(^)(ResumeSaveResponse *response, NSError *error))result{


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.设置登录参数
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
  
  //dict = @{@"userid":userId,@"title":introduces,@"username":name,@"age":[NSNumber numberWithInt:age],@"sex":[NSNumber numberWithInt:sex],@"diploma":education,@"experience":experience,@"position":position,@"wages":salary,@"phone":telephone,@"intruduction":jieshao};

    [dict setObject:userId forKey:@"userid"];
    [dict setObject:area forKey:@"area"];
    [dict setObject:introduces forKey:@"title"];
    [dict setObject:name forKey:@"username"];
    [dict setObject:[NSNumber numberWithInteger:age] forKey:@"age"];
    [dict setObject:[NSNumber numberWithInt:sex] forKey:@"sex"];
    [dict setObject:education forKey:@"diploma"];
    [dict setObject:experience forKey:@"experience"];
    [dict setObject:position forKey:@"position"];
    [dict setObject:salary forKey:@"wages"];
    [dict setObject:telephone forKey:@"phone"];
    if (addeduArray.length==0||addworkArray.length==0) {
        
    }else{
        [dict setObject:addeduArray forKey:@"education"];
        [dict setObject:addworkArray forKey:@"business"];
    }
  
    [dict setObject:jieshao forKey:@"intruduction"];

//    NSMutableString * str = [[NSMutableString alloc] initWithFormat:sendjianli];
//    NSURL * url = [[NSURL alloc] initWithString:str];
//    
//    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3];
//    [request setHTTPMethod:@"POST"];
//    NSData * postData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//    NSString * jsonStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",jsonStr);
//    //2.构建post参数
//    NSData * posValue = [jsonStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    
//    //3.将参数存放到http请求对象中
//    [request setHTTPBody:posValue];
//    
//      [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"%@",[dic objectForKey:@"msg"]);
//          
//            
//        }];
//    });
//



    
    //3.请求
    [manager POST:sendjianli parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
 
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];

        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
      
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        NSLog(@"%@===%d",response.message,response.turn);
        result(response, nil);

        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败: %@", error);
    }];

}


//发布招聘信息
+(void)sendResumeRecruitByUserid:(NSString*)userId title:(NSString*)title company:(NSString* )company ways:(NSString* )ways position:(NSString*)position area:(NSString*)area address:(NSString*)address experience:(NSString*)experience diploma:(NSString*)diploma wages:(NSString*)wages demand:(NSString*)demand aboutus:(NSString*)aboutus linkman:(NSString*)linkman phone:(NSString*)phone result:(void(^)(RecruitSaveResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.设置登录参数
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];

    
    [dict setObject:userId forKey:@"userid"];
    [dict setObject:title forKey:@"title"];
    [dict setObject:company forKey:@"company"];
    [dict setObject:ways forKey:@"ways"];
    [dict setObject:position forKey:@"position"];
    [dict setObject:area forKey:@"area"];
    [dict setObject:address forKey:@"address"];
    [dict setObject:experience forKey:@"experience"];
    [dict setObject:diploma forKey:@"diploma"];
    [dict setObject:wages forKey:@"wages"];
    [dict setObject:demand forKey:@"demand"];
    [dict setObject:aboutus forKey:@"aboutus"];
    [dict setObject:linkman forKey:@"linkman"];
    [dict setObject:phone forKey:@"phone"];

    //3.请求
    [manager POST:sendzhaopin parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        NSLog(@"%@===%d",response.message,response.turn);
        result(response, nil);
        
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败: %@", error);
    }];



}

//发布企业信息
+(void)sendInfoCompanyByUserid:(NSString*)userid company:(NSString*)company aptitude:(NSString*)aptitude range:(NSString*)range area:(NSString*)area address:(NSString*)address contact:(NSString*)contact phone:(NSString*)phone result:(void(^)(InfoCompanySaveResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.设置登录参数
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    
    
    [dict setObject:userid forKey:@"userid"];
    [dict setObject:company forKey:@"company"];
    [dict setObject:aptitude forKey:@"aptitude"];
    [dict setObject:range forKey:@"tedail"];
    [dict setObject:area forKey:@"area"];
    [dict setObject:address forKey:@"address"];
    [dict setObject:contact forKey:@"contact"];
    [dict setObject:phone forKey:@"phone"];

    //3.请求
    [manager POST:sendqiye parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
       
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        NSLog(@"%@===%d",response.message,response.turn);
        result(response, nil);
        
        
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败: %@", error);
    }];



}


//找工作
+(NSMutableArray*)paserFindWorkByDic:(NSDictionary*)dic{

    NSMutableArray* list = [NSMutableArray array];
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.recruitmenid = [dictionary objectForKey:@"recruitmenid"];
        info.area = [dictionary objectForKey:@"area"];
        info.position = [dictionary objectForKey:@"position"];
        info.address = [dictionary objectForKey:@"address"];
        info.wages = [dictionary objectForKey:@"wages"];
        
        info.company = [dictionary objectForKey:@"company"];
        info.title = [dictionary objectForKey:@"title"];
        info.rectime = [dictionary objectForKey:@"rectime"];
        info.ways = [dictionary objectForKey:@"ways"];
        
        info.diploma = [dictionary objectForKey:@"diploma"];
        info.experience = [dictionary objectForKey:@"experience"];
        info.demand = [dictionary objectForKey:@"demand"];
        info.linkman = [dictionary objectForKey:@"linkman"];
        info.phone = [dictionary objectForKey:@"phone"];
        info.aboutus = [dictionary objectForKey:@"aboutus"];
        [list addObject:info];
    }

    return list;
}
//工作收藏
+(void)sendRecruitmenCollectByUserid:(NSString*)userid recruitmenid:(NSString*)recruitmenid result:(void(^)(RecruitmenCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:recruitmenid forKey:@"recruitmenid"];
    [manager POST:collectionwork parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
 
        result(response, nil);

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];
    
}

//看简历列表
+(NSMutableArray*)paserSeeResumeByDic:(NSDictionary*)dic{
    
 
    
    NSMutableArray* list = [NSMutableArray array];
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
       
        info.age = [[dictionary objectForKey:@"age"]intValue];
        info.area = [dictionary objectForKey:@"area"];
        //工作经历
        info.business = [dictionary objectForKey:@"business"];
        info.diploma = [dictionary objectForKey:@"diploma"];
        info.suffer = [dictionary objectForKey:@"experience"];
        //教育经历
        info.experienced = [dictionary objectForKey:@"experienced"];
         info.intruduction = [dictionary objectForKey:@"intruduction"];
        info.phone = [dictionary objectForKey:@"phone"];
           info.position = [dictionary objectForKey:@"position"];
        info.restime = [dictionary objectForKey:@"restime"];
        info.resumeid = [dictionary objectForKey:@"resumeid"];
         info.sex = [[dictionary objectForKey:@"sex"]intValue];
 
        info.synopsis = [dictionary objectForKey:@"synopsis"];
        info.title = [dictionary objectForKey:@"title"];
        info.username = [dictionary objectForKey:@"username"];
        info.wages = [dictionary objectForKey:@"wages"];

      
        [list addObject:info];
    }
    
    return list;
}
//简历收藏
+(void)sendResumeCollectByUserid:(NSString*)userid resumeid:(NSString*)resumeid result:(void(^)(ResumeidCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:resumeid forKey:@"resumeid"];
    [manager POST:collectionresum parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];

}
//企业通列表
+(NSMutableArray*)paserEnterpriseByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    NSDictionary* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.address = [dictionary objectForKey:@"address"];
        info.area = [dictionary objectForKey:@"area"];
        info.company = [dictionary objectForKey:@"company"];
        info.companyid = [dictionary objectForKey:@"companyid"];
        info.comtime = [dictionary objectForKey:@"comtime"];
        info.contact = [dictionary objectForKey:@"contact"];
        info.intelligence = [dictionary objectForKey:@"intelligence"];
        info.phone = [dictionary objectForKey:@"phone"];
        info.range = [dictionary objectForKey:@"range"];
        info.tedail = [dictionary objectForKey:@"tedail"];
        [list addObject:info];
    }
    return list;
}
//企业通收藏
+(void)sendEnterpriseCollectByUserid:(NSString*)userid companyid:(NSString*)companyid result:(void(^)(EnterpriseCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:companyid forKey:@"companyid"];
    [manager POST:collectionenterprise parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];

}

//我的发布   工作
+(NSMutableArray*)paserMyFindWorkByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.recruitmenid = [dictionary objectForKey:@"recruitmenid"];
        info.area = [dictionary objectForKey:@"area"];
        info.position = [dictionary objectForKey:@"position"];
        info.address = [dictionary objectForKey:@"address"];
        info.wages = [dictionary objectForKey:@"wages"];
        
        info.company = [dictionary objectForKey:@"company"];
        info.title = [dictionary objectForKey:@"title"];
        info.rectime = [dictionary objectForKey:@"rectime"];
        info.ways = [dictionary objectForKey:@"ways"];
        
        info.diploma = [dictionary objectForKey:@"diploma"];
        info.experience = [dictionary objectForKey:@"experience"];
        info.demand = [dictionary objectForKey:@"demand"];
        info.linkman = [dictionary objectForKey:@"linkman"];
        info.phone = [dictionary objectForKey:@"phone"];
        info.aboutus = [dictionary objectForKey:@"aboutus"];
        [list addObject:info];
    }
    
    return list;
}
//我的发布   简历
+(NSMutableArray*)paserMySeeResumeByDic:(NSDictionary*)dic{

    NSMutableArray* list = [NSMutableArray array];
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.age = [[dictionary objectForKey:@"age"]intValue];
        info.area = [dictionary objectForKey:@"area"];
        //工作经历
        info.business = [dictionary objectForKey:@"business"];
        info.diploma = [dictionary objectForKey:@"diploma"];
        info.suffer = [dictionary objectForKey:@"experience"];
        //教育经历
        info.experienced = [dictionary objectForKey:@"experienced"];
        info.intruduction = [dictionary objectForKey:@"intruduction"];
        info.phone = [dictionary objectForKey:@"phone"];
        info.position = [dictionary objectForKey:@"position"];
        info.restime = [dictionary objectForKey:@"restime"];
        info.resumeid = [dictionary objectForKey:@"resumeid"];
        info.sex = [[dictionary objectForKey:@"sex"]intValue];
        
        info.synopsis = [dictionary objectForKey:@"synopsis"];
        info.title = [dictionary objectForKey:@"title"];
        info.username = [dictionary objectForKey:@"username"];
        info.wages = [dictionary objectForKey:@"wages"];
        

        [list addObject:info];
    }
    
    return list;

}
//我的发布   企业通
+(NSMutableArray*)paserMyEnterpriseByDic:(NSDictionary*)dic{

    NSMutableArray* list = [NSMutableArray array];
    NSDictionary* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.address = [dictionary objectForKey:@"address"];
        info.area = [dictionary objectForKey:@"area"];
        info.company = [dictionary objectForKey:@"company"];
        info.companyid = [dictionary objectForKey:@"companyid"];
        info.comtime = [dictionary objectForKey:@"comtime"];
        info.contact = [dictionary objectForKey:@"contact"];
        info.intelligence = [dictionary objectForKey:@"aptitude"];
        info.phone = [dictionary objectForKey:@"phone"];
        info.range = [dictionary objectForKey:@"range"];
        info.tedail = [dictionary objectForKey:@"tedail"];
        info.contact = [dictionary objectForKey:@"contact"];
        [list addObject:info];
    }
    return list;
}

//地区
+(NSMutableArray*)paserPlaceByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.name = [dictionary objectForKey:@"name"];
       
        [list addObject:info];
    }
    return list;
}
//教育
+(NSMutableArray*)paserEducationByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.diploma = [dictionary objectForKey:@"diploma"];
        [list addObject:info];
    }
    return list;
}
//经验
+(NSMutableArray*)paserExperienceByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.suffer = [dictionary objectForKey:@"suffer"];
        [list addObject:info];
    }
    return list;
}
//职位
+(NSMutableArray*)paserPositionByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.positioname = [dictionary objectForKey:@"positioname"];
        info.positionArray = [dictionary objectForKey:@"position"];
        [list addObject:info];
    }
    return list;
}
//薪资
+(NSMutableArray*)paserSalaryByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.pay = [dictionary objectForKey:@"pay"];
        [list addObject:info];
    }
    return list;
}
//城市列表
+(NSMutableArray*)paserCityListByDic:(NSDictionary*)dic{
    NSMutableArray* list = [NSMutableArray array];
    
    NSArray* data = [dic objectForKey:@"data"];
    for (NSDictionary* dictionary in data) {
        MbUserInfo* info = [[MbUserInfo alloc]init];
        info.name = [dictionary objectForKey:@"name"];
        info.areaid = [[dictionary objectForKey:@"areaid"]intValue];
        [list addObject:info];
    }
    return list;
}


//取消工作收藏
+(void)sendCancleRecruitmenCollectByUserid:(NSString*)userid recruitmencollid:(NSString*)recruitmencollid result:(void(^)(CancleRecruitmenCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:recruitmencollid forKey:@"recruitmencollid"];
    
   
    [manager POST:cancleWorkCollect parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}


//取消简历收藏
+(void)sendCancleResumecollCollectByUserid:(NSString*)userid resumecollid:(NSString*)resumecollid result:(void(^)(CancleResumecollCollectResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:resumecollid forKey:@"resumecollid"];
    [manager POST:cancleJianliCollect parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}
//取消企业通收藏
+(void)sendCancleCompanycollCollectByUserid:(NSString*)userid companycollid:(NSString*)companycollid result:(void(^)(CancleCompanycollCollectResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:companycollid forKey:@"companycollid"];
    [manager POST:cancleQiyeCollect parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];



}

//我的发布 招聘信息删除
+(void)sendMyReleaseRecruitDeleteByUserid:(NSString*)userid recruitmenid:(NSString*)recruitmenid result:(void(^)(MyReleaseRecruitDeleteResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:recruitmenid forKey:@"recruitmenid"];
    [manager POST:fabushanchu1 parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];

        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];

        result(response, nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}
//我的发布 简历删除
+(void)sendMyReleaseResumeDeleteByUserid:(NSString*)userid resumeid:(NSString*)resumeid result:(void(^)(MyReleaseResumeDeleteResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:resumeid forKey:@"resumeid"];
    [manager POST:fabushanchu2 parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];

        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];

        result(response, nil);
 
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}
//我的发布 企业通删除
+(void)sendMyReleaseEnterpriseDeleteByUserid:(NSString*)userid companyid:(NSString*)companyid result:(void(^)(MyReleaseEnterpriseDeleteResponse *response, NSError *error))result{
    
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:companyid forKey:@"companyid"];
    [manager POST:fabushanchu3 parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];

        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];



}
//我的发布 招聘信息刷新
+(void)sendMyReleaseRecruitRefreshByRecruitmenid:(NSString*)recruitmenid result:(void(^)(MyReleaseRecruitRefreshResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    //[dic setObject:userid forKey:@"userid"];
    [dic setObject:recruitmenid forKey:@"recruitmenid"];
    [manager POST:zhaopinRefresh parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
       
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];
    




}
//我的发布 简历刷新
+(void)sendMyReleaseResumeRefreshByResumeid:(NSString*)resumeid result:(void(^)(MyReleaseResumeRefreshResponse *response, NSError *error))result{
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    //[dic setObject:userid forKey:@"userid"];
    [dic setObject:resumeid forKey:@"resumeid"];
    [manager POST:jianliRefresh parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];



}
+(void)sendMyReleaseEnterpriseRefreshByUserid:(NSString*)userid companyid:(NSString*)companyid result:(void(^)(MyReleaseEnterpriseRefreshResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userid forKey:@"userid"];
    [dic setObject:companyid forKey:@"companyid"];
    [manager POST:qiyeRefresh parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
      
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}


//修改密码
+(void)modifyPassWordByPhone:(NSString*)telePhone oldWord:(NSString*)oldWord newWordOne:(NSString*)newWordOne newWordTwo:(NSString*)newWordTwo result:(void(^)(ModifyPassWordResponse *response, NSError *error))result{

    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:telePhone forKey:@"telephone"];
      [dic setObject:oldWord forKey:@"password"];
      [dic setObject:newWordOne forKey:@"newpasswordone"];
      [dic setObject:newWordTwo forKey:@"newpasswordtwo"];
    [manager POST:modifypassword parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str = [[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
   
        CommonActionStatus *response = [[CommonActionStatus alloc] initWithJSONObject:jsonObject];
        response.message = [jsonObject objectForKey:@"msg"];
        response.turn = [[jsonObject objectForKey:@"return"] intValue];
        
        
        result(response, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error==%@",error);
    }];


}
@end
