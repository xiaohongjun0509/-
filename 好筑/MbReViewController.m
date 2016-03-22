//
//  MbReViewController.m
//  好筑
//
//  Created by tusm on 15/12/7.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbReViewController.h"
#import "JZQCommon.h"
#import "MbFindWorkTableViewCell.h"
#import "MbSeeResumeTableViewCell.h"
#import "MbEnterpriseTableViewCell.h"
#import "MJRefresh.h"
#import "MbWorkDetailsViewController.h"
#import "MbResumeDetailsViewController.h"
#import "MbEnterpriseDetailViewController.h"
@interface MbReViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UISegmentedControl* segment;
@property (nonatomic,strong)UIScrollView* scrollView;
@property (strong,nonatomic)UIView* buttonView;
@property (strong,nonatomic)NSMutableArray* buttons;
@property (strong,nonatomic)UIButton* temp;
@property (strong,nonatomic)UIView* view1;
@property (strong,nonatomic)UIButton* btn1;            //找工作
@property (strong,nonatomic)UIButton* btn2;            //看简历
@property (strong,nonatomic)UIButton* btn3;            //企业通
@property (strong,nonatomic)NSString* userid;
@property (strong,nonatomic)NSMutableArray* lists1;
@property (strong,nonatomic)NSMutableArray* lists2;
@property (strong,nonatomic)NSMutableArray* lists3;
@property (strong,nonatomic)MbWorkDetailsViewController* workDetailsVC;
@property (strong,nonatomic)MbResumeDetailsViewController* resumeDetailVC;
@property (strong,nonatomic)MbEnterpriseDetailViewController* detailVC;
@property (nonatomic,strong)NSDictionary* dictionary1;
@property (nonatomic,strong)NSDictionary* dictionary2;
@property (nonatomic,strong)NSDictionary* dictionary3;
@property (nonatomic,assign)int freshCount1;             //加载传值
@property (nonatomic,assign)int freshCount2;             //加载传值
@property (nonatomic,assign)int freshCount3;             //加载传值
@property (nonatomic,strong)UIButton* backBtn;           //弹出的背景按钮
@property (nonatomic,strong)UILabel* titleLabel;         //提示
@property (nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)NSArray* array;

@end

@implementation MbReViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的发布";
    self.freshCount1 = 2;
    self.freshCount2 = 2;
    self.freshCount3 = 2;
    self.array = @[@"置顶",@"删除"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    self.lists1 = [NSMutableArray alloc];
    self.lists2 = [NSMutableArray alloc];
    self.lists3 = [NSMutableArray alloc];
    self.dictionary1 = [[NSDictionary alloc]init];
    self.dictionary2 = [[NSDictionary alloc]init];
    self.dictionary3 = [[NSDictionary alloc]init];
    [self initWithButton];
    [self initWithSecondView];

    [self getMessage1];
    [self getMessage2];
    [self getMessage3];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}
