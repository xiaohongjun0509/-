
//
//  MbMyCollectionViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/26.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbMyCollectionViewController.h"
#import "JZQCommon.h"
#import "MbMyCollectionTableViewCell.h"
#import "MbMyjianliCollectCell.h"
#import "MbMyqiyeCollectCell.h"
#import "MJRefresh.h"
#import "MbMyCollectionModel.h"
#import "MbWorkDetailsViewController.h"
#import "MbResumeDetailsViewController.h"
#import "MbEnterpriseDetailViewController.h"




@interface MbMyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   
    NSMutableArray *contacts;
  
}

@property(nonatomic,strong)UILabel* titleLabel;           //标题
@property(nonatomic,strong)UILabel* moneyLabel;           //工资
@property(nonatomic,strong)UILabel* projectManagerLabel;  //项目经理
@property(nonatomic,strong)UILabel* placeLabel;           //地点
@property(nonatomic,strong)UILabel* nameLabel;            //公司名字
@property(nonatomic,strong)UILabel* dateLabel;            //日期
@property(nonatomic,strong)UIButton* seleteBtn;           //对号按钮
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UIButton* seleteAllBtn;
@property(nonatomic,strong)UILabel* seleteLabel;
@property(nonatomic,strong)UIButton* cancleBtn;
@property(nonatomic,strong)UIButton* btn1;
@property(nonatomic,strong)UIButton* btn2;
@property(nonatomic,strong)UIButton* btn3;
@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)NSString* userid;
@property(strong,nonatomic)NSMutableArray* buttons;
@property(nonatomic,strong)UIView* view1;
@property(nonatomic,strong)NSMutableArray* lists1;         //找工作
@property(nonatomic,strong)NSMutableArray* lists2;         //看简历
@property(nonatomic,strong)NSMutableArray* lists3;         //企业通
@property(nonatomic,strong)NSMutableArray* infoArr1;       //存储选中状态
@property(nonatomic,strong)NSMutableArray* infoArr2;
@property(nonatomic,strong)NSMutableArray* infoArr3;
@property(nonatomic,strong)NSString* idString1;     //存储id
@property(nonatomic,strong)NSString* idString2;     //存储id
@property(nonatomic,strong)NSString* idString3;     //存储id
@property(nonatomic,strong)UIButton* editBtn;       //导航栏右上角按钮
@property(nonatomic,strong)MbWorkDetailsViewController* workDetailsVC;      //招聘信息详情页
@property(nonatomic,strong)MbResumeDetailsViewController* resumeDetailVC;   //简历
@property(nonatomic,strong)MbEnterpriseDetailViewController* detailVC;      //企业通
@property(nonatomic,assign)int freshCount1;             //加载传值
@property(nonatomic,assign)int freshCount2;             //加载传值
@property(nonatomic,assign)int freshCount3;             //加载传值
@property(nonatomic,strong)NSDictionary* dictionary1;
@property(nonatomic,strong)NSDictionary* dictionary2;
@property(nonatomic,strong)NSDictionary* dictionary3;
@property(nonatomic,strong)UIButton* backBtn;           //弹出背景图
@property(nonatomic,strong)NSArray* array;
@end

@implementation MbMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    self.array = @[@"取消收藏",@"取消全部收藏"];
    self.freshCount1 = 2;
    self.freshCount2 = 2;
    self.freshCount3 = 2;
    self.lists1 = [NSMutableArray array];
    self.lists2 = [NSMutableArray array];
    self.lists3 = [NSMutableArray array];
    self.senderArray1 = [NSMutableArray array];
    self.infoArr1 = [NSMutableArray array];
    self.infoArr2 = [NSMutableArray array];
    self.infoArr3 = [NSMutableArray array];
    self.dictionary1 = [[NSDictionary alloc]init];
    self.dictionary2 = [[NSDictionary alloc]init];
    self.dictionary3 = [[NSDictionary alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    //     contacts = [NSMutableArray array];
    //    for (int i = 0; i <10; i++) {
    //        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //        [dic setValue:@"NO" forKey:@"checked"];
    //        [contacts addObject:dic];
    //    }
    [self initWithButton];
    [self initWithSecondView];
//    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_write_col.png"] style:UIBarButtonItemStyleDone target:self action:@selector(white)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    

    
    
    [self getMessage1];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //[self initTopView];
}

-(void)initTopView
{
    self.navigationController.navigationBarHidden = YES;
    UIImageView *topImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 64)];
    topImageV.userInteractionEnabled = YES;
    topImageV.backgroundColor = [UIColor colorWithRed:76/255.0 green:154/255.0 blue:218/255.0 alpha:1.0];
    [self.view addSubview:topImageV];
    
    UIImageView *leftIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 27, 25, 25)];
    leftIV.image = [UIImage imageNamed:@"nav_back.png"];
    [topImageV addSubview:leftIV];
    
    UIImageView *leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 61, 40)];
    leftImageV.backgroundColor = [UIColor clearColor];
    leftImageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    backTap.numberOfTapsRequired = 1;
    [leftImageV addGestureRecognizer:backTap];
    [topImageV addSubview:leftImageV];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(topImageV.center.x - 125, 33, 250, 18)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    CGFloat fongsize = 0;
    if (viewWidth==320) {
        fongsize = 18.0;
    }else
        fongsize = 21.0;
    titleLabel.text = @"我的收藏";
    titleLabel.font = [UIFont boldSystemFontOfSize:fongsize];
    [topImageV addSubview:titleLabel];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame = CGRectMake(viewWidth - 41, 28, 26, 26);
    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"nav_write.png"] forState:UIControlStateNormal];
    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"nav_write_col.png"] forState:UIControlStateSelected];
    self.editBtn.selected = NO;
    [self.editBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];

    [topImageV addSubview:self.editBtn];
}

