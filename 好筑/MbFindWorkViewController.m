//
//  MbFindWorkViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/23.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbFindWorkViewController.h"
#import "JZQCommon.h"
#import "MbFindWorkTableViewCell.h"
#import "MbWorkDetailsViewController.h"
#import "MJRefresh.h"
@interface MbFindWorkViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UITableView* tableView1;
@property(nonatomic,strong)UITableView* tableView2;
@property(nonatomic,strong)UILabel* line1;             //竖线1
@property(nonatomic,strong)UILabel* line2;             //竖线2
@property(nonatomic,strong)UILabel* ling3;             //横线
@property(nonatomic,strong)UIButton* positionBtn;      //职位按钮
@property(nonatomic,strong)UIButton* locationBtn;      //地区按钮
@property(nonatomic,strong)UIButton* salaryBtn;        //薪资按钮
@property(nonatomic,strong)UILabel* positionLabel;     //职位
@property(nonatomic,strong)UIImageView* positionImage; //职位下拉箭头
@property(nonatomic,strong)UIButton* positionDown;
@property(nonatomic,strong)UILabel* locationLabel;     //地区
@property(nonatomic,strong)UIImageView* locationImage; //地区下拉箭头
@property(nonatomic,strong)UIImageView* locationDown;
@property(nonatomic,strong)UILabel* salarLabel;        //薪资
@property(nonatomic,strong)UIImageView* salarImage;    //薪资下拉箭头
@property(nonatomic,strong)UIImageView* salarionDown;
@property(nonatomic,strong)MbWorkDetailsViewController* workDetailsVC;//工作详情页面
@property(nonatomic,strong)UIButton* btn1;
@property(nonatomic,strong)UIButton* btn2;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)NSArray* typeArray;         //职位类别
@property(nonatomic,strong)NSMutableArray* moneyArray;        //薪资数组
@property(nonatomic,strong)NSArray* array1;
@property(nonatomic,strong)NSArray* array2;
@property(nonatomic,strong)NSArray* array3;
@property(nonatomic,strong)NSArray* array4;
@property(nonatomic,strong)NSArray* array5;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,assign)NSInteger tag1;
@property(nonatomic,strong)UITapGestureRecognizer* singleTap;
@property(nonatomic,strong)NSMutableArray* lists;    //列表
@property(nonatomic,strong)NSMutableArray* positionList;
@property(nonatomic,strong)NSMutableArray* placeList; //地区列表
@property(nonatomic,strong)NSString* a;
@property(nonatomic,strong)NSString* b;
@property(nonatomic,strong)NSString* c;
@property(nonatomic,assign)int freshCount;
@property(nonatomic,strong)NSDictionary* dictionary; //保存临时数据
@property(nonatomic,strong)UIActivityIndicatorView* activity;     //小圆圈

@end

@implementation MbFindWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"找工作(%@)",self.cityName];
    self.view.backgroundColor = [UIColor whiteColor];
    self.freshCount=2;
    self.a = @"";
    self.b = @"";
    self.c = @"";

    self.positionList = [NSMutableArray array];
    self.moneyArray = [NSMutableArray array];
    self.dictionary = [[NSDictionary alloc]init];
    

    
    
    [self onCreate];
    [self getMessage];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 47, viewWidth, viewHeight-109)];
    [self.tableView registerClass:[MbFindWorkTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView1 registerClass:[MbFindWorkTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView2 registerClass:[MbFindWorkTableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreDongtai)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshDongtai)];

   
    
    [self.tableView.mj_header beginRefreshing];

    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    
 
}
//获取列表
-(void)getMessage{
    
    
    
    NSString* path = nil;
    if ([self.positionLabel.text isEqualToString:@"职位"]&&[self.locationLabel.text isEqualToString:@"地区"]&&[self.salarLabel.text isEqualToString:@"薪资"]) {
        path = [NSString stringWithFormat:@"%@?area=%@&hasNext=1",findwork,self.cityName];
    }else {
          path = [NSString stringWithFormat:@"%@?area=%@&position=%@&area=%@&wages=%@",findwork,self.cityName,self.a,self.b,self.c];

    }
    
    //小菊花
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activity.center = CGPointMake(viewWidth/2 - 10, viewHeight/2-10);//只能设置中心，不能设置大小
    [self.activity startAnimating];
    [self.view bringSubviewToFront:self.activity];
    [self.view addSubview:self.activity];
  
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:path];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    self.dictionary = dic;
    NSArray* array = [dic objectForKey:@"data"];
    if (array.count==0) {
        self.lists = nil;
        
        [self.tableView reloadData];
    }else{
    
        [self.activity stopAnimating];
        [self.activity setHidesWhenStopped:YES]; //当旋转结束时隐藏
    self.lists = [MbPaser paserFindWorkByDic:dic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    }


}
//应聘职位
-(void)getPosition{
    NSURL *url = [NSURL URLWithString:hopeposition1];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    self.positionList = [MbPaser paserPositionByDic:dic];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView1 reloadData];
    });
}