-(void)getMessage1{
       NSURL *url = [NSURL URLWithString:myfindwork];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = [NSString stringWithFormat:@"userid=%@",self.userid];//设置参数
   
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
 
    self.dictionary1 = dic;
    NSArray* array = [dic objectForKey:@"data"];
    if (array.count==0) {
        
        self.lists1 = nil;
        [self.tableView1 reloadData];
    }else{
    self.lists1 = [MbPaser paserMyFindWorkByDic:dic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView1 reloadData];
    });
    }

}
-(void)getMessage2{
    NSURL *url = [NSURL URLWithString:myseeresume];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = [NSString stringWithFormat:@"userid=%@",self.userid];//设置参数
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];

    self.dictionary2 = dic;
    NSArray* array = [dic objectForKey:@"data"];
    if (array.count==0) {
        self.lists2 = nil;
        [self.tableView2 reloadData];
    }else{
    
    self.lists2 = [MbPaser paserMySeeResumeByDic:dic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView2 reloadData];
       
    });
    }
    
}
-(void)getMessage3{
    NSURL *url = [NSURL URLWithString:myenterpriseList];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = [NSString stringWithFormat:@"userid=%@",self.userid];//设置参数
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    self.dictionary3 = dic;
    NSArray* array = [dic objectForKey:@"data"];
    if (array.count==0) {
        self.lists3 = nil;
        [self.tableView3 reloadData];
    }else{
    self.lists3 = [MbPaser paserMyEnterpriseByDic:dic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView3 reloadData];
    });
    }
    
}
-(void)initWithButton{
    
    //找工作
    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth/3, 46)];
    self.btn1.selected = YES;
    [self.btn1 setTitle:@"找工作" forState:UIControlStateNormal];
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.btn1.layer.borderWidth = 1;
    self.btn1.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor colorWithRed:0 green:193/255.0 blue:72/255.0 alpha:1] forState:UIControlStateSelected];
    //[self.btn1 setBackgroundColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"home_6_co1l.png"] forState:UIControlStateSelected];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"home_6_tab1.png"] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.tag = 0;
    [self.view addSubview:self.btn1];
    
//    UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/3-1, 5, 2, 36)];
//    label1.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
//    [self.btn1 addSubview:label1];
    
    
    //看简历
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/3, 0, viewWidth/3, 46)];
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:labelText];
   
    self.btn2.layer.borderWidth = 1;
    self.btn2.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    [self.btn2 setTitle:@"看简历" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor colorWithRed:0 green:193/255.0 blue:72/255.0 alpha:1] forState:UIControlStateSelected];
    //[self.btn2 setBackgroundColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"home_6_co1l.png"] forState:UIControlStateSelected];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"home_6_tab1.png"] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    self.btn2.tag = 2;
    [self.view addSubview:self.btn2];
  
    //企业通
    self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/3*2, 0, viewWidth/3, 46)];
    self.btn3.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.btn3 setTitle:@"企业通" forState:UIControlStateNormal];
    self.btn3.layer.borderWidth = 1;
    self.btn3.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor colorWithRed:0 green:193/255.0 blue:72/255.0 alpha:1] forState:UIControlStateSelected];
    //[self.btn3 setBackgroundColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"home_6_co1l.png"] forState:UIControlStateSelected];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"home_6_tab1.png"] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn3 addTarget:self action:@selector(btn3:) forControlEvents:UIControlEventTouchUpInside];
    self.btn3.tag = 3;
    [self.view addSubview:self.btn3];
    //三个按钮下边的横线
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btn1.frame), viewWidth, 1)];
    label.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1];
    
    [self.view addSubview:label];
    
    
    
//    self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 46)];
//    self.buttonView.backgroundColor = [UIColor whiteColor];
//    self.buttonView.layer.borderColor = [UIColor colorWithRed:76/255.0 green:154/255.0 blue:218/255.0 alpha:1].CGColor;
//    self.buttonView.layer.borderWidth = 1;
//    [self.view addSubview:self.buttonView];
//    
//    //背景图
//    self.view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.buttonView.frame.size.width / 3, self.buttonView.frame.size.height)];
//    self.view1.backgroundColor = [UIColor colorWithRed:43/255.0 green:223/255.0 blue:252/255.0 alpha:1];
//    [self.buttonView addSubview:self.view1];
//    
//    self.buttons =[NSMutableArray array];
//    NSArray *names =@[@"找工作",@"看简历",@"企业通"];
//    
//    for (int i =0; i < 3; i++)
//    {
//        self.temp =[UIButton buttonWithType:UIButtonTypeCustom];
//        self.temp.tag = i;
//        if (i == 0)
//        {
//          
//            self.temp.selected =YES;
//        }
//        self.temp.titleLabel.numberOfLines = 0;
//        self.temp.frame =CGRectMake(self.buttonView.frame.size.width/3 * i, 1, self.buttonView.frame.size.width / 3, 46);
//
//        self.temp.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [self.temp setTitle:names[i] forState:UIControlStateNormal];
//        self.temp.titleLabel.font = [UIFont systemFontOfSize:labelText - 2];
//        [self.temp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.temp setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        self.temp.tag = i;
//        [self.temp addTarget:self action:@selector(changed:) forControlEvents:UIControlEventTouchUpInside];
//        [self.buttonView addSubview:self.temp];
//        
//        [self.buttons addObject:self.temp];
//    }
    
    
}