-(void)back{

    [self.navigationController popViewControllerAnimated:YES];

}
-(void)change:(UIButton*)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected==NO) {
        [self.seleteAllBtn removeFromSuperview];
        [self.seleteLabel removeFromSuperview];
        [self.cancleBtn removeFromSuperview];
        [self.scrollView removeFromSuperview];
        self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, viewWidth, self.view.frame.size.height -  46)];
        self.scrollView.contentOffset = CGPointZero;
        self.scrollView.contentSize = CGSizeMake(viewWidth * 3, 0);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = YES;
        [self.view addSubview:self.scrollView];
        self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, self.scrollView.frame.size.height)];
        self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth, 0, viewWidth, self.scrollView.frame.size.height)];
        self.tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth * 2, 0, viewWidth, self.scrollView.frame.size.height)];
        
        self.tableView1.delegate = self;
        self.tableView1.dataSource = self;
        self.tableView2.delegate = self;
        self.tableView2.dataSource = self;
        self.tableView3.delegate = self;
        self.tableView3.dataSource = self;
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreDongtai1)];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshDongtai1)];

//        [self.tableView1 addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(freshDongtai1)];
//        [self.tableView1 addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(moreDongtai1)];
        [self.tableView1.header beginRefreshing];
        
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreDongtai2)];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshDongtai2)];
//        [self.tableView2 addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(freshDongtai2)];
//        [self.tableView2 addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(moreDongtai2)];
        [self.tableView2.header beginRefreshing];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreDongtai3)];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshDongtai3)];