//地区
-(void)getPlace{
    NSString* path = [NSString stringWithFormat:@"%@area=%@",threeplace,self.cityName];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 
    NSURL *url = [NSURL URLWithString:path];

    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([dic isEqual:nil]) {
            self.placeList = nil;
        }
        self.placeList = [MbPaser paserPlaceByDic:dic];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView1 reloadData];
            });
    }];
    
    [task resume];
    

    
}


//期望薪资
-(void)getSalary{
    
    NSURL *url = [NSURL URLWithString:hopesalary];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    self.moneyArray = [MbPaser paserSalaryByDic:dic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView1 reloadData];
    });
    
    
}


-(void)freshDongtai{
    [self requestDongtaiByInt:1];
}
-(void)moreDongtai{
    [self requestDongtaiByInt:self.freshCount];
    self.freshCount++;
}
-(void)requestDongtaiByInt:(int)freshint{
    
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];

    if (freshint==1) {
        [self getMessage];
    }else if(freshint>1){
        NSString* path = nil;
        if ([self.positionLabel.text isEqualToString:@"职位"]&&[self.locationLabel.text isEqualToString:@"地区"]&&[self.salarLabel.text isEqualToString:@"薪资"]) {
            path = [NSString stringWithFormat:@"%@?hasNext=%d",findwork,freshint];
        }else {
            path = [NSString stringWithFormat:@"%@?position=%@&area=%@&wages=%@",findwork,self.a,self.b,self.c];
            
        }
        
        
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:path];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str = @"type=focus-c";//设置参数
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
        NSArray* array = [dic objectForKey:@"data"];
        if (array.count==0) {

            
//            self.lists = [MbPaser paserFindWorkByDic:self.dictionary];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            
            [self.lists addObjectsFromArray:[MbPaser paserFindWorkByDic:dic]];
            self.dictionary = dic;

            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
       
        
    }

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
   
    
    
    
}
//创建按钮
-(void)onCreate{
    //职位按钮
    self.positionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth/3-0.5, 46)];
    self.positionBtn.userInteractionEnabled = YES;
    [self.positionBtn addTarget:self action:@selector(position:) forControlEvents:UIControlEventTouchUpInside];
    self.positionBtn.tag = 1;
    [self.view addSubview:self.positionBtn];
    //职位label
    self.positionLabel = [[UILabel alloc]init];
    self.positionLabel.text = @"职位";
    self.positionLabel.textAlignment = NSTextAlignmentCenter;
    self.positionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.positionLabel.font = [UIFont systemFontOfSize:labelText+1];
    CGSize size1 = [self.positionLabel.text sizeWithFont:self.positionLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.positionLabel.frame = CGRectMake(self.positionBtn.frame.size.width/6, self.positionBtn.frame.size.height/2-size1.height/2, size1.width*2, size1.height);
    [self.positionBtn addSubview:self.positionLabel];
    //职位下拉箭头
    self.positionImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.positionBtn.frame.size.width/1.3,self.positionBtn.frame.size.height/2 - size1.width/6, size1.width/3, size1.width/3)];
    self.positionImage.image = [UIImage imageNamed:@"home_arrow42_d.png"];
    [self.positionBtn addSubview:self.positionImage];
    
    
   
    
    
    
    //线1
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/3, 10, 1, 26)];
    self.line1.backgroundColor = [UIColor colorWithRed:57/255.0 green:141/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:self.line1];
    //地区按钮
    self.locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/3+0.5, 0, viewWidth/3-1, 46)];
    self.locationBtn.userInteractionEnabled = YES;
    [self.locationBtn addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
    self.locationBtn.tag = 2;
    [self.view addSubview:self.locationBtn];
    
    //地区label
    self.locationLabel = [[UILabel alloc]init];
    self.locationLabel.text = @"地区";
        self.locationLabel.textAlignment = NSTextAlignmentCenter;
    self.locationLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.locationLabel.font = [UIFont systemFontOfSize:labelText+1];
    CGSize size2 = [self.locationLabel.text sizeWithFont:self.locationLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.locationLabel.frame = CGRectMake(self.locationBtn.frame.size.width/6, self.locationBtn.frame.size.height/2-size1.height/2, size2.width*2, size2.height);
    [self.locationBtn addSubview:self.locationLabel];
    //地区下拉箭头
    self.locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.locationBtn.frame.size.width/1.3,self.locationBtn.frame.size.height/2 - size2.width/6, size2.width/3, size2.width/3)];
    self.locationImage.image = [UIImage imageNamed:@"home_arrow42_d.png"];
    [self.locationBtn addSubview:self.locationImage];

    
    
    //线2
    self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/3*2-0.5, 10, 1, 26)];
    self.line2.backgroundColor = [UIColor colorWithRed:57/255.0 green:141/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:self.line2];
    //薪资按钮
    self.salaryBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/3*2+0.5, 0, viewWidth/3-0.5, 46)];
    self.salaryBtn.userInteractionEnabled = YES;
    [self.salaryBtn addTarget:self action:@selector(salary:) forControlEvents:UIControlEventTouchUpInside];
    self.salaryBtn.tag = 3;
    [self.view addSubview:self.salaryBtn];
    
    //地区label
    self.salarLabel = [[UILabel alloc]init];
    self.salarLabel.text = @"薪资";
    self.salarLabel.textAlignment = NSTextAlignmentCenter;
    self.salarLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.salarLabel.font = [UIFont systemFontOfSize:labelText+1];
    CGSize size3 = [self.salarLabel.text sizeWithFont:self.salarLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.salarLabel.frame = CGRectMake(self.salaryBtn.frame.size.width/6, self.salaryBtn.frame.size.height/2-size1.height/2, size3.width*2, size3.height);
    [self.salaryBtn addSubview:self.salarLabel];
    //地区下拉箭头
    self.salarImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.salaryBtn.frame.size.width/1.3,self.salaryBtn.frame.size.height/2 - size3.width/6, size3.width/3, size3.width/3)];
    self.salarImage.image = [UIImage imageNamed:@"home_arrow42_d.png"];
    [self.salaryBtn addSubview:self.salarImage];
    //横线
    self.ling3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.positionBtn.frame), viewWidth, 1)];
    self.ling3.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.view addSubview:self.ling3];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==self.tableView) {
        return self.lists.count;
    }else if (tableView==self.tableView1){
    
        if (self.tag==1) {
            return self.positionList.count;
        }else if (self.tag==2){
        return self.placeList.count;
        }else if (self.tag==3){
        
            return self.moneyArray.count;
        }
        
    }else if (tableView==self.tableView2){
        
        MbUserInfo* info = [self.positionList objectAtIndex:self.tag1];
        return info.positionArray.count;
//        if (self.tag1==0) {
//            return self.array1.count;
//        }else if (self.tag1==1){
//            return self.array2.count;
//        }else if (self.tag1==2){
//            return self.array3.count;
//        }else if (self.tag1==3){
//            return self.array4.count;
//        }else if (self.tag1==4){
//            return self.array5.count;
//        }
    
    }
    return 0;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString* identifire = @"Cell";
    MbFindWorkTableViewCell* cell = nil;
    UITableViewCell* cell1 = nil;
    UITableViewCell* cell2 = nil;
    if (tableView==self.tableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifire];