#pragma makr 初始化视图
-(void)initWithSecondView
{
    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 47, viewWidth, self.view.frame.size.height - 64-47)];
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 3, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, self.scrollView.frame.size.height - self.buttonView.frame.size.height)];
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth, 0, viewWidth, self.scrollView.frame.size.height - self.buttonView.frame.size.height)];
    self.tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth * 2, 0, viewWidth, self.scrollView.frame.size.height - self.buttonView.frame.size.height)];
    
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreDongtai1)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshDongtai1)];
    [self.tableView1.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreDongtai2)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshDongtai2)];
    [self.tableView2.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreDongtai3)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshDongtai3)];
    [self.tableView3.mj_header beginRefreshing];
    
    [self.scrollView addSubview:self.tableView1];
    [self.scrollView addSubview:self.tableView2];
    [self.scrollView addSubview:self.tableView3];
    
    
    [self.view addSubview:self.scrollView];
}

-(void)freshDongtai1{
    [self requestDongtaiByIntOne:1];
}
-(void)moreDongtai1{
    [self requestDongtaiByIntOne:self.freshCount1];
    self.freshCount1++;
}
-(void)freshDongtai2{
    [self requestDongtaiByIntTwo:1];
}
-(void)moreDongtai2{
    [self requestDongtaiByIntTwo:self.freshCount2];
    self.freshCount2++;
}
-(void)freshDongtai3{
    [self requestDongtaiByIntThree:1];
}
-(void)moreDongtai3{
    [self requestDongtaiByIntThree:self.freshCount3];
    self.freshCount3++;
}
-(void)requestDongtaiByIntOne:(int)freshint{
    [self.tableView1.header endRefreshing];
    [self.tableView1.footer endRefreshing];
    if (freshint==1) {
        [self getMessage1];
    }else if(freshint>1){
        NSURL *url = [NSURL URLWithString:myfindwork];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str = [NSString stringWithFormat:@"userid=%@&hasNext=%d",self.userid,freshint];//设置参数
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];

        NSArray* array = [dic objectForKey:@"data"];
        if (array.count==0) {
            
            
            self.lists1 = [MbPaser paserMyFindWorkByDic:self.dictionary1];
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView1 reloadData];
            });
        }else{
            
            self.lists1 = [MbPaser paserMyFindWorkByDic:dic];
            self.dictionary1 = dic;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView1 reloadData];
            });
        }
        
        
        
    }

    
}
-(void)requestDongtaiByIntTwo:(int)freshint{

    [self.tableView2.header endRefreshing];
    [self.tableView2.footer endRefreshing];
    if (freshint==1) {
        [self getMessage2];
       
    }else if(freshint>1){
        NSURL *url = [NSURL URLWithString:myseeresume];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str = [NSString stringWithFormat:@"userid=%@&hasNext=%d",self.userid,freshint];//设置参数
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];

        NSArray* array = [dic objectForKey:@"data"];
        if (array.count==0) {
            
            
            self.lists2 = [MbPaser paserMySeeResumeByDic:self.dictionary2];
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView2 reloadData];
            });
        }else{
            
            self.lists2 = [MbPaser paserMySeeResumeByDic:dic];
            self.dictionary2 = dic;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView2 reloadData];
                
            });
        }
        
        
        
    }

  
    
    
    
}

