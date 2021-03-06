//
//  MbRecruitmentViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/28.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbRecruitmentViewController.h"
#import "JZQCommon.h"
@interface MbRecruitmentViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    CGSize textSize;
        CGSize textSize1;
        CGSize textSize2;

}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)UILabel* titleLabel;           //标题
@property(nonatomic,strong)UITextField* titleDetail;          //具体标题
@property(nonatomic,strong)UILabel* companyLabel;
@property(nonatomic,strong)UITextField* company;          //公司姓名

@property(nonatomic,strong)UILabel* jobIntention;         //职位类别
@property(nonatomic,strong)UIButton* type;                 //建造师
@property(nonatomic,strong)UILabel* region;               //区域
@property(nonatomic,strong)UIButton* workPlace;            //工作地点
@property(nonatomic,strong)UIButton* workBtn;
@property(nonatomic,strong)UILabel* worlPlaceLabel;
@property(nonatomic,strong)UITextField* placeField;       //输入工作岗位地址

@property(nonatomic,strong)UILabel* workingExperience;    //工作经验
@property(nonatomic,strong)UIButton* years;                //年限
@property(nonatomic,strong)UILabel* educationRequirement;  //学历要求
@property(nonatomic,strong)UIButton* education;            //学历


@property(nonatomic,strong)UILabel* salary;                //薪资
@property(nonatomic,strong)UIButton* money;                //工资

@property(nonatomic,strong)UILabel* jobRequirementsLabel;  //任职要求
@property(nonatomic,strong)UITextField* jobRequirements;

@property(nonatomic,strong)UILabel* companyProfileLabel;   //公司简介
@property(nonatomic,strong)UITextField* companyProfile;        //公司简介

@property(nonatomic,strong)UILabel* nameLabel;            //联系人
@property(nonatomic,strong)UITextField* name;

@property(nonatomic,strong)UILabel* telephone;            //电话
@property(nonatomic,strong)UITextField* telephoneNumber;      //电话号码
@property(nonatomic,strong)UILabel* confidential;         //保密

@property(nonatomic,strong)UILabel* selfIntroduction;     //自我介绍
@property(nonatomic,strong)UILabel* introduction;         //具体介绍
@property(nonatomic,strong)UIButton* releaseBtn;          //发布按钮
@property(nonatomic,strong)UILabel* line1;                //竖线
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UILabel* line5;
@property(nonatomic,strong)UILabel* line6;
@property(nonatomic,strong)UILabel* line7;
@property(nonatomic,strong)UILabel* line8;
@property(nonatomic,strong)UILabel* line9;
@property(nonatomic,strong)UILabel* line10;
@property(nonatomic,strong)UILabel* line11;
@property(nonatomic,strong)UILabel* line12;

@property(nonatomic,strong)UILabel* horizontal1;                //横线
@property(nonatomic,strong)UILabel* horizontal2;
@property(nonatomic,strong)UILabel* horizontal3;
@property(nonatomic,strong)UILabel* horizontal4;
@property(nonatomic,strong)UILabel* horizontal5;
@property(nonatomic,strong)UILabel* horizontal6;
@property(nonatomic,strong)UILabel* horizontal7;
@property(nonatomic,strong)UILabel* horizontal8;
@property(nonatomic,strong)UILabel* horizontal9;
@property(nonatomic,strong)UILabel* horizontal10;
@property(nonatomic,strong)UILabel* horizontal11;
@property(nonatomic,strong)UILabel* horizontal12;

@property(nonatomic,strong)UIButton* downBtn;             //向下的箭头
@property(nonatomic,strong)UILabel* antiHarassmentLabel;  //防骚扰
@property(nonatomic,strong)UIButton* antiHarassmentBtn;   //防骚扰按钮

@property(nonatomic,strong)UIButton* zhizhao;             //直招
@property(nonatomic,strong)UIButton* daizhao;             //代招
@property(nonatomic,strong)UILabel* text;
@property(nonatomic,strong)UIButton* btn1;                 //
@property(nonatomic,strong)UIButton* btn2;
@property(nonatomic,strong)NSArray* moneyArray;           //薪资数组
@property(nonatomic,strong)NSArray* workArray;            //工作年限
@property(nonatomic,strong)NSArray* jobs;                 //职位类别
@property(nonatomic,strong)NSArray* xueli;                //学历数组
@property(nonatomic,strong)NSArray* array1;
@property(nonatomic,strong)NSArray* array2;
@property(nonatomic,strong)NSArray* array3;
@property(nonatomic,strong)NSArray* array4;
@property(nonatomic,strong)NSArray* array5;
@property(nonatomic,strong)UILabel* titleLa;
@property(nonatomic,strong)UITableView* tableView1;
@property(nonatomic,strong)UITableView* tableView2;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,assign)NSInteger tag1;
@property(nonatomic,strong)NSString* userid;
@property(nonatomic,strong)NSMutableDictionary* dic;     //暂时保存的数据
@property(nonatomic,strong)NSString* zhao;
@property(nonatomic,strong)NSMutableArray* positionList;
@property(nonatomic,strong)NSMutableArray* placeList;
@property(nonatomic,strong)NSMutableArray* experienceList;
@property(nonatomic,strong)NSMutableArray* educationList;
@property(nonatomic,strong)NSMutableArray* salaryList;
@end