//        if (!cell) {
//            cell = [[MbFindWorkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
//            cell.delegate = self;
//            return cell;
//        }
        MbUserInfo* info = [self.lists objectAtIndex:indexPath.row];
        [cell loadContent:info];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if(tableView==self.tableView1){
        cell1 = [self.tableView1 cellForRowAtIndexPath:indexPath];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            
        }
        if (self.tag==1) {
            
            MbUserInfo* info = [self.positionList objectAtIndex:indexPath.row];
            cell1.textLabel.text = info.positioname;
            
        }else if (self.tag==2){
        
            MbUserInfo* info = [self.placeList objectAtIndex:indexPath.row];
         
            cell1.textLabel.text = info.name;
        }else if (self.tag==3){
            MbUserInfo* info = [self.moneyArray objectAtIndex:indexPath.row];
         cell1.textLabel.text = info.pay;
        }
        
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell1.textLabel.font = [UIFont systemFontOfSize:labelText];
       return cell1;
    }else if (tableView==self.tableView2){
        cell2 = [self.tableView2 cellForRowAtIndexPath:indexPath];
        if (!cell2) {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        }
        
        MbUserInfo* info = [self.positionList objectAtIndex:self.tag1];
        NSDictionary* dic = [info.positionArray objectAtIndex:indexPath.row];
        cell2.textLabel.text = [dic objectForKey:@"positioname"];
//        if (self.tag1==0) {
//            cell2.textLabel.text = [self.array1 objectAtIndex:indexPath.row];
//        }else if (self.tag1==1){
//            cell2.textLabel.text = [self.array2 objectAtIndex:indexPath.row];
//        }else if (self.tag1==2){
//            cell2.textLabel.text = [self.array3 objectAtIndex:indexPath.row];
//        }else if (self.tag1==3){
//            cell2.textLabel.text = [self.array4 objectAtIndex:indexPath.row];
//        }else if (self.tag1==4){
//            cell2.textLabel.text = [self.array5 objectAtIndex:indexPath.row];
//        }
        
        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell2.textLabel.font = [UIFont systemFontOfSize:labelText];
    
        return cell2;
    }
    
    
    
    //[cell setSeparatorInset:UIEdgeInsetsZero];
    //[cell setLayoutMargins:UIEdgeInsetsZero];
    //[cell setPreservesSuperviewLayoutMargins:NO];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
         return (viewHeight-109)/6;
    }else
        return 44;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
        self.workDetailsVC = [[MbWorkDetailsViewController alloc]init];
        MbUserInfo* info = [self.lists objectAtIndex:indexPath.row];
        self.workDetailsVC.info = info;
        [self.navigationController pushViewController:self.workDetailsVC animated:YES];
    }else if (tableView==self.tableView1){
        if (self.tag==1) {
//            self.positionLabel.text = [self.typeArray objectAtIndex:indexPath.row];
//            self.positionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.positionLabel.textColor = [UIColor blackColor];
            self.tag1 = indexPath.row;
            [self.btn1 removeFromSuperview];
            [self create];
//            if (self.tag1==0) {
//                [self create];
//            }else if (self.tag1==1){
//            
//            [self create];
//                
//            }else if (self.tag1==2){
//                [self create];
//            }else if (self.tag1==3){
//                [self create];
//            }else if (self.tag1==4){
//                [self create];
//            
//            }
            
            
        }else if (self.tag==2){
            MbUserInfo* info = [self.placeList objectAtIndex:indexPath.row];
            self.locationLabel.text = info.name;
            self.b = info.name;
            self.locationLabel.font = [UIFont systemFontOfSize:labelText];
            self.locationLabel.textColor = [UIColor blackColor];
            [self.btn1 removeFromSuperview];
            [self getMessage];
        }else if (self.tag==3){
            MbUserInfo* info = [self.moneyArray objectAtIndex:indexPath.row];
            self.salarLabel.text = info.pay;
            self.c = info.pay;
            self.salarLabel.font = [UIFont systemFontOfSize:labelText];
            self.salarLabel.textColor = [UIColor blackColor];
            [self.btn1 removeFromSuperview];
             [self getMessage];
        }
    
    
    }else if (tableView==self.tableView2){
        MbUserInfo* info = [self.positionList objectAtIndex:self.tag1];
        NSDictionary* dic = [info.positionArray objectAtIndex:indexPath.row];
        NSString* string = [dic objectForKey:@"positioname"];
        self.positionLabel.text = string;
        self.a = string;
        self.positionLabel.textColor = [UIColor blackColor];
        
//        if (self.tag1==0) {
//            self.positionLabel.text = [self.array1 objectAtIndex:indexPath.row];
//            self.positionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.positionLabel.textColor = [UIColor blackColor];
//        }else if (self.tag1==1){
//            self.positionLabel.text = [self.array2 objectAtIndex:indexPath.row];
//            self.positionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.positionLabel.textColor = [UIColor blackColor];
//        }else if (self.tag1==2){
//            self.positionLabel.text = [self.array3 objectAtIndex:indexPath.row];
//            self.positionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.positionLabel.textColor = [UIColor blackColor];
//        }else if (self.tag1==3){
//            self.positionLabel.text = [self.array4 objectAtIndex:indexPath.row];
//            self.positionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.positionLabel.textColor = [UIColor blackColor];
//        }else if (self.tag1==4){
//            self.positionLabel.text = [self.array5 objectAtIndex:indexPath.row];
//            self.positionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.positionLabel.textColor = [UIColor blackColor];
//        }
        
        [self.btn2 removeFromSuperview];
         [self getMessage];
    }
    
 
    
}
-(void)create{
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn2.backgroundColor = [color colorWithAlphaComponent:0.5];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
    [self.btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn2];
    
    
    //标题
    self.titleLabel = [[UILabel alloc]init];
    
    self.titleLabel.text = @"职位类别";
    self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.frame = CGRectMake(15, (viewHeight - 344)/2, viewWidth - 30, 40);
    [self.btn2 addSubview:self.titleLabel];
    
    //列表
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth - 30, 240)];
    self.tableView2.dataSource = self;
    self.tableView2.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView2 reloadData];
    [self.btn2 addSubview:self.tableView2];

}