-(void)requestDongtaiByIntThree:(int)freshint{

    if (freshint==1) {
        [self getMessage1];
    }else if(freshint>1){
        NSURL *url = [NSURL URLWithString:myenterpriseList];
        //第二步，创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str = [NSString stringWithFormat:@"userid=%@&hasNext=%d",self.userid,freshint];//设置参数
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        //第三步，连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];

        NSArray* array = [dic objectForKey:@"data"];
        if (array.count==0) {
            
            
            self.lists3 = [MbPaser paserMyFindWorkByDic:self.dictionary3];
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView3 reloadData];
            });
        }else{
            
            self.lists3 = [MbPaser paserMyEnterpriseByDic:dic];
            self.dictionary3 = dic;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView3 reloadData];
            });
        }
        
        
        
    }
    [self.tableView3.header endRefreshing];
    [self.tableView3.footer endRefreshing];
    
    
}
#pragma mark 图的偏移量
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView == scrollView)
    {
        if (scrollView.contentOffset.x/viewWidth==0) {
            self.btn1.selected = YES;
            self.btn2.selected = NO;
            self.btn3.selected = NO;
            [self getMessage1];
        }else if (scrollView.contentOffset.x/viewWidth==1){
        
            self.btn2.selected = YES;
            self.btn1.selected = NO;
            self.btn3.selected = NO;
            [self getMessage2];
        }else if (scrollView.contentOffset.x/viewWidth==2){
            self.btn3.selected = YES;
            self.btn1.selected = NO;
            self.btn2.selected = NO;
            [self getMessage3];
        }
        self.view1.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x/3, 0);
        
    }
    
}
#pragma mark 字体颜色
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollView == scrollView)
    {
        for (UIButton *temp in self.buttons)
        {
            if (temp.selected ==YES)
            {
                temp.selected =NO;
            }
            int x1 = temp.frame.origin.x;
            int x2 = scrollView.contentOffset.x/3;
            
            if (x1 == x2)
            {
                temp.selected =YES;
            }
        }
    }
}
-(void)btn1:(UIButton*)sender{
    sender.selected=!sender.selected;
    if (self.btn1.selected==YES) {
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
    }
    self.btn1 = sender;
    self.btn1.selected = !self.btn1.selected;
    self.scrollView.contentOffset = CGPointMake(sender.frame.origin.x * 3, 0);
    [self getMessage1];
}
-(void)btn2:(UIButton*)sender{
     sender.selected=!sender.selected;
    if (self.btn2.selected==YES) {
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
    }
   
    self.btn2 = sender;
    self.btn2.selected = !self.btn2.selected;
    self.scrollView.contentOffset = CGPointMake(sender.frame.origin.x * 3, 0);
    [self getMessage2];
}
-(void)btn3:(UIButton*)sender{
   sender.selected=!sender.selected;
    if (self.btn3.selected==YES) {
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
    }
    
    self.btn3 = sender;
    self.btn3.selected = !self.btn3.selected;
     self.scrollView.contentOffset = CGPointMake(sender.frame.origin.x * 3, 0);
    [self getMessage3];
}
-(void)changed:(UIButton*)sender{
  
    for (UIButton *temp in self.buttons)
    {
        if (temp.selected ==YES)
        {
            temp.selected =NO;
        }
    }
    sender.selected =YES;
    self.scrollView.contentOffset = CGPointMake(sender.frame.origin.x * 3, 0);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableView1) {
        return self.lists1.count;
    }else if (tableView==self.tableView2){
        return self.lists2.count;
    
    }else if (tableView==self.tableView3){
        return self.lists3.count;
    }else if (tableView==self.tableView){
        return self.array.count;
    }
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    MbFindWorkTableViewCell* cell1 = nil;
    MbSeeResumeTableViewCell* cell2 = nil;
    MbEnterpriseTableViewCell* cell3 = nil;
    UITableViewCell* cell4 = nil;
    if (tableView == self.tableView1) {
        
        cell1 = [self.tableView1 dequeueReusableCellWithIdentifier:cellID];
 
        if (!cell1)
        {
            cell1 = [[MbFindWorkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell1.delegate = self;
        }
        MbUserInfo* info = [self.lists1 objectAtIndex:indexPath.row];
        [cell1 loadContent:info];
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap1:)];
//        longPress.minimumPressDuration = 3;
        [cell1 addGestureRecognizer:longPress];
         return cell1;
    }else if (tableView == self.tableView2){
        
        cell2 = [self.tableView2 dequeueReusableCellWithIdentifier:cellID];
        if (!cell2){
            cell2 = [[MbSeeResumeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell2.delegate = self;
        }
        MbUserInfo* info = [self.lists2 objectAtIndex:indexPath.row];
        [cell2 loadContent:info];
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap2:)];
        //        longPress.minimumPressDuration = 3;
        [cell2 addGestureRecognizer:longPress];
         return cell2;
    }else if (tableView == self.tableView3){
        
        cell3 = [self.tableView3 dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell3){
            
            cell3 = [[MbEnterpriseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell3.delegate = self;
        }
        MbUserInfo* info = [self.lists3 objectAtIndex:indexPath.row];
        [cell3 loadContent:info];
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap3:)];
        //        longPress.minimumPressDuration = 3;
        [cell3 addGestureRecognizer:longPress];
        return cell3;
    }else if (tableView == self.tableView){
    
        cell4 = [self.tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell4) {
            cell4 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        cell4.textLabel.text = [self.array objectAtIndex:indexPath.row];
        cell4.textLabel.font = [UIFont systemFontOfSize:labelText];
        return cell4;
    }
  
    return cell1;
}
//招聘信息上的手势
-(void)longTap1:(UILongPressGestureRecognizer *)longRecognizer
{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [longRecognizer locationInView:self.tableView1];
        NSIndexPath* indexPath = [_tableView1 indexPathForRowAtPoint:point];
        self.info = [self.lists1 objectAtIndex:indexPath.row];
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
        //图层透明，控件不透明
        UIColor *color = [UIColor blackColor];
        self.backBtn.backgroundColor = [color colorWithAlphaComponent:0.5];
        self.backBtn.userInteractionEnabled = YES;
        [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.backBtn];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = @"请选择";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:labelText];
        self.titleLabel.frame = CGRectMake(15, self.backBtn.frame.size.height/2 - 66, viewWidth-30, 44);
        [self.backBtn addSubview:self.titleLabel];
        
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth-30, 88)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView reloadData];
        [self.backBtn addSubview:self.tableView];
        