@implementation MbRecruitmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = [NSString stringWithFormat:@"填写招聘信息(%@)",self.cityName];
    self.view.backgroundColor = [UIColor whiteColor];
  
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    self.positionList = [NSMutableArray array];
    self.placeList = [NSMutableArray array];
    self.experienceList = [NSMutableArray array];
    self.educationList = [NSMutableArray array];
    self.salaryList = [NSMutableArray array];
    self.moneyArray = @[@"2000~3000",@"3000~5000",@"5000~8000",@"8000~12000",@"12000~20000",@"20000~40000",@"40000以上/月"];
    //self.xueli = @[@"初中及以下",@"高中/技校/中专",@"大专",@"本科",@"硕士及以上"];
    //self.workArray = @[@"无经验/应届",@"1年以下",@"1~3年",@"3~5年",@"5~8年",@"10年以上"];
    //self.jobs = @[@"企业/工程/管理",@"规划设计",@"市场/营销/运营",@"行政/资产/财务",@"证本类"];
    //self.array1 = @[@"总经理/副总经理",@"企业总工",@"总监工程师",@"项目经理",@"项目总工程师",@"经营管理",@"安全经理",@"质量经理",@"成本经理",@"合约经理",@"采购经理",@"预算造价经理",@"审计结算经理",@"土建工程师",@"市政工程师",@"给排水工程师",@"水利水电工程师",@"园林工程师",@"电器工程师",@"环保工程师",@"机电工程师",@"钢结构工程师",@"幕墙工程师",@"驻场监理",@"施工员",@"安全员",@"质检员",@"资料员",@"材料员",@"测量员",@"机械员",@"标准员",@"会计",@"出纳"];
    //self.array2 = @[@"院长副院长",@"建筑师设计总监",@"总工程师",@"总规划师",@"规划经理",@"设计经理",@"结构经理",@"BIM经理",@"规划师建筑主创",@"施工图设计师",@"室内设计师",@"园林景观设计师",@"结构设计师",@"给排水设计师",@"暖通设计师",@"电器设计师",@"市政设计师",@"路桥隧设计师",@"环保设计师",@"建模员",@"渲染员"];
    //self.array3 = @[@"市场总监",@"销售总监",@"招商总监",@"运营总监",@"市场经理",@"销售经理"];
    //self.array4 = @[@"市政资产财务",@"行政总监",@"资产运营总监",@"物业总监",@"投融资总监",@"财务总监",@"行政经理",@"运营经理"];
    //self.array5 = @[@"证本类",@"建筑工程",@"市政公用工程",@"公路工程",@"水利水电工程",@"几点工程",@"通信与广电工程",@"铁路工程",@"矿业工程",@"民航机场",@"港口与航道工程",@"职称证/其他",@"简历工程师"];
    
    self.text = [UILabel new];
    self.text.text = @"测试详情";
    self.text.font = [UIFont systemFontOfSize:labelText];
    textSize = [self.text.text sizeWithFont:self.text.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.jobRequirements = [[UILabel alloc]init];
    self.jobRequirements.text = @"本人对待工作认真负责，善于沟通、协商，参与管理过3000万的市政工程管理程管理";
    self.jobRequirements.font = [UIFont systemFontOfSize:labelText];
    textSize1 = [self.jobRequirements.text sizeWithFont:self.jobRequirements.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    
    self.companyProfile = [[UITextField alloc]init];
    self.companyProfile.text = @"浙江建设广发银行浙江建设广发银行浙江建设广发银行浙江建设广发银行浙江建设广发银行浙江建设广发银行";
    self.companyProfile.font = [UIFont systemFontOfSize:labelText];
    textSize2 = [self.companyProfile.text sizeWithFont:self.companyProfile.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    [self onCreate];
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-27) style:UITableViewStyleGrouped];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    [self.tableView reloadData];
//    [self.view addSubview:self.tableView];
    
    
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

//地区
//-(void)getPlace{
//    NSURL *url = [NSURL URLWithString:hopeplace];
//    //第二步，创建请求
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
//    NSString *str = @"type=focus-c";//设置参数
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:data];
//    //第三步，连接服务器
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
//    self.placeList = [MbPaser paserPlaceByDic:dic];
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tableView1 reloadData];
//    });
//  
//}
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
    self.experienceList = [MbPaser paserExperienceByDic:dic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView1 reloadData];
    });
    
    
}

//学历
-(void)getEducation{
    NSURL *url = [NSURL URLWithString:hopeeducation];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    self.educationList = [MbPaser paserEducationByDic:dic];
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
    self.salaryList = [MbPaser paserSalaryByDic:dic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView1 reloadData];
    });
    
    
}

-(void)onCreate{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    //标题
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"       标题";
    self.titleLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:labelText];
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.titleLabel.frame = CGRectMake(15, 15, titleSize.width, titleSize.height);
    [self.scrollView addSubview:self.titleLabel];
    
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+15, 10, 1, self.titleLabel.frame.size.height+10)];
    self.line1.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    
    [self.scrollView addSubview:self.line1];
    
    self.titleDetail = [[UITextField alloc]init];
    self.titleDetail.placeholder = @"请填写招聘的信息";
    self.titleDetail.delegate = self;
    self.titleDetail.returnKeyType = UIReturnKeyDone;
    self.titleDetail.font = [UIFont systemFontOfSize:labelText];
  
    self.titleDetail.frame = CGRectMake(CGRectGetMaxX(self.line1.frame)+15, 15, viewWidth-61-titleSize.width, titleSize.height);
    [self.titleDetail setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.titleDetail setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    self.titleDetail.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.scrollView addSubview:self.titleDetail];
    //横线1
    self.horizontal1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+15, viewWidth, 0.5)];
    self.horizontal1.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal1];
    
    //公司名称
    self.companyLabel = [UILabel new];
    self.companyLabel.text = @"公司名称";
    self.companyLabel.font = [UIFont systemFontOfSize:labelText];
    self.companyLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    CGSize companyLabelSize = [self.companyLabel.text sizeWithFont:self.companyLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.companyLabel.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal1.frame) + 15, companyLabelSize.width, companyLabelSize.height);
//    [self.scrollView addSubview:self.companyLabel];
    
    
    self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.companyLabel.frame)+15, CGRectGetMaxY(self.horizontal1.frame) + 10, 1, self.companyLabel.frame.size.height+10)];
    self.line2.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
