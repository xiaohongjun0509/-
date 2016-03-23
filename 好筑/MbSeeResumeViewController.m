//
//  MbSeeResumeViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/23.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbSeeResumeViewController.h"
#import "JZQCommon.h"
#import "MbSeeResumeTableViewCell.h"
#import "MbResumeDetailsViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
@interface MbSeeResumeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UITableView* tableView1;
@property(nonatomic,strong)UITableView* tableView2;
@property(nonatomic,strong)UILabel* line1;              //竖线1
@property(nonatomic,strong)UILabel* line2;              //竖线2
@property(nonatomic,strong)UILabel* ling3;              //横线
@property(nonatomic,strong)UIButton* intentionBtn;      //职位意向按钮
@property(nonatomic,strong)UIButton* experienceBtn;     //工作经验按钮
@property(nonatomic,strong)UIButton* salaryBtn;         //期望薪资按钮

@property(nonatomic,strong)UILabel* intentionLabel;     //职位意向
@property(nonatomic,strong)UIImageView* intentionImage; //职位意向下拉箭头
@property(nonatomic,strong)UILabel* experienceLabel;    //工作经验
@property(nonatomic,strong)UIImageView* experienceImage;//工作经验下拉箭头
@property(nonatomic,strong)UILabel* salarLabel;         //期望薪资
@property(nonatomic,strong)UIImageView* salarImage;     //期望薪资下拉箭头
@property(nonatomic,strong)MbResumeDetailsViewController* resumeDetailVC;//简历详情页面

@property(nonatomic,strong)UIButton* btn1;
@property(nonatomic,strong)UIButton* btn2;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)NSArray* typeArray;         //职位类别
@property(nonatomic,strong)NSMutableArray* experienceArray;   //工作经验
@property(nonatomic,strong)NSMutableArray* moneyArray;        //薪资数组
@property(nonatomic,strong)NSArray* array1;
@property(nonatomic,strong)NSArray* array2;
@property(nonatomic,strong)NSArray* array3;
@property(nonatomic,strong)NSArray* array4;
@property(nonatomic,strong)NSArray* array5;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,assign)NSInteger tag1;
@property(nonatomic,strong)UITapGestureRecognizer *singleTap;
@property(nonatomic,strong)NSMutableArray* lists;      //获取数组
@property(nonatomic,strong)NSString* a;
@property(nonatomic,strong)NSString* b;
@property(nonatomic,strong)NSString* c;
@property(nonatomic,strong)NSMutableArray* positionList;
@property(nonatomic,assign)int freshCount;             //加载传值
@property(nonatomic,strong)NSDictionary* dictionary;   //临时保存数据

@end

@implementation MbSeeResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.freshCount = 2;
    self.title = [NSString stringWithFormat:@"看简历(%@)",self.cityName];
    
    self.a = @"";
    self.b = @"";
    self.c = @"";
    self.positionList = [NSMutableArray array];
    self.experienceArray = [NSMutableArray array];
    self.moneyArray = [NSMutableArray array];
    self.dictionary = [[NSDictionary alloc]init];
