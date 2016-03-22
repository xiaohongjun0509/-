//
//  MbHomePageViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/22.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbHomePageViewController.h"
#import "JZQCommon.h"
#import "MbFindWorkViewController.h"
#import "MbSeeResumeViewController.h"
#import "MbCityListViewController.h"
#import "MbEnterpriseViewController.h"
#import "MbTenderViewController.h"
#import "MbLoginViewController.h"
#import "JZQHttpTools.h"
#import "AppDelegate.h"
#import "MbDanli.h"
@interface MbHomePageViewController ()<UIScrollViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property(nonatomic,strong)UIScrollView* scrollView;     //轮播图控件
@property(nonatomic,strong)UIImageView* imageView;       //图片
@property(nonatomic,strong)UIPageControl* pageController;//小圆点
@property(nonatomic,strong)NSArray* images;              //图片数组
@property(nonatomic,strong)UIButton* button1;            //找工作
@property(nonatomic,strong)UIButton* button2;            //看简历
@property(nonatomic,strong)UIButton* button3;            //企业通
@property(nonatomic,strong)UIButton* button4;            //招标通
@property(nonatomic,strong)MbFindWorkViewController* findWorkVC;   //找工作页面
@property(nonatomic,strong)MbSeeResumeViewController* seeResumeVC; //看简历页面
@property(nonatomic,strong)MbCityListViewController* cityList;     //城市列表
@property(nonatomic,strong)MbEnterpriseViewController* enterpriseVC;//企业通
@property(nonatomic,strong)MbTenderViewController* tenderVC;       //招标通
@property(nonatomic,strong)MbLoginViewController* loginVC;
@property(nonatomic,strong)NSMutableArray* list;

@property(nonatomic,strong)NSOperationQueue *myQueue;
@property(nonatomic,strong)NSString* userid;
@property(nonatomic,strong)UITabBarController* tabBarController;
@end

@implementation MbHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.images = [[NSArray alloc]init];
    self.images = @[@"主页景色.jpg",@"主页景色.jpg",@"主页景色.jpg"];
    self.list = [NSMutableArray array];
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    [self getBanner];
    [self onCreateScrollView];
    [self onCreatBtn];
}
-(void)getBanner{
    NSString* path = banner;
    NSString* encodedString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSession* session = [NSURLSession sharedSession];
  
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        self.list = [MbPaser paserBannerByDic:dic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self onCreateScrollView];
          
            for (int i = 0; i<self.list.count; i++) {
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.frame = CGRectMake(viewWidth*i, 0, viewWidth, viewWidth/2);
                //imageView.contentMode = UIViewContentModeScaleAspectFit;
                MbUserInfo* info = self.list[i];
                imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://haozhu.shiliuyun.net/%@",info.imageString]]]];
                
                [self.scrollView addSubview:imageView];
            }
            
        });
 
    }];
    [task resume];
    

   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"cityName"]) {
        [[MbDanli sharedManager] setCityName:@"北京"];
        UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithTitle:@"北京" style:UIBarButtonItemStyleDone target:self action:@selector(seleteCity)];
        self.navigationItem.leftBarButtonItem = leftBar;
    }else{
      
        UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"cityName"] style:UIBarButtonItemStyleDone target:self action:@selector(seleteCity)];
        self.navigationItem.leftBarButtonItem = leftBar;
        self.cityName = [[NSUserDefaults standardUserDefaults]objectForKey:@"cityName"];
        [[MbDanli sharedManager] setCityName:self.cityName];
    }
  
    
    self.hidesBottomBarWhenPushed = NO;

}
//创建轮播图
-(void)onCreateScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth/2)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    //内容的大小(整体大小）
    self.scrollView.contentSize = CGSizeMake(viewWidth * self.images.count,0);
    [self.view addSubview:self.scrollView];
    
    self.pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(viewWidth/2-50, viewWidth/2-20, 100, 0)];
    self.pageController.currentPageIndicatorTintColor = [UIColor colorWithRed:57/255.0 green:141/255.0 blue:227/255.0 alpha:1];
    self.pageController.pageIndicatorTintColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    self.pageController.numberOfPages = self.list.count;
    [self.view addSubview:self.pageController];
}
#pragma mark - UIScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageController.currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
}

