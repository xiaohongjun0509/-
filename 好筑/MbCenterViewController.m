//
//  MbCenterViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/22.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbCenterViewController.h"
#import "JZQCommon.h"
#import "MbMyCollectionViewController.h"
#import "MbLoginViewController.h"
#import "MbReViewController.h"
#import "MbLoginedViewController.h"
@interface MbCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* titles;
@property(nonatomic,strong)NSArray* images;
@property(nonatomic,strong)MbMyCollectionViewController* myCollect;   //我的收藏页面
@property(nonatomic,strong)MbLoginViewController* loginVC;            //登陆界面
@property(nonatomic,strong)MbLoginedViewController* loginedVC;        //已登录界面
@property(nonatomic,strong)MbReViewController* myReVC;                //我的发布
@property(nonatomic,strong)NSString* userid;
@end

@implementation MbCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户中心";
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    self.titles = @[@"我的账号",@"我的发布",@"我的收藏"];
    self.images = @[@"home_7_uc1.png",@"home_7_uc2.png",@"home_7_uc3.png"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *nItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = nItem;
    //self.navigationItem.hidesBackButton =YES;
      self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}
-(void)back{


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titles.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString* identifire = @"Cell";
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
    if (indexPath.row==0) {
        cell.imageView.image = [UIImage imageNamed:@"home_7_uc3.png"];
    }else if (indexPath.row==1){
    cell.imageView.image = [UIImage imageNamed:@"home_7_uc2.png"];
    
    }else if (indexPath.row==2){
    cell.imageView.image = [UIImage imageNamed:@"home_7_uc1.png"];
    
    }
    //cell分割线两边顶头
    //[cell setSeparatorInset:UIEdgeInsetsZero];
    //[cell setLayoutMargins:UIEdgeInsetsZero];
    //[cell setPreservesSuperviewLayoutMargins:NO];

    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 15;
    }
    return 0.0000001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
           
            self.loginVC = [[MbLoginViewController alloc]init];
            self.loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:self.loginVC animated:YES];
        }else{
            self.loginedVC = [[MbLoginedViewController alloc]init];
            self.loginedVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:self.loginedVC animated:YES];
        
        
        }

    }else if (indexPath.row==1){
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
        
        self.myReVC = [[MbReViewController alloc]init];
        self.myReVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:self.myReVC animated:YES];
        }
    }else if (indexPath.row==2){
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
        self.myCollect = [[MbMyCollectionViewController alloc]init];
        self.myCollect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:self.myCollect animated:YES];
        }
    }

}
@end