//    [self.scrollView addSubview:self.line2];
    //
    self.company = [[UITextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.horizontal1.frame) + 10, viewWidth/3, companyLabelSize.height+10)];
    self.company.delegate = self;
    self.company.returnKeyType = UIReturnKeyDone;
    self.company.font = [UIFont systemFontOfSize:labelText];
    self.company.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.company.placeholder = @"请填写公司名称";
    [self.company setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.company setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    self.company.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    
    
    [self.scrollView addSubview:self.company];
    //直招按钮
    self.zhizhao = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-self.companyLabel.frame.size.width/2*3-15, CGRectGetMaxY(self.horizontal1.frame) + 9, self.companyLabel.frame.size.width/4*3, companyLabelSize.height+12)];
    [self.zhizhao setTitle:@"直招" forState:UIControlStateNormal];
    [self.zhizhao setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.zhizhao setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    [self.zhizhao setBackgroundImage:[UIImage imageNamed:@"kuangz"] forState:UIControlStateNormal];
    [self.zhizhao setBackgroundImage:[UIImage imageNamed:@"kuangd"] forState:UIControlStateSelected];
    //[self.zhizhao setFont:[UIFont systemFontOfSize:labelText]];
    self.zhizhao.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.zhizhao.selected = YES;
    self.zhao=@"1";
    [self.zhizhao addTarget:self action:@selector(zhizhao:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.zhizhao];
    //代招按钮
    self.daizhao = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.zhizhao.frame), CGRectGetMaxY(self.horizontal1.frame) + 9, self.companyLabel.frame.size.width/4*3, companyLabelSize.height+12)];
    [self.daizhao setTitle:@"代招" forState:UIControlStateNormal];
    [self.daizhao setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.daizhao setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] forState:UIControlStateNormal];
    [self.daizhao setBackgroundImage:[UIImage imageNamed:@"kuangy"] forState:UIControlStateNormal];
    [self.daizhao setBackgroundImage:[UIImage imageNamed:@"kuangd"] forState:UIControlStateSelected];
    //        [self.daizhao setFont:[UIFont systemFontOfSize:labelText]];
    self.daizhao.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.daizhao addTarget:self action:@selector(daizhao:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.daizhao];

    
    //横线2
    self.horizontal2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.companyLabel.frame)+15, viewWidth, 0.5)];
    self.horizontal2.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal2];
    
    
    //类别职位
    self.jobIntention = [[UILabel alloc]init];
    self.jobIntention.text = @"类别职位";
    self.jobIntention.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.jobIntention.font = [UIFont systemFontOfSize:labelText];
    CGSize jobIntentionSize = [self.jobIntention.text sizeWithFont:self.jobIntention.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.jobIntention.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal2.frame) + 15, jobIntentionSize.width, jobIntentionSize.height);
//    [self.scrollView addSubview:self.jobIntention];
    
    self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.horizontal2.frame) + 10, 1, self.jobIntention.frame.size.height+10)];
    self.line3.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