//        [self.tableView3 addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(freshDongtai3)];
//        [self.tableView3 addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(moreDongtai3)];
        [self.tableView3.header beginRefreshing];
        
        
        
        [self.scrollView addSubview:self.tableView1];
        [self.scrollView addSubview:self.tableView2];
        [self.scrollView addSubview:self.tableView3];
    }else if (sender.selected==YES){
        [self.scrollView removeFromSuperview];
        self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, self.view.frame.size.height -  91)];
        self.scrollView.contentOffset = CGPointZero;
        self.scrollView.contentSize = CGSizeMake(viewWidth * 3, 0);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = YES;
        [self.view addSubview:self.scrollView];
        self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, self.scrollView.frame.size.height)];
        self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth, 0, viewWidth, self.scrollView.frame.size.height)];
        self.tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth * 2, 0, viewWidth, self.scrollView.frame.size.height)];
        
        self.tableView1.delegate = self;
        self.tableView1.dataSource = self;
        self.tableView2.delegate = self;
        self.tableView2.dataSource = self;
        self.tableView3.delegate = self;
        self.tableView3.dataSource = self;
    
        
        [self.scrollView addSubview:self.tableView1];
        [self.scrollView addSubview:self.tableView2];
        [self.scrollView addSubview:self.tableView3];
        //全选按钮
        self.seleteAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(17, viewHeight- 34.5, 24, 24)];
        [self.seleteAllBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
        [self.seleteAllBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co_col.png"] forState:UIControlStateSelected];
        
        [self.seleteAllBtn addTarget:self action:@selector(seleteAll:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.seleteAllBtn];
        
        
        self.seleteLabel = [[UILabel alloc]init];
        self.seleteLabel.text = @"全部选择";
        self.seleteLabel.font = [UIFont systemFontOfSize:labelText+2];
        self.seleteLabel.textColor = [UIColor colorWithRed:57/255.0 green:141/255.0 blue:227/255.0 alpha:1];
        
        CGSize size = [self.seleteLabel.text sizeWithFont:self.seleteLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.seleteLabel.frame = CGRectMake(CGRectGetMaxX(self.seleteAllBtn.frame)+10, viewHeight-size.height-(45-size.height)/2, size.width, size.height);
        [self.view addSubview:self.seleteLabel];
        
        //取消收藏
        self.cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth-15-size.width/2*3, viewHeight- 37.5, size.width/2*3, 30)];
        [self.cancleBtn setBackgroundColor:[UIColor colorWithRed:52/255.0 green:142/255.0 blue:221/255.0 alpha:1]];
        [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.cancleBtn setFont:[UIFont systemFontOfSize:labelText]];
        [self.cancleBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [self.cancleBtn addTarget:self action:@selector(cancleAll:) forControlEvents:UIControlEventTouchUpInside];
        self.cancleBtn.layer.cornerRadius = 15;
        self.cancleBtn.layer.masksToBounds = YES;
        [self.view addSubview:self.cancleBtn];

    
    }
    
}

-(void)getMessage1{
    NSURL *url = [NSURL URLWithString:workCollect];
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
        
        self.lists1 = [MbPaser paserFindWorkByDic:dic];
        for (int i = 0; i<self.lists1.count; i++)
        {
            NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
            
            [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
            
            
            //封装数据模型
            MbMyCollectionModel *goodsModel = [[MbMyCollectionModel alloc]initWithDict:infoDict];
            
            //将数据模型放入数组中
            [self.infoArr1 addObject:goodsModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView1 reloadData];
        });
    }
    
}
-(void)getMessage2{
    NSURL *url = [NSURL URLWithString:jianliCollect];
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
        
        self.lists2 = [MbPaser paserSeeResumeByDic:dic];
        for (int i = 0; i<self.lists2.count; i++)
        {
            NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
            
            [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
            
            
            //封装数据模型
            MbMyCollectionModel *goodsModel = [[MbMyCollectionModel alloc]initWithDict:infoDict];
            
            //将数据模型放入数组中
            [self.infoArr2 addObject:goodsModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView2 reloadData];
        });
    }
    
}
-(void)getMessage3{
    NSURL *url = [NSURL URLWithString:qiyeCollect];
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
        self.lists3 = [MbPaser paserEnterpriseByDic:dic];
        for (int i = 0; i<self.lists3.count; i++)
        {
            NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
            
            [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
            
            
            //封装数据模型
            MbMyCollectionModel *goodsModel = [[MbMyCollectionModel alloc]initWithDict:infoDict];
            
            //将数据模型放入数组中
            [self.infoArr3 addObject:goodsModel];
        }
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
    self.btn1.layer.borderWidth = 1;
    self.btn1.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor colorWithRed:0 green:193/255.0 blue:72/255.0 alpha:1] forState:UIControlStateSelected];
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:labelText];
    //[self.btn1 setBackgroundColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"home_6_co1l.png"] forState:UIControlStateSelected];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"home_6_tab1.png"] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.tag = 0;
    [self.view addSubview:self.btn1];
    //看简历
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/3, 0, viewWidth/3, 46)];
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:labelText];
    //[self.btn2 setBackgroundColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];
    self.btn2.layer.borderWidth = 1;
    self.btn2.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    [self.btn2 setTitle:@"看简历" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor colorWithRed:0 green:193/255.0 blue:72/255.0 alpha:1] forState:UIControlStateSelected];
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
    //[self.btn3 setBackgroundColor:[UIColor colorWithRed:72/255.0 green:119/255.0 blue:255/255.0 alpha:1]];

    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"home_6_co1l.png"] forState:UIControlStateSelected];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"home_6_tab1.png"] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn3 addTarget:self action:@selector(btn3:) forControlEvents:UIControlEventTouchUpInside];
    self.btn3.tag = 3;
    [self.view addSubview:self.btn3];
    
    //三个按钮下边的横线
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 46, viewWidth, 1)];
    label.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view addSubview:label];
    
}