//选择城市
-(void)seleteCity{
    self.cityList = [[MbCityListViewController alloc]init];
    self.cityList.hidesBottomBarWhenPushed = YES;
    self.cityList.homeVC = self;
    [self.navigationController pushViewController:self.cityList animated:YES];

}
//创建四个按钮
-(void)onCreatBtn{
    //找工作按钮
    self.button1 = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollView.frame)+15, (viewWidth-45)/2, (viewWidth-45)/3.1)];
    [self.button1 setBackgroundColor:[UIColor colorWithRed:43/255.0 green:223/255.0 blue:252/255.0 alpha:1]];
    [self.button1 addTarget:self action:@selector(findWork:) forControlEvents:UIControlEventTouchUpInside];
    self.button1.userInteractionEnabled = YES;
    self.button1.layer.cornerRadius = 5;
    self.button1.layer.masksToBounds = YES;
    [self.view addSubview:self.button1];
    //图片
    UIImageView* imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.button1.frame.size.width/2-self.button1.frame.size.height/6, self.button1.frame.size.height/5.4, self.button1.frame.size.height/3, self.button1.frame.size.height/3)];
    imageView1.image = [UIImage imageNamed:@"home_1_icon1.png"];
    //imageView1.contentMode = UIViewContentModeScaleAspectFill;
    [self.button1 addSubview:imageView1];
    //找工作
    UILabel* findWork = [[UILabel alloc]init];
    findWork.text = @"找工作";
    findWork.font = [UIFont systemFontOfSize:labelText+3];
    findWork.textColor = [UIColor whiteColor];
    CGSize findWorkSize = [findWork.text sizeWithFont:findWork.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    findWork.frame = CGRectMake(self.button1.frame.size.width/2-findWorkSize.width/2, CGRectGetMaxY(imageView1.frame)+12, findWorkSize.width, findWorkSize.height);
    [self.button1 addSubview:findWork];
    
    //看简历按钮
    self.button2 = [[UIButton alloc]initWithFrame:CGRectMake((viewWidth-45)/2+30, CGRectGetMaxY(self.scrollView.frame)+15, (viewWidth-45)/2, (viewWidth-45)/3.1)];
    [self.button2 setBackgroundColor:[UIColor colorWithRed:70/255.0 green:214/255.0 blue:202/255.0 alpha:1]];
    [self.button2 addTarget:self action:@selector(seeResume:) forControlEvents:UIControlEventTouchUpInside];
    self.button1.userInteractionEnabled = YES;
    self.button2.layer.cornerRadius = 5;
    self.button2.layer.masksToBounds = YES;
    [self.view addSubview:self.button2];
    
    //图片
    UIImageView* imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.button2.frame.size.width/2-self.button2.frame.size.height/6, self.button2.frame.size.height/5.4, self.button2.frame.size.height/3, self.button2.frame.size.height/3)];
    imageView2.image = [UIImage imageNamed:@"home_1_icon2.png"];
    [self.button2 addSubview:imageView2];
    //看简历
    UILabel* seeResume = [[UILabel alloc]init];
    seeResume.text = @"看简历";
    seeResume.font = [UIFont systemFontOfSize:labelText+3];
    seeResume.textColor = [UIColor whiteColor];
    CGSize seeResumeSize = [seeResume.text sizeWithFont:seeResume.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    seeResume.frame = CGRectMake(self.button2.frame.size.width/2-seeResumeSize.width/2, CGRectGetMaxY(imageView2.frame)+12, seeResumeSize.width, seeResumeSize.height);
    [self.button2 addSubview:seeResume];

    
    //企业通按钮
    self.button3 = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.button1.frame)+15, (viewWidth-45)/2, (viewWidth-45)/3.3)];
    [self.button3 setBackgroundColor:[UIColor colorWithRed:72/255.0 green:119/255.0 blue:255/255.0 alpha:1]];
    [self.button3 addTarget:self action:@selector(enterprise:) forControlEvents:UIControlEventTouchUpInside];
    self.button1.userInteractionEnabled = YES;
    self.button3.layer.cornerRadius = 5;
    self.button3.layer.masksToBounds = YES;
    [self.view addSubview:self.button3];
    
    //图片
    UIImageView* imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.button3.frame.size.width/2-self.button3.frame.size.height/6, self.button3.frame.size.height/5.4, self.button3.frame.size.height/3, self.button3.frame.size.height/3)];
    imageView3.image = [UIImage imageNamed:@"home_1_icon3.png"];
    [self.button3 addSubview:imageView3];
    //企业通
    UILabel* enterprise = [[UILabel alloc]init];
    enterprise.text = @"企业通";
    enterprise.font = [UIFont systemFontOfSize:labelText+3];
    enterprise.textColor = [UIColor whiteColor];
    CGSize enterpriseSize = [enterprise.text sizeWithFont:enterprise.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    enterprise.frame = CGRectMake(self.button3.frame.size.width/2-enterpriseSize.width/2, CGRectGetMaxY(imageView3.frame)+10, enterpriseSize.width, enterpriseSize.height);
    [self.button3 addSubview:enterprise];
    
    //招标通按钮
    self.button4 = [[UIButton alloc]initWithFrame:CGRectMake((viewWidth-45)/2+30, CGRectGetMaxY(self.button1.frame)+15, (viewWidth-45)/2, (viewWidth-45)/3.3)];
    [self.button4 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:84/255.0 blue:0 alpha:1]];
    [self.button4 addTarget:self action:@selector(tender:) forControlEvents:UIControlEventTouchUpInside];
    self.button1.userInteractionEnabled = YES;
    self.button4.layer.cornerRadius = 5;
    self.button4.layer.masksToBounds = YES;
    [self.view addSubview:self.button4];

    //图片
    UIImageView* imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(self.button4.frame.size.width/2-self.button4.frame.size.height/6, self.button4.frame.size.height/5.4, self.button4.frame.size.height/3, self.button4.frame.size.height/3)];
    imageView4.image = [UIImage imageNamed:@"home_1_icon4.png"];
    [self.button4 addSubview:imageView4];
    //招标通
    UILabel* tender = [[UILabel alloc]init];
    tender.text = @"招标通";
    tender.font = [UIFont systemFontOfSize:labelText+3];
    tender.textColor = [UIColor whiteColor];
    CGSize tenderSize = [tender.text sizeWithFont:tender.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
    tender.frame = CGRectMake(self.button4.frame.size.width/2-tenderSize.width/2, CGRectGetMaxY(imageView4.frame)+10, tenderSize.width, tenderSize.height);
    [self.button4 addSubview:tender];

}
//找工作按钮方法
-(void)findWork:(UIButton*)sender{

    self.findWorkVC = [[MbFindWorkViewController alloc]init];
    self.findWorkVC.hidesBottomBarWhenPushed = YES;
    self.loginVC = [[MbLoginViewController alloc]init];
    self.loginVC.hidesBottomBarWhenPushed = YES;
    if (self.cityName==nil) {
        self.findWorkVC.cityName = @"北京";
    }else{
    self.findWorkVC.cityName = self.cityName;
    self.findWorkVC.nameid = self.nameid;
    }
//    if (!self.userid) {
//        [self.navigationController pushViewController:self.loginVC animated:YES];
//    }else{
    [self.navigationController pushViewController:self.findWorkVC animated:YES];
//    }
}
//看简历按钮方法
-(void)seeResume:(UIButton*)sender{
    self.seeResumeVC = [[MbSeeResumeViewController alloc]init];
    self.seeResumeVC.hidesBottomBarWhenPushed = YES;
    self.loginVC = [[MbLoginViewController alloc]init];
    self.loginVC.hidesBottomBarWhenPushed = YES;
    if (self.cityName==nil) {
        self.seeResumeVC.cityName = @"北京";
    }else{
    self.seeResumeVC.cityName = self.cityName;
    self.seeResumeVC.nameid = self.nameid;
    }
//    if (!self.userid) {
//          [self.navigationController pushViewController:self.loginVC animated:YES];
//    }else{
    
    [self.navigationController pushViewController:self.seeResumeVC animated:YES];
//    }
}
//企业通按钮方法
-(void)enterprise:(UIButton*)sender{
    self.enterpriseVC = [[MbEnterpriseViewController alloc]init];
    self.enterpriseVC.hidesBottomBarWhenPushed = YES;
    self.loginVC = [[MbLoginViewController alloc]init];
    self.loginVC.hidesBottomBarWhenPushed = YES;
    if (self.cityName==nil) {
        self.enterpriseVC.cityName = @"北京";
    }else{
    self.enterpriseVC.cityName = self.cityName;
    self.enterpriseVC.nameid = self.nameid;
    }
    
//    if (!self.userid) {
//        [self.navigationController pushViewController:self.loginVC animated:YES];
//    }else{
    
    [self.navigationController pushViewController:self.enterpriseVC animated:YES];
//    }
}
//招标通按钮方法
-(void)tender:(UIButton*)sender{
    self.tenderVC = [[MbTenderViewController alloc]init];
    self.tenderVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.tenderVC animated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.cityName==nil) {
          [[MbDanli sharedManager] setCityName:@"北京"];
    }else{
    [[MbDanli sharedManager] setCityName:self.cityName];
    }
}
@end