//职位按钮方法
-(void)position:(UIButton*)sender{
    [self getPosition];
    
    self.tag = sender.tag;
   
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn1.backgroundColor = [color colorWithAlphaComponent:0.5];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
        [self.btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];

    
    //标题
    self.titleLabel = [[UILabel alloc]init];
    
    self.titleLabel.text = @"职位类别";
    self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.frame = CGRectMake(15, (viewHeight - 344)/2, viewWidth - 30, 40);
    [self.btn1 addSubview:self.titleLabel];
    
    //列表
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth - 30, 240)];
    self.tableView1.dataSource = self;
    self.tableView1.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView1 reloadData];
    [self.btn1 addSubview:self.tableView1];
    
    
}
//地区按钮方法
-(void)location:(UIButton*)sender{
    [self getPlace];
    self.tag = sender.tag;
    
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn1.backgroundColor = [color colorWithAlphaComponent:0.5];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
        [self.btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];
    
    
    //标题
    self.titleLabel = [[UILabel alloc]init];
    
    self.titleLabel.text = @"地区";
    self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.frame = CGRectMake(15, (viewHeight - 344)/2, viewWidth - 30, 40);
    [self.btn1 addSubview:self.titleLabel];
    
    //列表
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth - 30, 240)];
    self.tableView1.dataSource = self;
    self.tableView1.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView1 reloadData];
    [self.btn1 addSubview:self.tableView1];
}
//薪资按钮方法
-(void)salary:(UIButton*)sender{
    [self getSalary];
    self.tag = sender.tag;
   
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn1.backgroundColor = [color colorWithAlphaComponent:0.5];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
        [self.btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.userInteractionEnabled = YES;
    [self.view addSubview:self.btn1];
    
    
    //标题
    self.titleLabel = [[UILabel alloc]init];
    
    self.titleLabel.text = @"薪资待遇";
    self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.frame = CGRectMake(15, (viewHeight - 344)/2, viewWidth - 30, 40);
    [self.btn1 addSubview:self.titleLabel];
    
    //列表
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth - 30, 240)];
    self.tableView1.dataSource = self;
    self.tableView1.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView1 reloadData];
    [self.btn1 addSubview:self.tableView1];
}
-(void)btn1:(UIButton* )sender{
    [self.btn1 removeFromSuperview];
    
}
-(void)btn2:(UIButton* )sender{
    [self.btn2 removeFromSuperview];
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer.view isKindOfClass:[UITableView class]]) {
        
        return YES;
    } else {
        return NO;
    }
}
@end