#pragma makr 初始化视图
-(void)initWithSecondView
{
    
    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 46, viewWidth, self.view.frame.size.height - 64 - 46)];
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 3, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    
    self.tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, self.scrollView.frame.size.height)];
    self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth, 0, viewWidth, self.scrollView.frame.size.height)];
    self.tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth * 2, 0, viewWidth, self.scrollView.frame.size.height)];
    
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
        NSURL *url = [NSURL URLWithString:workCollect];
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
            
            
            self.lists1 = [MbPaser paserFindWorkByDic:self.dictionary1];
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView1 reloadData];
            });
        }else{
            
            self.lists1 = [MbPaser paserFindWorkByDic:dic];
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
        NSURL *url = [NSURL URLWithString:jianliCollect];
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
            
            
            self.lists2 = [MbPaser paserSeeResumeByDic:self.dictionary2];
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView2 reloadData];
            });
        }else{
            
            self.lists2 = [MbPaser paserSeeResumeByDic:dic];
            self.dictionary2 = dic;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView2 reloadData];
            });
        }
        
        
        
    }
    
    
}
-(void)requestDongtaiByIntThree:(int)freshint{
   
    
    
    [self.tableView3.header endRefreshing];
    [self.tableView3.footer endRefreshing];
    if (freshint==1) {
        [self getMessage3];
    }else if(freshint>1){
        NSURL *url = [NSURL URLWithString:qiyeCollect];
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
            
            
            self.lists3 = [MbPaser paserEnterpriseByDic:self.dictionary3];
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView3 reloadData];
            });
        }else{
            
            self.lists3 = [MbPaser paserEnterpriseByDic:dic];
            self.dictionary3 = dic;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView3 reloadData];
            });
        }
        
        
        
    }
    
}
#pragma mark 图的偏移量
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.seleteAllBtn.selected = NO;
    [self.seleteAllBtn removeFromSuperview];
    [self.seleteLabel removeFromSuperview];
    [self.cancleBtn removeFromSuperview];
    if (self.scrollView == scrollView)
    {
        self.seleteAllBtn.selected = NO;
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
      self.seleteAllBtn.selected = NO;
    [self.seleteAllBtn removeFromSuperview];
    [self.seleteLabel removeFromSuperview];
    [self.cancleBtn removeFromSuperview];
    sender.selected=!sender.selected;
    if (self.btn1.selected==YES) {
        self.btn1.selected = NO          ;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
    }
    self.btn1 = sender;
    self.btn1.selected = !self.btn1.selected;
    self.scrollView.contentOffset = CGPointMake(sender.frame.origin.x * 3, 0);
    [self getMessage1];
}
-(void)btn2:(UIButton*)sender{
      self.seleteAllBtn.selected = NO;
    [self.seleteAllBtn removeFromSuperview];
    [self.seleteLabel removeFromSuperview];
    [self.cancleBtn removeFromSuperview];
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
      self.seleteAllBtn.selected = NO;
    [self.seleteAllBtn removeFromSuperview];
    [self.seleteLabel removeFromSuperview];
    [self.cancleBtn removeFromSuperview];
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    MbMyCollectionTableViewCell* cell1 = nil;
    MbMyjianliCollectCell* cell2 = nil;
    MbMyqiyeCollectCell* cell3 = nil;
    UITableViewCell* cell4 = nil;
    if (tableView==self.tableView1) {
        cell1 = [self.tableView1 dequeueReusableCellWithIdentifier:identifire];
        if (!cell1) {
            cell1 = [[MbMyCollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            cell1.delegate = self;
        }
        MbUserInfo* info = [self.lists1 objectAtIndex:indexPath.row];
        [cell1 loadContent:info];
        cell1.userInteractionEnabled = YES;
        NSUInteger row = [indexPath row];
        cell1.seleteBtn.tag = indexPath.row;
        
        //调用方法，给单元格赋值
        [cell1 addTheValue:_infoArr1[indexPath.row]];
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap1:)];
        //        longPress.minimumPressDuration = 3;
        [cell1 addGestureRecognizer:longPress];
        
        //        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        //        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        //            [dic setObject:@"NO" forKey:@"checked"];
        //            [cell1 setChecked:NO];
        //
        //        }else {
        //            [dic setObject:@"YES" forKey:@"checked"];
        //            [cell1 setChecked:YES];
        //        }
        
        return cell1;
    }else if (tableView==self.tableView2){
        cell2 = [self.tableView2 dequeueReusableCellWithIdentifier:identifire];
        if (!cell2) {
            cell2 = [[MbMyjianliCollectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            cell2.delegate = self;
        }
        MbUserInfo* info = [self.lists2 objectAtIndex:indexPath.row];
        [cell2 loadContent:info];
        NSUInteger row = [indexPath row];
        cell2.seleteBtn.tag = indexPath.row;
        [cell2 addTheValue:_infoArr2[indexPath.row]];
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap2:)];
        //        longPress.minimumPressDuration = 3;
        [cell2 addGestureRecognizer:longPress];
        //        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        //        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        //            [dic setObject:@"NO" forKey:@"checked"];
        //            [cell2 setChecked:NO];
        //
        //        }else {
        //            [dic setObject:@"YES" forKey:@"checked"];
        //            [cell2 setChecked:YES];
        //        }
        
        return cell2;
        
        
    }else if (tableView==self.tableView3){
        
        cell3 = [self.tableView3 dequeueReusableCellWithIdentifier:identifire];
        if (!cell3) {
            cell3 = [[MbMyqiyeCollectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            cell3.delegate = self;
        }
        MbUserInfo* info = [self.lists3 objectAtIndex:indexPath.row];
        [cell3 loadContent:info];
        NSUInteger row = [indexPath row];
        
        cell3.seleteBtn.tag = row;
        [cell3 addTheValue:_infoArr3[indexPath.row]];
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap3:)];
        //        longPress.minimumPressDuration = 3;
        [cell3 addGestureRecognizer:longPress];
        //        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        //        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        //            [dic setObject:@"NO" forKey:@"checked"];
        //            [cell3 setChecked:NO];
        //
        //        }else {
        //            [dic setObject:@"YES" forKey:@"checked"];
        //            [cell3 setChecked:YES];
        //        }
        return cell3;
        
    }else if (tableView==self.tableView){
    
        cell4 = [self.tableView dequeueReusableCellWithIdentifier:identifire];
        if (!cell4) {
            cell4 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
           
        }
        cell4.textLabel.text = [self.array objectAtIndex:indexPath.row];
        cell4.textLabel.font = [UIFont systemFontOfSize:labelText];
        return cell4;
    }
    
    
    
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    cell4.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.tableView3) {
        CGFloat cellHeight = 0.0f;
        MbMyqiyeCollectCell *cell = (MbMyqiyeCollectCell *)[self tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath];
        cellHeight = cell.finalH;
        
        return cellHeight;
    }else if (tableView==self.tableView){
        return 44;
    }else{
        
        return (viewHeight-109)/6;
    }
    return 0;
}
-(void)longTap1:(UILongPressGestureRecognizer *)longRecognizer
{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [longRecognizer locationInView:self.tableView1];
        NSIndexPath* indexPath = [_tableView1 indexPathForRowAtPoint:point];
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
        

    }
}
//简历信息上的手势
-(void)longTap2:(UILongPressGestureRecognizer *)longRecognizer
{
    
    
    
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [longRecognizer locationInView:self.tableView2];
        NSIndexPath* indexPath = [_tableView2 indexPathForRowAtPoint:point];
        
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
        
    
    }
}
//企业通信息上的手势
-(void)longTap3:(UILongPressGestureRecognizer *)longRecognizer
{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [longRecognizer locationInView:self.tableView3];
        NSIndexPath* indexPath = [_tableView3 indexPathForRowAtPoint:point];
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
        
     
    }
}
-(void)backBtn:(UIButton*)sender{
    [self.backBtn removeFromSuperview];

}
-(void)white{
    
}
//-(void)seletedBtn:(UIButton*)sender{
//    NSString* string = [NSString stringWithFormat:@"%ld",(long)sender.tag];
//    [self.senderArray1 addObject:string];
//    NSString* str = [self.senderArray1 componentsJoinedByString:@","];
//    NSLog(@"%@",self.senderArray1);
//    self.cancleBtn.tag = sender.tag;
//    self.seleteBtn.tag = sender.tag;
//}
//-(void)seletedBtn2:(UIButton*)sender{
//    self.cancleBtn.tag = sender.tag;
//    self.seleteBtn.tag = sender.tag;
//}
//-(void)seletedBtn3:(UIButton*)sender{
//    self.cancleBtn.tag = sender.tag;
//    self.seleteBtn.tag = sender.tag;
//}