//    [self.scrollView addSubview:self.line3];
    
    
    
    self.type = [[UIButton alloc]init];
    [self.type setTitle:@"请选择招聘职位" forState:UIControlStateNormal];
    self.type.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.type.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.type setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forState:UIControlStateNormal];
    [self.type addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.type.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal2.frame) + 15, viewWidth- textSize.width - 80 , textSize.height);
    self.type.tag=1;
    [self.scrollView addSubview:self.type];
    
    
    //        self.type = [[UILabel alloc]init];
    //        self.type.text = @"建造师";
    //        self.type.font = [UIFont systemFontOfSize:labelText];
    //        self.type.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    //        CGSize typeSize = [self.type.text sizeWithFont:self.type.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    //        self.type.frame = CGRectMake(CGRectGetMaxX(self.line3.frame)+15, 15, typeSize.width, typeSize.height);
    //        [cell addSubview:self.type];
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-35, self.type.frame.origin.y + self.type.frame.size.height/8, self.type.frame.size.height/4*3, self.type.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    
    self.downBtn.tag = 1;
    [self.scrollView addSubview:self.downBtn];

    
    //横线3
    self.horizontal3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.jobIntention.frame)+15, viewWidth, 0.5)];
    self.horizontal3.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal3];
    
    //区域
    self.region = [[UILabel alloc]init];
    self.region.text = @"       区域";
    self.region.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.region.font = [UIFont systemFontOfSize:labelText];
    CGSize regionSize = [self.region.text sizeWithFont:self.region.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.region.frame = CGRectMake(15,CGRectGetMaxY(self.horizontal3.frame) + 15, regionSize.width, regionSize.height);
    [self.scrollView addSubview:self.region];
    
  
    
    self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.region.frame)+15, CGRectGetMaxY(self.horizontal3.frame) + 10, 1, self.region.frame.size.height+10)];
    self.line4.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line4];
    
    self.workPlace = [[UIButton alloc]init];
    [self.workPlace setTitle:@"地区" forState:UIControlStateNormal];
      self.workPlace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.workPlace.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.workPlace setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forState:UIControlStateNormal];
    CGSize workPlaceSize = [self.workPlace.titleLabel.text sizeWithFont:self.workPlace.titleLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.workPlace.frame = CGRectMake(CGRectGetMaxX(self.line4.frame)+15, CGRectGetMaxY(self.horizontal3.frame) + 15, viewWidth- textSize.width - 80, workPlaceSize.height);
    [self.workPlace addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.workPlace.tag = 2;
    [self.scrollView addSubview:self.workPlace];
    
    
    
    
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-35, self.workPlace.frame.origin.y + self.workPlace.frame.size.height/8, self.workPlace.frame.size.height/4*3, self.workPlace.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 2;
    [self.scrollView addSubview:self.downBtn];
    

    
    
    
    //横线4
    self.horizontal4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.region.frame)+15, viewWidth, 0.5)];
    self.horizontal4.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal4];
    
    
    //工作地点
    self.worlPlaceLabel = [[UILabel alloc]init];
    self.worlPlaceLabel.text = @"工作地点";
    self.worlPlaceLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.worlPlaceLabel.font = [UIFont systemFontOfSize:labelText];
    CGSize worlPlaceLabelSize = [self.worlPlaceLabel.text sizeWithFont:self.worlPlaceLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.worlPlaceLabel.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal4.frame) + 15, worlPlaceLabelSize.width, worlPlaceLabelSize.height);
    [self.scrollView addSubview:self.worlPlaceLabel];
    
    
    //
    self.line5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.worlPlaceLabel.frame)+15, CGRectGetMaxY(self.horizontal4.frame) + 10, 1, self.worlPlaceLabel.frame.size.height+10)];
    self.line5.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line5];
    
    //输入岗位工作地址
    self.placeField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line5.frame)+15, CGRectGetMaxY(self.horizontal4.frame) + 10, viewWidth-61-workPlaceSize.width, self.line5.frame.size.height)];
    self.placeField.textColor = [UIColor blackColor];
    self.placeField.delegate =self;
    self.placeField.returnKeyType = UIReturnKeyDone;
    self.placeField.font = [UIFont systemFontOfSize:labelText];
    self.placeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.placeField.placeholder = @"请输入岗位工作地址";
    [self.placeField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.placeField setValue:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.scrollView addSubview:self.placeField];
    
    
    //横线5
    self.horizontal5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.worlPlaceLabel.frame)+15, viewWidth, 0.5)];
    self.horizontal5.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal5];
    
    //经验要求
    self.workingExperience = [[UILabel alloc]init];
    self.workingExperience.text = @"工作经验";
    self.workingExperience.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.workingExperience.font = [UIFont systemFontOfSize:labelText];
    CGSize workingExperienceSize = [self.workingExperience.text sizeWithFont:self.workingExperience.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.workingExperience.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal5.frame) + 15, workingExperienceSize.width, workingExperienceSize.height);
    [self.scrollView addSubview:self.workingExperience];
    
    self.line6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workingExperience.frame)+15, CGRectGetMaxY(self.horizontal5.frame) + 10, 1, self.workingExperience.frame.size.height+10)];
    self.line6.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line6];
    
    self.years = [[UIButton alloc]init];
    [self.years setTitle:@"请选择经验要求" forState:UIControlStateNormal];
    self.years.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.years.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.years setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forState:UIControlStateNormal];
    [self.years addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.years.frame = CGRectMake(CGRectGetMaxX(self.line6.frame)+15, CGRectGetMaxY(self.horizontal5.frame) + 15, viewWidth- textSize.width - 80 , textSize.height);
    self.years.tag = 3;
    [self.scrollView addSubview:self.years];
    
    
    //        self.years.text = @"3-5年";
    //        self.years.font = [UIFont systemFontOfSize:labelText];
    //        self.years.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    //        CGSize yearsSize = [self.years.text sizeWithFont:self.years.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    //        self.years.frame = CGRectMake(CGRectGetMaxX(self.line6.frame)+15, 15, yearsSize.width, yearsSize.height);
    //        [cell addSubview:self.years];
    
    
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-35, self.years.frame.origin.y + self.years.frame.size.height/8, self.years.frame.size.height/4*3, self.years.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag=3;
    [self.scrollView addSubview:self.downBtn];

    
    
    //横线6
    self.horizontal6 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.workingExperience.frame)+15, viewWidth, 0.5)];
    self.horizontal6.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal6];
    
    
    //学历要求
    self.educationRequirement = [[UILabel alloc]init];
    self.educationRequirement.text = @"学历要求";
    self.educationRequirement.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.educationRequirement.font = [UIFont systemFontOfSize:labelText];
    CGSize educationRequirementSize = [self.educationRequirement.text sizeWithFont:self.educationRequirement.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.educationRequirement.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal6.frame) + 15, educationRequirementSize.width, educationRequirementSize.height);
    [self.scrollView addSubview:self.educationRequirement];
    
    self.line7 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.educationRequirement.frame)+15, CGRectGetMaxY(self.horizontal6.frame) + 10, 1, self.educationRequirement.frame.size.height+10)];
    self.line7.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line7];
    
    
    
    self.education = [[UIButton alloc]init];
    [self.education setTitle:@"请选择学历要求" forState:UIControlStateNormal];
    self.education.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.education.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.education setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forState:UIControlStateNormal];
    [self.education addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.education.frame = CGRectMake(CGRectGetMaxX(self.line7.frame)+15, CGRectGetMaxY(self.horizontal6.frame) + 15, viewWidth- textSize.width - 80 , textSize.height);
    self.education.tag = 4;
    [self.scrollView addSubview:self.education];
    
    
    //        self.education = [[UILabel alloc]init];
    //        self.education.text = @"建造师/项目经理";
    //        self.education.font = [UIFont systemFontOfSize:labelText];
    //        self.education.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    //        CGSize educationSize = [self.education.text sizeWithFont:self.education.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    //        self.education.frame = CGRectMake(CGRectGetMaxX(self.line7.frame)+15, 15, educationSize.width, educationSize.height);
    //        [cell addSubview:self.education];
    
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-35, self.education.frame.origin.y+self.education.frame.size.height/8, self.education.frame.size.height/4*3, self.education.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 4;
    [self.scrollView addSubview:self.downBtn];
    
    
    //横线7
    self.horizontal7 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.educationRequirement.frame)+15, viewWidth, 0.5)];
    self.horizontal7.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal7];
    
    
    
    //薪资待遇
    self.salary = [[UILabel alloc]init];
    self.salary.text = @"薪资待遇";
    self.salary.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.salary.font = [UIFont systemFontOfSize:labelText];
    CGSize salarySize = [self.salary.text sizeWithFont:self.salary.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.salary.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal7.frame) + 15, salarySize.width, salarySize.height);
    [self.scrollView addSubview:self.salary];
    
    self.line8 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.salary.frame)+15, CGRectGetMaxY(self.horizontal7.frame) + 10, 1, self.salary.frame.size.height+10)];
    self.line8.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line8];
    
    
    
    self.money = [[UIButton alloc]init];
    [self.money setTitle:@"请选择薪资待遇" forState:UIControlStateNormal];
    self.money.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.money.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.money setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1] forState:UIControlStateNormal];
    [self.money addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.money.frame = CGRectMake(CGRectGetMaxX(self.line8.frame)+15, CGRectGetMaxY(self.horizontal7.frame) + 15, viewWidth- textSize.width - 80 , textSize.height);
    self.money.tag = 5;
    [self.scrollView addSubview:self.money];
    
    
    
    //        self.money = [[UILabel alloc]init];
    //        self.money.text = @"3000-5000元/月";
    //        self.money.font = [UIFont systemFontOfSize:labelText];
    //        self.money.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    //        CGSize moneySize = [self.money.text sizeWithFont:self.money.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    //        self.money.frame = CGRectMake(CGRectGetMaxX(self.line7.frame)+15, 15, moneySize.width, moneySize.height);
    //        [cell addSubview:self.money];
    
    
    //向下箭头
    self.downBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-35, self.money.frame.origin.y+self.money.frame.size.height/8, self.money.frame.size.height/4*3, self.money.frame.size.height/4*3)];
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"home_arrow42_d.png"] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.tag = 5;
    [self.scrollView addSubview:self.downBtn];

    
    
    //横线8
    self.horizontal8 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.salary.frame)+15, viewWidth, 0.5)];
    self.horizontal8.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal8];
    
    
    //任职要求
    self.jobRequirementsLabel = [UILabel new];
    self.jobRequirementsLabel.text = @"任职要求";
    self.jobRequirementsLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.jobRequirementsLabel.font = [UIFont systemFontOfSize:labelText];
    CGSize jobRequirementsLabelSize = [self.jobRequirementsLabel.text sizeWithFont:self.jobRequirementsLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.jobRequirementsLabel.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal8.frame) + 15, jobRequirementsLabelSize.width, jobRequirementsLabelSize.height);
    [self.scrollView addSubview:self.jobRequirementsLabel];
    
    
    //任职要求介绍
    self.jobRequirements = [UITextField new];
    self.jobRequirements.placeholder = @"请描述工作职责等等";
    self.jobRequirements.delegate = self;
    self.jobRequirements.returnKeyType = UIReturnKeyDone;
    self.jobRequirements.font = [UIFont systemFontOfSize:labelText];
    self.jobRequirements.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    //self.jobRequirements.numberOfLines = 0;
    //根据控件大小改变字体大小
    //self.introduction.adjustsFontSizeToFitWidth = YES;
    
    //        CGSize jobRequirementsSize = [self.jobRequirements.text sizeWithFont:self.jobRequirements.font constrainedToSize:CGSizeMake(viewWidth-61-jobRequirementsLabelSize.width, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    //        if (jobRequirementsLabelSize.height>jobRequirementsSize.height+15) {
    //            self.line9 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jobRequirementsLabel.frame)+15, 10, 1, jobRequirementsLabelSize.height+10)];
    //        }else{
    //            self.line9 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jobRequirementsLabel.frame)+15, 10, 1, jobRequirementsSize.height+10)];
    //        }
    self.line9 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jobRequirementsLabel.frame)+15, CGRectGetMaxY(self.horizontal8.frame) + 10, 1, jobRequirementsLabelSize.height+10)];
    self.line9.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line9];
    
    
    
    self.jobRequirements.frame = CGRectMake(CGRectGetMaxX(self.line9.frame)+15, CGRectGetMaxY(self.horizontal8.frame) + 15, viewWidth-61-jobRequirementsLabelSize.width, jobRequirementsLabelSize.height);
    [self.scrollView addSubview:self.jobRequirements];
    

    //横线9
    self.horizontal9 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.jobRequirementsLabel.frame)+15, viewWidth, 0.5)];
    self.horizontal9.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal9];
    
    
    //公司简介
    self.companyProfileLabel = [UILabel new];
    self.companyProfileLabel.text = @"公司简介";
    self.companyProfileLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.companyProfileLabel.font = [UIFont systemFontOfSize:labelText];
    CGSize companyProfileLabelSize = [self.companyProfileLabel.text sizeWithFont:self.companyProfileLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.companyProfileLabel.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal9.frame) + 15, companyProfileLabelSize.width, companyProfileLabelSize.height);
    [self.scrollView addSubview:self.companyProfileLabel];
    
    
    //任职要求介绍
    self.companyProfile = [UITextField new];
    self.companyProfile.placeholder = @"请介绍贵公司的基本情况";
    self.companyProfile.delegate = self;
    self.companyProfile.returnKeyType = UIReturnKeyDone;
    self.companyProfile.font = [UIFont systemFontOfSize:labelText];
    self.companyProfile.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    //self.companyProfile.numberOfLines = 0;
    //根据控件大小改变字体大小
    //self.introduction.adjustsFontSizeToFitWidth = YES;
    
    //        CGSize companyProfileSize = [self.companyProfile.text sizeWithFont:self.companyProfile.font constrainedToSize:CGSizeMake(viewWidth-61-companyProfileLabelSize.width, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    //
    //        if (companyProfileLabelSize.height>companyProfileSize.height+15) {
    //            self.line10 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.companyProfileLabel.frame)+15, 10, 1, companyProfileLabelSize.height+10)];
    //        }else{
    //            self.line10 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.companyProfileLabel.frame)+15, 10, 1, companyProfileSize.height+10)];
    //
    //        }
    self.line10 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.companyProfileLabel.frame)+15, CGRectGetMaxY(self.horizontal9.frame) + 10, 1, companyProfileLabelSize.height+10)];
    self.line10.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line10];
    
    self.companyProfile.frame = CGRectMake(CGRectGetMaxX(self.line10.frame)+15, CGRectGetMaxY(self.horizontal9.frame) + 15, viewWidth-61-companyProfileLabelSize.width, companyProfileLabelSize.height);
    [self.scrollView addSubview:self.companyProfile];

    
    
    //横线10
    self.horizontal10 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.companyProfileLabel.frame)+15, viewWidth, 0.5)];
    self.horizontal10.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal10];
    
    
    //联系人
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"   联系人";
    self.nameLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.nameLabel.font = [UIFont systemFontOfSize:labelText];
    CGSize nameLabelSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.nameLabel.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal10.frame) + 15, nameLabelSize.width, nameLabelSize.height);
    [self.scrollView addSubview:self.nameLabel];
    
    self.line11 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+15, CGRectGetMaxY(self.horizontal10.frame) + 10, 1, self.nameLabel.frame.size.height+10)];
    self.line11.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line11];
    
    self.name = [[UITextField alloc]init];
    self.name.placeholder = @"请填写姓名";
    self.name.delegate = self;
    self.name.returnKeyType = UIReturnKeyDone;
    self.name.font = [UIFont systemFontOfSize:labelText];
    self.name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.name.delegate = self;
    self.name.frame = CGRectMake(CGRectGetMaxX(self.line11.frame)+15, CGRectGetMaxY(self.horizontal10.frame) + 15, viewWidth/5*3, nameLabelSize.height);
    [self.scrollView addSubview:self.name];
    
    
    //横线11
    self.horizontal11 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame)+15, viewWidth, 0.5)];
    self.horizontal11.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal11];
    
    
    
    //电话
    self.telephone = [[UILabel alloc]init];
    self.telephone.text = @"       电话";
    self.telephone.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
    self.telephone.font = [UIFont systemFontOfSize:labelText];
    CGSize telephoneSize = [self.telephone.text sizeWithFont:self.telephone.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.telephone.frame = CGRectMake(15, CGRectGetMaxY(self.horizontal11.frame) + 15, telephoneSize.width, telephoneSize.height);
    [self.scrollView addSubview:self.telephone];
    
    self.line12 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+15, CGRectGetMaxY(self.horizontal11.frame) + 10, 1, self.telephone.frame.size.height+10)];
    self.line12.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [self.scrollView addSubview:self.line12];
    
    self.telephoneNumber = [[UITextField alloc]init];
    self.telephoneNumber.placeholder = @"请填写手机或固话";
    self.telephoneNumber.delegate = self;
    self.telephoneNumber.returnKeyType = UIReturnKeyDone;
    self.telephoneNumber.font = [UIFont systemFontOfSize:labelText];
    self.telephoneNumber.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.telephoneNumber.delegate = self;
    self.telephoneNumber.frame = CGRectMake(CGRectGetMaxX(self.line12.frame)+15, CGRectGetMaxY(self.horizontal11.frame) + 15, viewWidth/5*2, telephoneSize.height);
    [self.scrollView addSubview:self.telephoneNumber];
    
    //防骚扰按钮
    
    self.antiHarassmentLabel = [[UILabel alloc]init];
    self.antiHarassmentLabel.text = @"防骚扰";
    self.antiHarassmentLabel.font = [UIFont systemFontOfSize:labelText];
    CGSize anSize = [self.antiHarassmentLabel.text sizeWithFont:self.antiHarassmentLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    self.antiHarassmentLabel.frame = CGRectMake(viewWidth-15-anSize.width, CGRectGetMaxY(self.horizontal11.frame) + 15, anSize.width, anSize.height);
    [self.scrollView addSubview:self.antiHarassmentLabel];
    
    
    self.antiHarassmentBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-30-anSize.width-anSize.height, CGRectGetMaxY(self.horizontal11.frame) + 13, anSize.height+4, anSize.height+4)];
    [self.antiHarassmentBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
    [self.antiHarassmentBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co_col.png"] forState:UIControlStateSelected];
    self.antiHarassmentBtn.selected = YES;
    [self.antiHarassmentBtn addTarget:self action:@selector(anselete:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.antiHarassmentBtn];
    
    
    
    //横线12
    self.horizontal12 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.telephone.frame)+15, viewWidth, 0.5)];
    self.horizontal12.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:self.horizontal12];
    
    
    
    //发布按钮
    self.releaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/4, CGRectGetMaxY(self.horizontal12.frame) + 15, viewWidth/2, 40)];
    //[self.releaseBtn setBackgroundColor:[UIColor colorWithRed:52/255.0 green:142/255.0 blue:221/255.0 alpha:1]];
    [self.releaseBtn setBackgroundImage:[UIImage imageNamed:@"home_7_btn.png"] forState:UIControlStateNormal];
    [self.releaseBtn setBackgroundImage:[UIImage imageNamed:@"home_7_btn_col.png"] forState:UIControlStateSelected];
    [self.releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.releaseBtn addTarget:self action:@selector(release:) forControlEvents:UIControlEventTouchUpInside];
    
    self.releaseBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.releaseBtn.layer.cornerRadius = 20;
    self.releaseBtn.layer.masksToBounds = YES;
    
    
    [self.scrollView addSubview:self.releaseBtn];
     self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.releaseBtn.frame)+15);
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

  if (tableView==self.tableView1){
        if (self.tag==1) {
            return self.positionList.count;
        }else if (self.tag==2){
        return self.placeList.count;
        
        }else if (self.tag==3){
            return self.experienceList.count;
        
        }else if (self.tag==4){
        
            return self.educationList.count;
        }else if (self.tag==5){
        
        return self.salaryList.count;
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
    UITableViewCell* cell = nil;
   if (tableView==self.tableView1){
    cell = [self.tableView1 cellForRowAtIndexPath:indexPath];
        
    }
  
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        
    }
    
//    if (tableView==self.tableView) {
//        
//     cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (indexPath.row==0) {
//       
//    }else if (indexPath.row==1){
//        
//    }else if (indexPath.row==2){
//        
//        
//    }else if (indexPath.row==3){
//       
//
//        
//        
//    }else if (indexPath.row==4){
//        
//        
//        
//    }else if (indexPath.row==5){
//        
//        
//    }else if (indexPath.row==6){
//        
//        
//       
//    }else if (indexPath.row==7){
//        
//        
//        
//        
//    }else if (indexPath.row==8){
//        
//        
//    }else if (indexPath.row==9){
//        
//        
//        
//    }else if (indexPath.row==10){
//        
//        
//        
//    }else if (indexPath.row==11){
//           }
//    
//    }else
        if (tableView==self.tableView1){
        if (self.tag==1) {
            MbUserInfo* info = [self.positionList objectAtIndex:indexPath.row];
            cell.textLabel.text = info.positioname;
        
        }else if (self.tag==2){
            MbUserInfo* info = [self.placeList objectAtIndex:indexPath.row];
            cell.textLabel.text = info.name;
            
        }else if (self.tag==3){
            MbUserInfo* info = [self.experienceList objectAtIndex:indexPath.row];
            cell.textLabel.text = info.suffer;
         
            
        }else if (self.tag==4){
            MbUserInfo* info = [self.educationList objectAtIndex:indexPath.row];
            cell.textLabel.text = info.diploma;
     
        }else if (self.tag==5){
           MbUserInfo* info =  [self.salaryList objectAtIndex:indexPath.row];
            cell.textLabel.text = info.pay;
            
        }

        
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (tableView==self.tableView2){
        cell = [self.tableView2 cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        }
        MbUserInfo* info = [self.positionList objectAtIndex:self.tag1];
        NSDictionary* dic = [info.positionArray objectAtIndex:indexPath.row];
        
        
        
        cell.textLabel.text = [dic objectForKey:@"positioname"];
//        if (self.tag1==0) {
//            cell.textLabel.text = [self.array1 objectAtIndex:indexPath.row];
//            
//        }else if (self.tag1==1){
//            
//            cell.textLabel.text = [self.array2 objectAtIndex:indexPath.row];
//        }else if (self.tag1==2){
//            cell.textLabel.text = [self.array3 objectAtIndex:indexPath.row];
//        }else if (self.tag1==3){
//            cell.textLabel.text = [self.array4 objectAtIndex:indexPath.row];
//        }else if (self.tag1==4){
//            cell.textLabel.text = [self.array5 objectAtIndex:indexPath.row];
//        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:labelText];
        
        
    }

    
    //分割线顶头
    //[cell setSeparatorInset:UIEdgeInsetsZero];
    //[cell setLayoutMargins:UIEdgeInsetsZero];
    //[cell setPreservesSuperviewLayoutMargins:NO];
    //无选中状态
    cell.textLabel.font = [UIFont systemFontOfSize:labelText];
   
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.00001;
    }else
        return 0.000001;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    if (tableView==self.tableView1) {
        
        if (self.tag==1) {
            self.tag1 = indexPath.row;
            [self.btn1 removeFromSuperview];
            [self create];
            
        }else if (self.tag==2){
            MbUserInfo* info = [self.placeList objectAtIndex:indexPath.row];
            [self.workPlace setTitle:info.name forState:UIControlStateNormal];
            [self.workPlace setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }else if (self.tag==3){
 
            MbUserInfo* info = [self.experienceList objectAtIndex:indexPath.row];
            [self.years setTitle:info.suffer forState:UIControlStateNormal];
            [self.years setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }else if (self.tag==4){
 
            MbUserInfo* info = [self.educationList objectAtIndex:indexPath.row];
            [self.education setTitle:info.diploma forState:UIControlStateNormal];
            [self.education setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else if (self.tag==5){
 
            MbUserInfo* info = [self.salaryList objectAtIndex:indexPath.row];
            [self.money setTitle:info.pay forState:UIControlStateNormal];
            [self.money setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }

        
        [self.btn1 removeFromSuperview];
       
    }else if (tableView==self.tableView2){
        
        
        MbUserInfo* info = [self.positionList objectAtIndex:self.tag1];
        NSDictionary* dic = [info.positionArray objectAtIndex:indexPath.row];
        
        NSString* string = [dic objectForKey:@"positioname"];
        [self.type setTitle:string forState:UIControlStateNormal];
        [self.type setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        

        
        [self.btn2 removeFromSuperview];
    }
    self.tableView.scrollEnabled = YES;

}

-(void)create{
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    //图层透明，控件不透明
    UIColor *color = [UIColor blackColor];
    self.btn2.backgroundColor = [color colorWithAlphaComponent:0.5];
    //    self.view1.backgroundColor = [UIColor blackColor];
    //    self.view1.alpha = 0.7;
    self.btn2.userInteractionEnabled = YES;
    [self.btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn2];
    
    UIView* view3 = [[UIView alloc]initWithFrame:CGRectMake(15, (viewHeight - 344)/2, viewWidth - 30, 40)];
    view3.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
    [self.btn2 addSubview:view3];
    
    //标题
    self.titleLabel = [[UILabel alloc]init];
    
    self.titleLabel.text = @"职位类别";
    //self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.frame = CGRectMake((viewWidth-30)/4, 0, (viewWidth - 30)/2, 40);
    [view3 addSubview:self.titleLabel];
    
    UIButton* cancle = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
//    [cancle setTitle:@"返回" forState:UIControlStateNormal];
    [cancle setBackgroundImage:[UIImage imageNamed:@"nav_back@2x.png"] forState:UIControlStateNormal];
//    [cancle setBackgroundColor:[UIColor greenColor]];
    [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancle.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [cancle addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:cancle];
    
    //列表
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(view3.frame), viewWidth - 30, 240)];
    self.tableView2.dataSource = self;
    self.tableView2.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView2 reloadData];
    [self.btn2 addSubview:self.tableView2];
    
}

-(void)cancle:(UIButton*)sender{
    [self.btn2 removeFromSuperview];
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
   
        self.titleLabel.text = @"职位类别";
        [self getPosition];
    
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
    
    
    
    [self.titleDetail resignFirstResponder];
    [self.company resignFirstResponder];
    [self.placeField resignFirstResponder];
    [self.jobRequirements resignFirstResponder];
    [self.companyProfile resignFirstResponder];
    [self.telephoneNumber resignFirstResponder];

}

//直招
-(void)zhizhao:(UIButton*)sender{
    self.zhao=@"1";
    if (sender.selected==YES) {
        self.zhizhao.selected=YES;
    }else{
        sender.selected = !sender.selected;
        self.daizhao.selected = !self.daizhao.selected;
    }

}
//代招
-(void)daizhao:(UIButton*)sender{
    self.zhao=@"2";
    if (sender.selected==YES) {
    self.zhizhao.selected=YES;
    }else{
        sender.selected = !sender.selected;
        self.zhizhao.selected = !self.zhizhao.selected;
    }

}
//发布
-(void)release:(UIButton*)sender{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag = 200;
        [alertView show];
    }else if (self.titleDetail.text.length==0||self.company.text.length==0||self.placeField.text.length==0||self.jobRequirements.text.length==0||self.companyProfile.text.length==0||self.name.text.length==0){
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    
    }else if (self.titleDetail.text.length>10||self.company.text.length>20||self.placeField.text.length>15||self.jobRequirements.text.length>100||self.companyProfile.text.length>100||self.name.text.length>6){
        if (self.titleDetail.text.length>10) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"标题长度不能超过10" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (self.company.text.length>20){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司名称长度不能超过20" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (self.placeField.text.length>15){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"工作地点长度不能超过15" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        
        }else if (self.jobRequirements.text.length>100){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"任职要求字数不能超过100" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        
        }else if (self.companyProfile.text.length>100){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司简介字数不能超过100" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else if (self.name.text.length>6){
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"姓名字数不能超过6" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        
        }
    }else{

    
    [MbPaser sendResumeRecruitByUserid:self.userid title:self.titleDetail.text company:self.company.text ways:self.zhao position:self.type.titleLabel.text area:self.workPlace.titleLabel.text address:self.placeField.text experience:self.years.titleLabel.text diploma:self.education.titleLabel.text wages:self.money.titleLabel.text demand:self.jobRequirements.text aboutus:self.companyProfile.text linkman:self.name.text phone:self.telephoneNumber.text result:^(RecruitSaveResponse *response, NSError *error) {
       
        if (response.turn == 200) {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 200;
            [alert show];
        }else{
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }

        
        
    }];
    
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==200) {
        [self.navigationController popViewControllerAnimated:YES];
    }


}
//向下箭头
-(void)down:(UIButton*)sender{
    
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
    if (sender.tag==1) {
    self.titleLabel.text = @"职位类别";
        [self getPosition];
    }else if (sender.tag==2){
    self.titleLabel.text = @"地区";
        [self getPlace];
    }else if (sender.tag==3){
            self.titleLabel.text = @"工作经验";
        [self getExperience];
    }else if (sender.tag==4){
            self.titleLabel.text = @"教育程度";
        [self getEducation];
    }else if (sender.tag==5){
            self.titleLabel.text = @"薪资待遇";
        [self getSalary];
    }
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
    
    
    
    [self.titleDetail resignFirstResponder];
    [self.company resignFirstResponder];
    [self.placeField resignFirstResponder];
    [self.jobRequirements resignFirstResponder];
    [self.companyProfile resignFirstResponder];
    [self.telephoneNumber resignFirstResponder];
}

//防骚扰
-(void)anselete:(UIButton*)sender{
    sender.selected = !sender.selected;

}
//删除弹出图层
//-(void)remove:(UITapGestureRecognizer*)tap{
//    [self.view1 removeFromSuperview];
//}
-(void)btn1:(UIButton*)sender{
    [self.btn1 removeFromSuperview];
 self.tableView.scrollEnabled = YES;
}
-(void)btn2:(UIButton*)sender{
    [self.btn2 removeFromSuperview];
 self.tableView.scrollEnabled = YES;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    [self.titleDetail resignFirstResponder];
     [self.company resignFirstResponder];
     [self.placeField resignFirstResponder];
     [self.jobRequirements resignFirstResponder];
     [self.companyProfile resignFirstResponder];
     [self.telephoneNumber resignFirstResponder];

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==self.telephoneNumber) {
        return [self validateNumber:string];
    }else
        return YES;
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark 触摸屏幕回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark textfield收起键盘方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    if ([self.titleDetail isEditing]||[self.company isEditing]||[self.placeField isEditing]) {
        
    }else{
    
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.20];
    [UIView setAnimationBeginsFromCurrentState: YES];
    self.scrollView.frame = CGRectMake(self.view.frame.origin.x, self.scrollView.frame.origin.y - 216, self.scrollView.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
        
    }
}

//- (void)textFieldDidChange:(UITextField *)textField
//{
//    
//    if (textField == self.titleDetail) {
//        if (textField.text.length > 10) {
//            textField.text = [textField.text substringToIndex:10];
//        }
//    }else if (textField == self.company){
//        
//        if (textField.text.length > 20) {
//            textField.text = [textField.text substringToIndex:20];
//        }
//        
//    }else if (textField == self.placeField){
//        
//        if (textField.text.length > 15) {
//            textField.text = [textField.text substringToIndex:15];
//        }
//        
//    }else if (textField == self.jobRequirements){
//    
//        if (textField.text.length > 100) {
//            textField.text = [textField.text substringToIndex:100];
//        }
//    }else if (textField == self.companyProfile){
//        if (textField.text.length > 100) {
//            textField.text = [textField.text substringToIndex:100];
//        }
//    
//    }else if (textField == self.name){
//        if (textField.text.length > 6) {
//            textField.text = [textField.text substringToIndex:6];
//        }
//    
//    }
//}

#pragma mark 编辑之后frame弹回
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.scrollView.frame.origin.y!=0) {
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.20];
        [UIView setAnimationBeginsFromCurrentState: YES];
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y + 216, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [UIView commitAnimations];
    }
    
   
}

@end