//        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定删除这条信息吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//               alertView.tag = indexPath.row;
//        [alertView show];
    }
}
//简历信息上的手势
-(void)longTap2:(UILongPressGestureRecognizer *)longRecognizer
{
    
 

    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [longRecognizer locationInView:self.tableView2];
        NSIndexPath* indexPath = [_tableView2 indexPathForRowAtPoint:point];
   self.info = [self.lists2 objectAtIndex:indexPath.row];
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
        //图层透明，控件不透明
        UIColor *color = [UIColor blackColor];
        self.backBtn.backgroundColor = [color colorWithAlphaComponent:0.5];
        self.backBtn.userInteractionEnabled = YES;
        [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.backBtn];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = @"请选择";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:labelText];
        self.titleLabel.frame = CGRectMake(15, self.backBtn.frame.size.height/2 - 66, viewWidth-30, 44);
        [self.backBtn addSubview:self.titleLabel];
        
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth-30, 88)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView reloadData];
        [self.backBtn addSubview:self.tableView];
        
//        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定删除这条信息吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", @"刷新",nil];
//        alertView.tag = indexPath.row;
//        [alertView show];
    }
}
//企业通信息上的手势
-(void)longTap3:(UILongPressGestureRecognizer *)longRecognizer
{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [longRecognizer locationInView:self.tableView3];
        NSIndexPath* indexPath = [_tableView3 indexPathForRowAtPoint:point];
        self.info = [self.lists3 objectAtIndex:indexPath.row];
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
        //图层透明，控件不透明
        UIColor *color = [UIColor blackColor];
        self.backBtn.backgroundColor = [color colorWithAlphaComponent:0.5];
        self.backBtn.userInteractionEnabled = YES;
        [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.backBtn];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = @"请选择";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:labelText];
        self.titleLabel.frame = CGRectMake(15, self.backBtn.frame.size.height/2 - 66, viewWidth-30, 44);
        [self.backBtn addSubview:self.titleLabel];
        
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth-30, 88)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView reloadData];
        [self.backBtn addSubview:self.tableView];
        