//-(void)seleteBtn:(UIButton*)sender{
//
//    sender.selected = !sender.selected;
//
//}
//全选
-(void)seleteAll:(UIButton*)sender{
    
    if (self.scrollView.contentOffset.x/viewWidth==0) {
        //判断是否选中，是改成否，否改成是，改变图片状态
        sender.tag = !sender.tag;
        
  
        if (sender.tag)
        {
            [sender setImage:[UIImage imageNamed:@"home_7_co_col.png"] forState:UIControlStateNormal];
            
        }else{
            [sender setImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
        }
        NSMutableArray* array = [NSMutableArray array];
        //改变单元格选中状态
        for (int i=0; i<self.lists1.count; i++)
        {
            MbMyCollectionModel *model = [self.infoArr1 objectAtIndex:i];
            self.info = [self.lists1 objectAtIndex:i];
            [array addObject:self.info.recruitmenid];
            
            model.selectState = sender.tag;
        }
        self.idString1 = [array componentsJoinedByString:@","];
        [self.tableView1 reloadData];
        
    }else if (self.scrollView.contentOffset.x/viewWidth==1){
        //判断是否选中，是改成否，否改成是，改变图片状态
        sender.tag = !sender.tag;
        
        
        if (sender.tag)
        {
            [sender setImage:[UIImage imageNamed:@"home_7_co_col.png"] forState:UIControlStateNormal];
            
        }else{
            [sender setImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
        }
        NSMutableArray* array = [NSMutableArray array];
        //改变单元格选中状态
        for (int i=0; i<self.lists2.count; i++)
        {
            
            MbMyCollectionModel *model = [self.infoArr2 objectAtIndex:i];
            self.info = [self.lists2 objectAtIndex:i];
            [array addObject:self.info.resumeid];
            
            model.selectState = sender.tag;
        }
        self.idString2 = [array componentsJoinedByString:@","];
        [self.tableView2 reloadData];
        
    }else if (self.scrollView.contentOffset.x/viewWidth==2){
        //判断是否选中，是改成否，否改成是，改变图片状态
        sender.tag = !sender.tag;
        
        
        if (sender.tag)
        {
            [sender setImage:[UIImage imageNamed:@"home_7_co_col.png"] forState:UIControlStateNormal];
            
        }else{
            [sender setImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
        }
        NSMutableArray* array = [NSMutableArray array];
        //改变单元格选中状态
        for (int i=0; i<self.lists3.count; i++)
        {
            
            MbMyCollectionModel *model = [self.infoArr3 objectAtIndex:i];
            self.info = [self.lists3 objectAtIndex:i];
            [array addObject:self.info.companyid];
            
            model.selectState = sender.tag;
        }
        self.idString3 = [array componentsJoinedByString:@","];
        [self.tableView3 reloadData];
        
    }
    
    
    
    /*
     if (self.scrollView.contentOffset.x/viewWidth==0) {
     sender.selected = !sender.selected;
     NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[self.tableView1 indexPathsForVisibleRows]];
     for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
     NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
     MbMyCollectionTableViewCell *cell1 = (MbMyCollectionTableViewCell*)[self.tableView1 cellForRowAtIndexPath:indexPath];
     NSUInteger row = [indexPath row];
     self.info = [self.lists1 objectAtIndex:row];
     NSMutableDictionary *dic = [contacts objectAtIndex:row];
     if (sender.selected==YES) {
     [dic setObject:@"YES" forKey:@"checked"];
     [cell1 setChecked:YES];
     }else {
     [dic setObject:@"NO" forKey:@"checked"];
     [cell1 setChecked:NO];
     }
     }
     
     }else if (self.scrollView.contentOffset.x/viewWidth==1){
     sender.selected = !sender.selected;
     NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[self.tableView2 indexPathsForVisibleRows]];
     for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
     NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
     MbMyjianliCollectCell *cell2 = (MbMyjianliCollectCell*)[self.tableView2 cellForRowAtIndexPath:indexPath];
     NSUInteger row = [indexPath row];
     NSMutableDictionary *dic = [contacts objectAtIndex:row];
     if (sender.selected==YES) {
     [dic setObject:@"YES" forKey:@"checked"];
     [cell2 setChecked:YES];
     }else {
     [dic setObject:@"NO" forKey:@"checked"];
     [cell2 setChecked:NO];
     }
     }
     }else if (self.scrollView.contentOffset.x/viewWidth==2){
     sender.selected = !sender.selected;
     NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[self.tableView3 indexPathsForVisibleRows]];
     for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
     NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
     MbMyqiyeCollectCell *cell3 = (MbMyqiyeCollectCell*)[self.tableView3 cellForRowAtIndexPath:indexPath];
     NSUInteger row = [indexPath row];
     NSMutableDictionary *dic = [contacts objectAtIndex:row];
     if (sender.selected==YES) {
     [dic setObject:@"YES" forKey:@"checked"];
     [cell3 setChecked:YES];
     }else {
     [dic setObject:@"NO" forKey:@"checked"];
     [cell3 setChecked:NO];
     }
     }
     }
     */
}

//取消全部
-(void)cancleAll:(UIButton*)sender{
    
    //    sender.selected = !sender.selected;
    //    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[self.tableView1 indexPathsForVisibleRows]];
    //    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
    //        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
    //        MbMyCollectionTableViewCell *cell1 = (MbMyCollectionTableViewCell*)[self.tableView1 cellForRowAtIndexPath:indexPath];
    //
    //        NSUInteger row = [indexPath row];
    //
    //        NSMutableDictionary *dic = [contacts objectAtIndex:row];
    //
    //        self.seleteAllBtn.selected = NO;
    //
    //            [dic setObject:@"NO" forKey:@"checked"];
    //            [cell1 setChecked:NO];
    //    }
    
    

    
    if (self.scrollView.contentOffset.x/viewWidth==0) {
        sender.selected = !sender.selected;
        NSMutableArray* arr = [NSMutableArray array];
        for (int i = 0; i<self.senderArray1.count; i++) {
            MbUserInfo* info = [self.lists1 objectAtIndex:i];
            
            [arr addObject:info.recruitmenid];
            
        }
        self.info = [self.lists1 objectAtIndex:sender.tag];
        
        //取消收藏
        [MbPaser sendCancleRecruitmenCollectByUserid:self.userid recruitmencollid:self.idString1 result:^(CancleRecruitmenCollectResponse *response, NSError *error) {
            if (response.message) {
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            [self getMessage1];
        }];
        
    }else if (self.scrollView.contentOffset.x/viewWidth==1){
        sender.selected = !sender.selected;
        self.info = [self.lists2 objectAtIndex:sender.tag];
        
        //取消收藏
        [MbPaser sendCancleResumecollCollectByUserid:self.userid resumecollid:self.idString2 result:^(CancleResumecollCollectResponse *response, NSError *error) {
            if (response.message) {
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            [self getMessage2];
        }];
        
    }else if (self.scrollView.contentOffset.x/viewWidth==2){
        
        sender.selected = !sender.selected;
        
        self.info = [self.lists3 objectAtIndex:sender.tag];
        //取消收藏
        [MbPaser sendCancleCompanycollCollectByUserid:self.userid companycollid:self.idString3 result:^(CancleCompanycollCollectResponse *response, NSError *error) {
            if (response.message) {
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            [self getMessage3];
        }];
        
    }

    if (self.seleteAllBtn.tag) {
         self.seleteAllBtn.tag = !self.seleteAllBtn.tag;
        [self.seleteAllBtn setImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
    }else{
    
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    //没有在编辑状态
    /*
    if (self.editBtn.selected==NO) {
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
        }
        
        
        
    }else if (self.editBtn.selected==YES){
        if (tableView==self.tableView1) {
     
            //   判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     
            MbMyCollectionModel *model = self.infoArr1[indexPath.row];
            
            if (model.selectState)
            {
                model.selectState = NO;
            }
            else
            {
                model.selectState = YES;
            }
            //刷新当前行
            [self.tableView1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            NSMutableArray* array = [NSMutableArray array];
            for ( int i =0; i<self.lists1.count; i++)
            {
                MbMyCollectionModel *model = [self.infoArr1 objectAtIndex:i];
                self.info = [self.lists1 objectAtIndex:i];
                
                if (model.selectState)
                {
                    
                    [array addObject:self.info.recruitmenid];
                    self.idString1 = [array componentsJoinedByString:@","];
                }
                
            }
            
        }else if (tableView==self.tableView2){
            
             // 判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
            
            MbMyCollectionModel *model = self.infoArr2[indexPath.row];
            
            if (model.selectState)
            {
                model.selectState = NO;
            }
            else
            {
                model.selectState = YES;
            }
            //刷新当前行
            [self.tableView2 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            NSMutableArray* array = [NSMutableArray array];
            for ( int i =0; i<self.lists2.count; i++)
            {
                MbMyCollectionModel *model = [self.infoArr2 objectAtIndex:i];
                self.info = [self.lists2 objectAtIndex:i];
                
                if (model.selectState)
                {
                    
                    [array addObject:self.info.resumeid];
                    self.idString2 = [array componentsJoinedByString:@","];
                }
            }
            
            
        }else if (tableView==self.tableView3){
     
            //   判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     
            MbMyCollectionModel *model = self.infoArr3[indexPath.row];
            
            if (model.selectState)
            {
                model.selectState = NO;
            }
            else
            {
                model.selectState = YES;
            }
            //刷新当前行
            [self.tableView3 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            NSMutableArray* array = [NSMutableArray array];
            for ( int i =0; i<self.lists3.count; i++)
            {
                MbMyCollectionModel *model = [self.infoArr3 objectAtIndex:i];
                self.info = [self.lists3 objectAtIndex:i];
                
                if (model.selectState)
                {
                    
                    [array addObject:self.info.companyid];
                    self.idString3 = [array componentsJoinedByString:@","];
                }
            }
            
            
            
        }else
*/
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
                if (self.scrollView.contentOffset.x/viewWidth==0) {
                    
                    NSMutableArray* arr = [NSMutableArray array];
                    for (int i = 0; i<self.lists1.count; i++) {
                        MbUserInfo* info = [self.lists1 objectAtIndex:i];
                        
                        [arr addObject:info.recruitmenid];
                        
                    }
                    self.info = [self.lists1 objectAtIndex:indexPath.row];
                    
                    //取消收藏
                    [MbPaser sendCancleRecruitmenCollectByUserid:self.userid recruitmencollid:self.info.recruitmenid result:^(CancleRecruitmenCollectResponse *response, NSError *error) {
                        if (response.message) {
                            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        [self getMessage1];
                        [self.backBtn removeFromSuperview];
                    }];
                    
                }else if (self.scrollView.contentOffset.x/viewWidth==1){
                    
                    self.info = [self.lists2 objectAtIndex:indexPath.row];
                    
                    //取消收藏
                    [MbPaser sendCancleResumecollCollectByUserid:self.userid resumecollid:self.info.resumeid result:^(CancleResumecollCollectResponse *response, NSError *error) {
                        if (response.message) {
                            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        [self getMessage2];
                        [self.backBtn removeFromSuperview];
                    }];
                    
                }else if (self.scrollView.contentOffset.x/viewWidth==2){
                    
                    
                    
                    self.info = [self.lists3 objectAtIndex:indexPath.row];
                    //取消收藏
                    [MbPaser sendCancleCompanycollCollectByUserid:self.userid companycollid:self.info.companyid result:^(CancleCompanycollCollectResponse *response, NSError *error) {
                        if (response.message) {
                            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        [self getMessage3];
                        [self.backBtn removeFromSuperview];
                    }];
                    
                }
                
            }else if (indexPath.row==1){
                if (self.scrollView.contentOffset.x/viewWidth==0) {
               
                    NSMutableArray* arr = [NSMutableArray array];
                    for (int i = 0; i<self.lists1.count; i++) {
                        MbUserInfo* info = [self.lists1 objectAtIndex:i];
                        
                        [arr addObject:info.recruitmenid];
                        
                    }
                    self.idString1 = [arr componentsJoinedByString:@","];
                    
                    //self.info = [self.lists1 objectAtIndex:indexPath.row];
                    
                    //取消收藏
                    [MbPaser sendCancleRecruitmenCollectByUserid:self.userid recruitmencollid:self.idString1 result:^(CancleRecruitmenCollectResponse *response, NSError *error) {
                        if (response.message) {
                            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        [self getMessage1];
                        [self.backBtn removeFromSuperview];
                    }];
                    
                }else if (self.scrollView.contentOffset.x/viewWidth==1){
                    NSMutableArray* arr = [NSMutableArray array];
                    for (int i = 0; i<self.lists2.count; i++) {
                        MbUserInfo* info = [self.lists2 objectAtIndex:i];
                        
                        [arr addObject:info.resumeid];
                        
                    }
                    self.idString2 = [arr componentsJoinedByString:@","];
             
                    //self.info = [self.lists2 objectAtIndex:indexPath.row];
                    
                    //取消收藏
                    [MbPaser sendCancleResumecollCollectByUserid:self.userid resumecollid:self.idString2 result:^(CancleResumecollCollectResponse *response, NSError *error) {
                        if (response.message) {
                            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        [self getMessage2];
                        [self.backBtn removeFromSuperview];
                    }];
                    
                }else if (self.scrollView.contentOffset.x/viewWidth==2){
                    NSMutableArray* arr = [NSMutableArray array];
                    for (int i = 0; i<self.lists3.count; i++) {
                        MbUserInfo* info = [self.lists3 objectAtIndex:i];
                        
                        [arr addObject:info.companyid];
                        
                    }
                   self.idString3 = [arr componentsJoinedByString:@","];
                    
                    //self.info = [self.lists3 objectAtIndex:indexPath.row];
                    //取消收藏
                    [MbPaser sendCancleCompanycollCollectByUserid:self.userid companycollid:self.idString3 result:^(CancleCompanycollCollectResponse *response, NSError *error) {
                        if (response.message) {
                            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        [self getMessage3];
                        [self.backBtn removeFromSuperview];
                    }];
                    
                }
            
            }
        
        
        }
    
    //}
    

    
    
    /*
     if (tableView==self.tableView1) {
     MbMyCollectionTableViewCell *cell1 = (MbMyCollectionTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
     cell1.seleteBtn.selected = !cell1.seleteBtn.selected;
     if (cell1.seleteBtn.selected==YES) {
     [self.seleteBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co_col.png"] forState:UIControlStateNormal];
     }else{
     [self.seleteBtn setBackgroundImage:[UIImage imageNamed:@"home_7_co.png"] forState:UIControlStateNormal];
     
     }
     NSUInteger row = [indexPath row];
     cell1.seleteBtn.tag = row;
     self.cancleBtn.tag = row;
     
     NSMutableDictionary *dic = [contacts objectAtIndex:cell1.seleteBtn.tag];
     if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
     [dic setObject:@"YES" forKey:@"checked"];
     [cell1 setChecked:YES];
     }else {
     [dic setObject:@"NO" forKey:@"checked"];
     [cell1 setChecked:NO];
     }
     }else if (tableView==self.tableView2){
     MbMyjianliCollectCell *cell2 = (MbMyjianliCollectCell*)[tableView cellForRowAtIndexPath:indexPath];
     
     NSUInteger row = [indexPath row];
     self.cancleBtn.tag = row;
     NSMutableDictionary *dic = [contacts objectAtIndex:row];
     if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
     [dic setObject:@"YES" forKey:@"checked"];
     [cell2 setChecked:YES];
     }else {
     [dic setObject:@"NO" forKey:@"checked"];
     [cell2 setChecked:NO];
     }
     }else if (tableView==self.tableView3){
     MbMyqiyeCollectCell *cell3 = (MbMyqiyeCollectCell*)[tableView cellForRowAtIndexPath:indexPath];
     
     NSUInteger row = [indexPath row];
     self.cancleBtn.tag = row;
     NSMutableDictionary *dic = [contacts objectAtIndex:row];
     if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
     [dic setObject:@"YES" forKey:@"checked"];
     [cell3 setChecked:YES];
     }else {
     [dic setObject:@"NO" forKey:@"checked"];
     [cell3 setChecked:NO];
     }
     }
     */
    
    
    
    
}
@end