//    self.typeArray = @[@"企业/工程/管理",@"规划设计",@"市场/营销/运营",@"行政/资产/财务",@"证本类"];
//    self.experienceArray = @[@"无经验/应届生",@"1年以内",@"1~3年",@"3~5年",@"5~8年",@"10年以上"];
//    self.moneyArray = @[@"2000~3000/月",@"3000~5000/月",@"5000~8000/月",@"8000~12000/月",@"12000~20000/月",@"20000~40000/月",@"40000以上/月"];
//
//    
//    self.array1 = @[@"总经理/副总经理",@"企业总工程师",@"总监理工程师",@"项目经理",@"项目总工程师",@"经营经理",@"安全经理",@"质量/成本经理",@"合约/采购经理",@"预算/造价经理",@"审计/结算经理",@"土建工程师",@"市政工程师",@"给排水工程师",@"路桥隧工程师",@"水利水电工程师",@"园林绿化工程师",@"电器工程师",@"机电工程师",@"钢结构工程师",@"幕墙工程师",@"驻场监理员"];
//    self.array2 = @[@"院长/副院长",@"建筑主创/设计总监",@"总工程师",@"总规划师",@"规划经理",@"设计经理",@"结构经理",@"设备经理",@"建模/BIM经理",@"施工图设计师",@"房建设计师",@"室内设计师",@"园林景观设计师",@"结构设计师",@"给排水设计师",@"暖通设计师",@"电器设计师",@"市政设计师",@"路桥隧设计师",@"环保设计师",@"渲染员"];
//    self.array3 = @[@"市场总监",@"销售总监",@"招商总监",@"运营总监",@"市场经理",@"销售经理",@"招商经理",@"运营经理"];
//    self.array4 = @[@"行政资产财务",@"行政总监",@"资产运营总监",@"物业总监",@"投融资总监",@"行政经理",@"资产运营经理",@"物业经理",@"投融资经理",@"财务经理"];
//    self.array5 = @[@"建筑工程建造师",@"市政公用工程建造师",@"公路工程建造师",@"水利水电工程建造师",@"机电工程建造师",@"通信与广电工程建造师",@"铁路工程建造师",@"矿业工程建造师",@"民航机场建造师",@"港口与航道工程建造师",@"监理工程师",@"职称证/其他"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self onCreate];
    [self getMessage];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 47, viewWidth, viewHeight-109)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(freshDongtai)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(moreDongtai)];
//    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(freshDongtai)];
//    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(moreDongtai)];
//    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];;
    [self.tableView.mj_header beginRefreshing];
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];

}


//获取数据
-(void)getMessage{
    NSString* path = nil;
    if ([self.intentionLabel.text isEqualToString:@"意向职位"]&&[self.experienceLabel.text isEqualToString:@"工作经验"]&&[self.salarLabel.text isEqualToString:@"期望薪资"]) {
        path = [NSString stringWithFormat:@"%@?hasNext=1",seeresume];
    }else {
        path = [NSString stringWithFormat:@"%@?positioname=%@&suffer=%@&pay=%@&hasNext=1",seeresume,self.a,self.b,self.c];
       
    }
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",path);
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
    
    self.lists = [MbPaser paserSeeResumeByDic:dic];
       
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    }
//        NSString* path = seeresume;
//        NSString* encodedString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSURL *url = [NSURL URLWithString:encodedString];
//        NSURLRequest* request = [NSURLRequest requestWithURL:url];
//        NSURLSession* session = [NSURLSession sharedSession];
//        NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//    
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    
//            NSLog(@"%@",dic);
//      
//        }];
//        [task resume];
}
//应聘职位
-(void)getPosition{
    NSURL *url = [NSURL URLWithString:hopeposition];
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

//工作经验
-(void)getExperience{
    
    NSURL *url = [NSURL URLWithString:hopeexperience];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    self.experienceArray = [MbPaser paserExperienceByDic:dic];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView1 reloadData];
    });
    
    
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
//
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
        if ([self.intentionLabel.text isEqualToString:@"意向职位"]&&[self.experienceLabel.text isEqualToString:@"工作经验"]&&[self.salarLabel.text isEqualToString:@"期望薪资"]) {
            path = [NSString stringWithFormat:@"%@?hasNext=%d",seeresume,freshint];
       
        }else {
            path = [NSString stringWithFormat:@"%@?positioname=%@&suffer=%@&pay=%@&hasNext=%d",seeresume,self.a,self.b,self.c,freshint];
            path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        }
        
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
//            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//            NSString *fileName = [path stringByAppendingPathComponent:@"jianli.plist"];
//            NSLog(@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:fileName]);
//            self.lists = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
        
            self.lists = [MbPaser paserSeeResumeByDic:self.dictionary];
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
   
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
 
            self.lists = [MbPaser paserSeeResumeByDic:dic];
            self.dictionary = dic;