//        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定删除这条信息吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alertView.tag = indexPath.row;
//        [alertView show];
    }
}
//删除我的发布
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if (buttonIndex==0) {
     

        
        
    }else if (buttonIndex==1){
        if (self.scrollView.contentOffset.x/viewWidth==0) {
            MbUserInfo* info  =[self.lists1 objectAtIndex:alertView.tag];
         
            [MbPaser sendMyReleaseRecruitDeleteByUserid:self.userid recruitmenid:info.recruitmenid result:^(MyReleaseRecruitDeleteResponse *response, NSError *error) {
                if (response) {
                    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
  
                    [alertView show];
                    [self getMessage1];
                }
            }];
            
        }else if (self.scrollView.contentOffset.x/viewWidth==1){
            MbUserInfo* info = [self.lists2 objectAtIndex:alertView.tag];
            [MbPaser sendMyReleaseResumeDeleteByUserid:self.userid resumeid:info.resumeid result:^(MyReleaseResumeDeleteResponse *response, NSError *error) {
                if (response) {
                    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    [self getMessage2];
                }

            }];
            
        }else if (self.scrollView.contentOffset.x/viewWidth==2){
            MbUserInfo* info = [self.lists3 objectAtIndex:alertView.tag];
            [MbPaser sendMyReleaseEnterpriseDeleteByUserid:self.userid companyid:info.companyid result:^(MyReleaseEnterpriseDeleteResponse *response, NSError *error) {
                if (response) {
                    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    [self getMessage3];
                }

            }];
            
        }
    
    }



}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView3) {
        CGFloat cellHeight = 0.0f;
        MbEnterpriseTableViewCell *cell = (MbEnterpriseTableViewCell *)[self tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath];
        cellHeight = cell.finalH;
        
        return cellHeight;
    }else if (tableView==self.tableView){
        return 44;
    
    }
    return (viewHeight-110)/6;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView1) {
        self.workDetailsVC = [[MbWorkDetailsViewController alloc]init];
        MbUserInfo* info = [self.lists1 objectAtIndex:indexPath.row];
        self.workDetailsVC.info = info;
        [self.navigationController pushViewController:self.workDetailsVC animated:YES];
    }else if (tableView==self.tableView2){
        self.resumeDetailVC = [[MbResumeDetailsViewController alloc]init];
        MbUserInfo* info = [self.lists2 objectAtIndex:indexPath.row];
        self.resumeDetailVC.info = info;
        
        [self.navigationController pushViewController:self.resumeDetailVC animated:YES];
    
    }else if (tableView==self.tableView3){
    
        self.detailVC = [[MbEnterpriseDetailViewController alloc]init];
        MbUserInfo* info = [self.lists3 objectAtIndex:indexPath.row];
        self.detailVC.info = info;
        [self.navigationController pushViewController:self.detailVC animated:YES];
    }else if (tableView==self.tableView){
        if (indexPath.row==0) {
            [self.backBtn removeFromSuperview];
            
            if (self.scrollView.contentOffset.x/viewWidth==0) {
                
                MbUserInfo* info  =[self.lists1 objectAtIndex:indexPath.row];
            
 
                [MbPaser sendMyReleaseRecruitRefreshByRecruitmenid:self.info.recruitmenid result:^(MyReleaseRecruitRefreshResponse *response, NSError *error) {
                    if (response) {
                        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                        [self getMessage1];
                    }
                }];
                
                
            }else if (self.scrollView.contentOffset.x/viewWidth==1){
                MbUserInfo* info = [self.lists2 objectAtIndex:indexPath.row];
             
                [MbPaser sendMyReleaseResumeRefreshByResumeid:self.info.resumeid result:^(MyReleaseResumeRefreshResponse *response, NSError *error) {
                    if (response) {
                        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                        [self getMessage2];
                    }
                }];
            }else if (self.scrollView.contentOffset.x/viewWidth==2){
                MbUserInfo* info = [self.lists3 objectAtIndex:indexPath.row];
                [MbPaser sendMyReleaseEnterpriseRefreshByUserid:self.userid companyid:self.info.companyid result:^(MyReleaseEnterpriseRefreshResponse *response, NSError *error) {
                    if (response) {
                        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                        [self getMessage3];
                    }
                }];
            }
        }else if (indexPath.row==1){
        
            [self.backBtn removeFromSuperview];
            
            if (self.scrollView.contentOffset.x/viewWidth==0) {
                MbUserInfo* info  =[self.lists1 objectAtIndex:indexPath.row];
                
                [MbPaser sendMyReleaseRecruitDeleteByUserid:self.userid recruitmenid:info.recruitmenid result:^(MyReleaseRecruitDeleteResponse *response, NSError *error) {
                    if (response) {
                        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        
                        [alertView show];
                        [self getMessage1];
                    }
                }];
                
            }else if (self.scrollView.contentOffset.x/viewWidth==1){
                MbUserInfo* info = [self.lists2 objectAtIndex:indexPath.row];
                [MbPaser sendMyReleaseResumeDeleteByUserid:self.userid resumeid:info.resumeid result:^(MyReleaseResumeDeleteResponse *response, NSError *error) {
                    if (response) {
                        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        
                        [alertView show];
                        [self getMessage2];
                    }
                    
                }];
                
            }else if (self.scrollView.contentOffset.x/viewWidth==2){
                MbUserInfo* info = [self.lists3 objectAtIndex:indexPath.row];
                [MbPaser sendMyReleaseEnterpriseDeleteByUserid:self.userid companyid:info.companyid result:^(MyReleaseEnterpriseDeleteResponse *response, NSError *error) {
                    if (response) {
                        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        
                        [alertView show];
                        [self getMessage3];
                    }
                    
                }];
                
            }
        }
    
    
    }
    


}
//弹出的背景图
-(void)backBtn:(UIButton*)sender{

    [self.backBtn removeFromSuperview];

}



//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
//{
//    if (viewController ==self.realVC||viewController == self.realeVC)
//    {
//        return self.releaseVC;
//    }
//    return nil;
//    
//}
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
//{
//    if (viewController ==self.releaseVC||viewController == self.realeVC)
//    {
//        return self.realVC;
//    }else if (viewController ==self.releaseVC||viewController == self.realVC){
//        return self.realeVC;
//    
//    }
//    return nil;
//}
//#pragma mark 点击切换控制器
//-(void)switchover:(UISegmentedControl *)segment
//{
//    NSInteger index = segment.selectedSegmentIndex;
//    self.viewControllers =nil;
//    
//    if (index ==0)
//    {
//        self.viewControllers =[NSArray arrayWithObject:self.releaseVC];
//    }
//    if (index ==1)
//    {
//        self.viewControllers =[NSArray arrayWithObject:self.realVC];
//   
//    }if (index ==2)
//    {
//        self.viewControllers =[NSArray arrayWithObject:self.realeVC];
//    }
//    [self.pageController setViewControllers:self.viewControllers
//                                  direction:UIPageViewControllerNavigationDirectionForward
//                                   animated:NO
//                                 completion:nil];
//}


@end