//            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//            NSString *fileName = [path stringByAppendingPathComponent:@"jianli.plist"];
//            
//            [self.lists writeToFile:fileName atomically:YES];
 
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }

    
    
    }
    
    
    
    /*
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        NSString*path=seeresume;
        NSInteger lastId = 0;
        if ((freshint != 0) && (self.lists.count != 0))
        {
            MbUserInfo *info = [self.lists lastObject];
            //lastId = [info.dynamicId integerValue];
        }
        NSDictionary *params = @{@"userId": [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"],@"lastId": [NSString stringWithFormat:@"%zd",lastId]};
        [manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([[dic objectForKey:@"status"]intValue]==1) {
                if (freshint==0) {
                    [self.lists removeAllObjects];
                }
                for (NSDictionary *dynamicDic in [dic objectForKey:@"dynamicList"]) {
                    MbUserInfo *info = [MbPaser paserSeeResumeByDic:dynamicDic];
    
                    [self.lists addObject:info];
    
                }
                [self.tableView.header endRefreshing];
                [self.tableView.footer endRefreshing];
                [self.tableView reloadData];
    
            }else{
                //whetherHasDongtai=@"no";
    
                if (freshint == 0)
                {
                    UIAlertView* av=[[UIAlertView alloc]initWithTitle:nil message:@"亲~你没有任何关注用户的动态，赶快在热度页多认识一些好友吧！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [av show];
                    [self performSelector:@selector(avDismiss:) withObject:av  afterDelay:2.0];
                }
    
                [self.tableView.header endRefreshing];
                [self.tableView.footer endRefreshing];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }];
    */
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
//初始化按钮
-(void)onCreate{

    //职位按钮
    self.intentionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth/3-0.5, 46)];
    self.intentionBtn.userInteractionEnabled = YES;
    [self.intentionBtn addTarget:self action:@selector(intention:) forControlEvents:UIControlEventTouchUpInside];
    self.intentionBtn.tag=1;
    [self.view addSubview:self.intentionBtn];
    //职位label
    self.intentionLabel = [[UILabel alloc]init];
    self.intentionLabel.text = @"职位意向";
    self.intentionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.intentionLabel.font = [UIFont systemFontOfSize:labelText+1];
    CGSize size1 = [self.intentionLabel.text sizeWithFont:self.intentionLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.intentionLabel.frame = CGRectMake(self.intentionBtn.frame.size.width/6, self.intentionBtn.frame.size.height/2-size1.height/2, size1.width, size1.height);
    [self.intentionBtn addSubview:self.intentionLabel];
    //职位下拉箭头
    self.intentionImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.intentionBtn.frame.size.width/1.3,self.intentionBtn.frame.size.height/2 - size1.width/12, size1.width/6, size1.width/6)];
    self.intentionImage.image = [UIImage imageNamed:@"home_arrow42_d.png"];
    [self.intentionBtn addSubview:self.intentionImage];
    //线1
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/3, 10, 1, 26)];
    self.line1.backgroundColor = [UIColor colorWithRed:57/255.0 green:141/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:self.line1];
    //地区按钮
    self.experienceBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/3+0.5, 0, viewWidth/3-1, 46)];
    self.experienceBtn.userInteractionEnabled = YES;
    [self.experienceBtn addTarget:self action:@selector(experience:) forControlEvents:UIControlEventTouchUpInside];
    self.experienceBtn.tag=2;
    [self.view addSubview:self.experienceBtn];
    
    //地区label
    self.experienceLabel = [[UILabel alloc]init];
    self.experienceLabel.text = @"工作经验";
    self.experienceLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.experienceLabel.font = [UIFont systemFontOfSize:labelText+1];
    CGSize size2 = [self.experienceLabel.text sizeWithFont:self.experienceLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.experienceLabel.frame = CGRectMake(self.experienceBtn.frame.size.width/6, self.experienceBtn.frame.size.height/2-size2.height/2, size2.width, size2.height);
    [self.experienceBtn addSubview:self.experienceLabel];
    //地区下拉箭头
    self.experienceImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.experienceBtn.frame.size.width/1.3,self.experienceBtn.frame.size.height/2 - size2.width/12, size2.width/6, size2.width/6)];
    self.experienceImage.image = [UIImage imageNamed:@"home_arrow42_d.png"];
    [self.experienceBtn addSubview:self.experienceImage];
    
    
    
    //线2
    self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/3*2-0.5, 10, 1, 26)];
    self.line2.backgroundColor = [UIColor colorWithRed:57/255.0 green:141/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:self.line2];
    //薪资按钮
    self.salaryBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/3*2+0.5, 0, viewWidth/3-0.5, 46)];
    self.salaryBtn.userInteractionEnabled = YES;
    [self.salaryBtn addTarget:self action:@selector(salary:) forControlEvents:UIControlEventTouchUpInside];
    self.salaryBtn.tag=3;
    [self.view addSubview:self.salaryBtn];
    
    //地区label
    self.salarLabel = [[UILabel alloc]init];
    self.salarLabel.text = @"期望薪资";
    self.salarLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.salarLabel.font = [UIFont systemFontOfSize:labelText+1];
    CGSize size3 = [self.salarLabel.text sizeWithFont:self.salarLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.salarLabel.frame = CGRectMake(self.salaryBtn.frame.size.width/6, self.salaryBtn.frame.size.height/2-size3.height/2, size3.width, size3.height);
    
    [self.salaryBtn addSubview:self.salarLabel];
    //地区下拉箭头
    self.salarImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.salaryBtn.frame.size.width/1.3,self.salaryBtn.frame.size.height/2 - size3.width/12, size3.width/6, size3.width/6)];
    self.salarImage.image = [UIImage imageNamed:@"home_arrow42_d.png"];
    [self.salaryBtn addSubview:self.salarImage];
    //横线
    self.ling3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.intentionBtn.frame), viewWidth, 1)];
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
            return self.experienceArray.count;
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
//            
//            return self.array3.count;
//        }else if (self.tag1==3){
//            return self.array4.count;
//        }else if (self.tag1==4){
//            
//            return self.array5.count;
//        }
        
    }

    return 0;

    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    MbSeeResumeTableViewCell* cell = nil;
    UITableViewCell* cell1 = nil;
    UITableViewCell* cell2 = nil;
    if (tableView==self.tableView) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifire];
        if (!cell) {
            cell = [[MbSeeResumeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            cell.delegate = self;
            return cell;
        }
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
            MbUserInfo* info = [self.experienceArray objectAtIndex:indexPath.row];
            
            cell1.textLabel.text = info.suffer;
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
        
//        cell2 = [self.tableView2 cellForRowAtIndexPath:indexPath];
//        if (!cell2) {
//            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
//        }
//        if (self.tag1==0) {
//            cell2.textLabel.text = [self.array1 objectAtIndex:indexPath.row];
//            
//        }else if (self.tag1==1){
//            
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
        self.resumeDetailVC = [[MbResumeDetailsViewController alloc]init];
        MbUserInfo* info = [self.lists objectAtIndex:indexPath.row];
        self.resumeDetailVC.info = info;
     
        [self.navigationController pushViewController:self.resumeDetailVC animated:YES];
    }else if (tableView==self.tableView1){
        self.tag1 = indexPath.row;
        self.btn1.hidden = YES;
        if (self.tag==1) {
      
            
            if (self.tag1==0) {
                
                
                [self create];
                
                
            }else if (self.tag1==1){
                
                [self create];
                
            }else if (self.tag1==2){
                
                [self create];
            }else if (self.tag1==3){
                [self create];
            }else if (self.tag1==4){
                [self create];
                
            }
        }else if (self.tag==2){
            MbUserInfo* info = [self.experienceArray objectAtIndex:indexPath.row];
            self.experienceLabel.text = info.suffer;
            self.b = info.suffer;
            self.experienceLabel.font = [UIFont systemFontOfSize:labelText];
            self.experienceLabel.textColor = [UIColor blackColor];
            [self.btn1 removeFromSuperview];
        }else if (self.tag==3){
            MbUserInfo* info = [self.moneyArray objectAtIndex:indexPath.row];
            self.salarLabel.text = info.pay;
            self.c = info.pay;
            self.salarLabel.font = [UIFont systemFontOfSize:labelText];
            self.salarLabel.textColor = [UIColor blackColor];
          [self.btn1 removeFromSuperview];
        }
    
    }else if (tableView==self.tableView2){
        MbUserInfo* info = [self.positionList objectAtIndex:self.tag1];
        NSDictionary* dic = [info.positionArray objectAtIndex:indexPath.row];
        
        NSString* string = [dic objectForKey:@"positioname"];
        self.intentionLabel.text = string;
        self.a = string;
        self.intentionLabel.textColor = [UIColor blackColor];

        
        [self.btn2 removeFromSuperview];
        [self getMessage];

//        if (self.tag1==0) {
//            
//            self.intentionLabel.text = [self.array1 objectAtIndex:indexPath.row];
//            self.intentionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.intentionLabel.textColor = [UIColor blackColor];
//            
//            
//        }else if (self.tag1==1){
//            
//            self.intentionLabel.text = [self.array2 objectAtIndex:indexPath.row];
//            self.intentionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.intentionLabel.textColor = [UIColor blackColor];
//            
//        }else if (self.tag1==2){
//            
//            self.intentionLabel.text = [self.array3 objectAtIndex:indexPath.row];
//            self.intentionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.intentionLabel.textColor = [UIColor blackColor];
//        }else if (self.tag1==3){
//            self.intentionLabel.text = [self.array4 objectAtIndex:indexPath.row];
//            self.intentionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.intentionLabel.textColor = [UIColor blackColor];
//        }else if (self.tag1==4){
//            self.intentionLabel.text = [self.array5 objectAtIndex:indexPath.row];
//            self.intentionLabel.font = [UIFont systemFontOfSize:labelText];
//            self.intentionLabel.textColor = [UIColor blackColor];
//            
//        }
        
        [self.btn2 removeFromSuperview];
    }
    
    [self getMessage];
}
-(void)create{
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn2.backgroundColor = [color colorWithAlphaComponent:0.5];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
    [self.btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    self.btn2.userInteractionEnabled = YES;
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
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 0, 0)];
    [button setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [button sizeToFit];
    
    button.frame = CGRectMake(20, CGRectGetMinY(self.titleLabel.frame) + 5, 30, 30);
    [button addTarget:self action:@selector(dismissBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addSubview:button];
    
    //列表
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth - 30, 240)];
    self.tableView2.dataSource = self;
    self.tableView2.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView2 reloadData];
    [self.btn2 addSubview:self.tableView2];
    
}

-(void)dismissBtn2{
    [self.btn2 removeFromSuperview];
    self.btn1.hidden = NO;
}

//职位意向按钮方法
-(void)intention:(UIButton*)sender{
    [self getPosition];
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
//工作经验按钮方法
-(void)experience:(UIButton*)sender{
    [self getExperience];
    self.tag = sender.tag;
  
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn1.backgroundColor = [color colorWithAlphaComponent:0.5];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
    self.btn1.userInteractionEnabled = YES;
        [self.btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];
    
    
    //标题
    self.titleLabel = [[UILabel alloc]init];
    
    self.titleLabel.text = @"工作经验";
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
//期望薪资按钮方法
-(void)salary:(UIButton*)sender{
    [self getSalary];
    self.tag = sender.tag;
  
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    self.btn1.userInteractionEnabled = YES;
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn1.backgroundColor = [color colorWithAlphaComponent:0.5];
        [self.btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
    
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
@end
