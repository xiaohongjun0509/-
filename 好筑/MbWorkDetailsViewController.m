//
//  MbWorkDetailsViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/23.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbWorkDetailsViewController.h"
#import "JZQCommon.h"
@interface MbWorkDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGSize textSize;
    CGSize textSize1;
    CGSize textSize2;
    CGSize textSize3;
}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UILabel* titleLabel;                //标题
@property(nonatomic,strong)UILabel* titleDetail;          //具体标题
@property(nonatomic,strong)UILabel* recruitment;          //招聘职位
@property(nonatomic,strong)UILabel* type;                 //类型
@property(nonatomic,strong)UILabel* company;              //公司名称
@property(nonatomic,strong)UILabel* dateLabel;            //日期
@property(nonatomic,strong)UILabel* companyField;     //输入公司名称
@property(nonatomic,strong)UIButton* recruitmentBtn;      //直招
@property(nonatomic,strong)UILabel* salary;               //薪资
@property(nonatomic,strong)UILabel* money;                //工资
@property(nonatomic,strong)UILabel* educationRequirement; //学历要求
@property(nonatomic,strong)UILabel* education;            //学历
@property(nonatomic,strong)UILabel* experienceRequirement; //经验要求
@property(nonatomic,strong)UILabel* years;                 //年限
@property(nonatomic,strong)UILabel* region;                //区域
@property(nonatomic,strong)UILabel* regionLabel;           //区域
@property(nonatomic,strong)UILabel* workLocation;          //工作地点
@property(nonatomic,strong)UILabel* place;                 //地区
@property(nonatomic,strong)UITextField* placeField;        //输入地点
@property(nonatomic,strong)UILabel* officeRequirement;     //任职要求
@property(nonatomic,strong)UILabel* requirement;           //具体要求
@property(nonatomic,strong)UILabel* companyIntroduction;   //公司简介
@property(nonatomic,strong)UILabel* introduction;          //公司具体简介
@property(nonatomic,strong)UILabel* contactPerson;         //联系人
@property(nonatomic,strong)UILabel* name;                  //联系人姓名
@property(nonatomic,strong)UILabel* telephone;             //电话
@property(nonatomic,strong)UILabel* telephoneNumber;       //号码
@property(nonatomic,strong)UILabel* confidential;          //保密
@property(nonatomic,strong)UIButton* applyBtn;             //申请按钮
@property(nonatomic,strong)UILabel* line1;
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
@property(nonatomic,strong)UILabel* text;
@property(nonatomic,strong)NSString* userid;
@property(nonatomic,strong)UILabel* comp;

@end

@implementation MbWorkDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"工作详情(北京)";
    self.view.backgroundColor = [UIColor whiteColor];
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    
    self.text = [UILabel new];
    self.text.text = @"测试详情";
    self.text.font = [UIFont systemFontOfSize:labelText];
    textSize = [self.text.text sizeWithFont:self.text.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    
    
    self.requirement = [[UILabel alloc]init];
    self.requirement.text = self.info.demand;
    self.requirement.font = [UIFont systemFontOfSize:labelText];
    textSize1 = [self.requirement.text sizeWithFont:self.requirement.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    
    self.introduction = [[UILabel alloc]init];
    self.introduction.text = self.info.aboutus;
    self.introduction.font = [UIFont systemFontOfSize:labelText];
    textSize2 = [self.introduction.text sizeWithFont:self.introduction.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];

    
    self.comp = [[UILabel alloc]init];
    self.comp.text = self.info.company;
    self.comp.numberOfLines = 0;
    self.comp.font = [UIFont systemFontOfSize:labelText];
    textSize3 = [self.comp.text sizeWithFont:self.comp.font constrainedToSize:CGSizeMake(viewWidth-76-textSize.width*2, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-27) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self judgeone];
   
    
    
}
-(void)judgeone{
    NSString* path = [NSString stringWithFormat:@"%@userid=%@&recruitmenid=%@",judge1,self.userid,self.info.recruitmenid];

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
 
    NSString* string = [dic objectForKey:@"collectionid"];
    if ([string isEqualToString:@"0"]) {
        UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_co_col.png"] style:UIBarButtonItemStyleDone target:self action:@selector(shoucang)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }else if ([string isEqualToString:@"1"]){
        UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_co_sel_col.png"] style:UIBarButtonItemStyleDone target:self action:@selector(shoucang1)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }

}
//收藏
-(void)shoucang{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{

    [MbPaser sendRecruitmenCollectByUserid:self.userid recruitmenid:self.info.recruitmenid result:^(RecruitmenCollectResponse *response, NSError *error) {
        if (response.message) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            [self judgeone];
        }
    }];
}
}
//已经收藏
-(void)shoucang1{
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        
    }
    if (indexPath.row==0) {
        //标题
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = @"       标题";
        self.titleLabel.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.titleLabel.font = [UIFont systemFontOfSize:labelText];
        CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.titleLabel.frame = CGRectMake(15, 15, titleSize.width, titleSize.height);
        [cell addSubview:self.titleLabel];
        
        self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+15, 10, 1, self.titleLabel.frame.size.height+10)];
        self.line1.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line1];
        
        self.titleDetail = [[UILabel alloc]init];
        self.titleDetail.text = self.info.title;
        self.titleDetail.font = [UIFont systemFontOfSize:labelText];
        self.titleDetail.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.titleDetail.frame = CGRectMake(CGRectGetMaxX(self.line1.frame)+15, 15, viewWidth-61-titleSize.width, titleSize.height);
        [cell addSubview:self.titleDetail];
        
       
    }else if (indexPath.row==1){
        //招聘职位
//        self.recruitment = [UILabel new];
//        self.recruitment.text = @"招聘职位";
//        self.recruitment.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
//        self.recruitment.font = [UIFont systemFontOfSize:labelText];
//        CGSize recruitmentSize = [self.recruitment.text sizeWithFont:self.recruitment.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
//        self.recruitment.frame = CGRectMake(15, 15, recruitmentSize.width, recruitmentSize.height);
//        [cell addSubview:self.recruitment];
        
//        self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.recruitment.frame)+15, 10, 1, self.recruitment.frame.size.height+10)];
//        self.line2.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
//        [cell addSubview:self.line2];
        
        self.type = [[UILabel alloc]init];
        self.type.text = self.info.position;
        self.type.font = [UIFont systemFontOfSize:labelText];
        self.type.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        CGSize typeSize = [self.type.text sizeWithFont:self.type.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
       
        
        //更新日期
        self.dateLabel = [[UILabel alloc]init];
        NSTimeInterval time=[self.info.rectime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];


        self.dateLabel.text = [NSString stringWithFormat:@"%@更新",currentDateStr];
        self.dateLabel.font = [UIFont systemFontOfSize:labelText-1];
        self.dateLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
        CGSize dateSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.dateLabel.frame = CGRectMake(viewWidth-15-dateSize.width, 15, dateSize.width, typeSize.height);
        
        self.type.frame = CGRectMake(15, 15, viewWidth - 62 -dateSize.width, typeSize.height);
        [cell addSubview:self.type];
        
        [cell addSubview:self.dateLabel];
    
    }else if (indexPath.row==2){
    //公司名称
        self.company = [UILabel new];
        self.company.text = @"公司名称";
        self.company.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.company.font = [UIFont systemFontOfSize:labelText];
        CGSize companySize = [self.company.text sizeWithFont:self.company.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.company.frame = CGRectMake(15, 15, companySize.width, companySize.height);
//        [cell addSubview:self.company];
        
   
        
                //输入公司名称
        self.companyField = [[UILabel alloc]init];
        
        self.companyField.text = self.info.company;
        self.companyField.numberOfLines = 0;
//        self.companyField.placeholder = @"请输入公司名称";
        [self.companyField setFont:[UIFont systemFontOfSize:labelText]];
        self.companyField.frame = CGRectMake(15, 15, viewWidth-76, textSize3.height);
        [cell addSubview:self.companyField];
        //直招
        self.recruitmentBtn = [[UIButton alloc]init];
        if ([self.info.ways isEqualToString:@"1"]) {
            [self.recruitmentBtn setTitle:@"直招" forState:UIControlStateNormal];
        }else if ([self.info.ways isEqualToString:@"2"]){
            [self.recruitmentBtn setTitle:@"代招" forState:UIControlStateNormal];
            
        }
        
        [self.recruitmentBtn setBackgroundColor:[UIColor colorWithRed:51/255.0  green:142/255.0 blue:221/255.0 alpha:1]];
        [self.recruitmentBtn setFont:[UIFont systemFontOfSize:labelText]];
        [self.recruitmentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
        self.recruitmentBtn.layer.cornerRadius = 3;
        self.recruitmentBtn.layer.masksToBounds = YES;
        

        if (textSize3.height>companySize.height) {
            self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.company.frame)+15, 10, 1, textSize3.height)];
            
         
             self.recruitmentBtn.frame = CGRectMake(viewWidth-15-companySize.width, (textSize3.height+20)/2 - (companySize.height+10)/2, companySize.width, companySize.height+10);
        }else{
//            self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.company.frame)+15, 10, 1, self.company.frame.size.height+10)];
        
            
             self.recruitmentBtn.frame = CGRectMake(viewWidth-15-companySize.width, 10, companySize.width, companySize.height+10);
        
        }
        self.line3.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line3];
        [cell addSubview:self.recruitmentBtn];
        
    
    }else if (indexPath.row==3){
        //薪资待遇
        self.salary = [UILabel new];
        self.salary.text = @"薪资待遇";
        self.salary.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.salary.font = [UIFont systemFontOfSize:labelText];
        CGSize salarySize = [self.salary.text sizeWithFont:self.salary.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.salary.frame = CGRectMake(15, 15, salarySize.width, salarySize.height);
        [cell addSubview:self.salary];
        
        self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.salary.frame)+15, 10, 1, self.salary.frame.size.height+10)];
        self.line4.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line4];
        
        //工资
        self.money = [UILabel new];
        self.money.text = self.info.wages;
        self.money.font = [UIFont systemFontOfSize:labelText];
        self.money.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        CGSize moneySize = [self.money.text sizeWithFont:self.money.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.money.frame = CGRectMake(CGRectGetMaxX(self.line4.frame)+15, 15, moneySize.width, moneySize.height);
        [cell addSubview:self.money];
        
    }else if (indexPath.row==4){
        //学历要求
        self.educationRequirement = [UILabel new];
        self.educationRequirement.text = @"学历要求";
        self.educationRequirement.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.educationRequirement.font = [UIFont systemFontOfSize:labelText];
        CGSize educationRequirementSize = [self.educationRequirement.text sizeWithFont:self.educationRequirement.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.educationRequirement.frame = CGRectMake(15, 15, educationRequirementSize.width, educationRequirementSize.height);
        [cell addSubview:self.educationRequirement];
        
        self.line5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.educationRequirement.frame)+15, 10, 1, self.educationRequirement.frame.size.height+10)];
        self.line5.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line5];
        
        //学历
        self.education = [UILabel new];
        self.education.text = self.info.diploma;
        self.education.font = [UIFont systemFontOfSize:labelText];
        self.education.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        CGSize educationSize = [self.education.text sizeWithFont:self.education.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.education.frame = CGRectMake(CGRectGetMaxX(self.line5.frame)+15, 15, educationSize.width, educationSize.height);
        [cell addSubview:self.education];
        
    }else if (indexPath.row==5){
        //经验要求
        self.experienceRequirement = [UILabel new];
        self.experienceRequirement.text = @"经验要求";
        self.experienceRequirement.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.experienceRequirement.font = [UIFont systemFontOfSize:labelText];
        CGSize experienceRequirementSize = [self.experienceRequirement.text sizeWithFont:self.experienceRequirement.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.experienceRequirement.frame = CGRectMake(15, 15, experienceRequirementSize.width, experienceRequirementSize.height);
        [cell addSubview:self.experienceRequirement];
        
        self.line6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.experienceRequirement.frame)+15, 10, 1, self.experienceRequirement.frame.size.height+10)];
        self.line6.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line6];
        //年限
        self.years = [UILabel new];
        self.years.text = self.info.experience;
        self.years.font = [UIFont systemFontOfSize:labelText];
        self.years.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        CGSize yearsSize = [self.years.text sizeWithFont:self.years.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.years.frame = CGRectMake(CGRectGetMaxX(self.line6.frame)+15, 15, yearsSize.width, yearsSize.height);
        [cell addSubview:self.years];
    }else if (indexPath.row==6){
    
        //区域
        self.region = [[UILabel alloc]init];
        self.region.text = @"       区域";
        self.region.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.region.font = [UIFont systemFontOfSize:labelText];
        CGSize regionSize = [self.region.text sizeWithFont:self.region.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.region.frame = CGRectMake(15, 15, regionSize.width, regionSize.height);
        [cell addSubview:self.region];
        
        self.line7 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.region.frame)+15, 10, 1, self.region.frame.size.height+10)];
        self.line7.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line7];
        
        self.regionLabel = [[UILabel alloc]init];
        self.regionLabel.text = self.info.area;
       
        self.regionLabel.font = [UIFont systemFontOfSize:labelText];
        self.regionLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.regionLabel.frame = CGRectMake(CGRectGetMaxX(self.line7.frame)+15, 15, viewWidth-61-regionSize.width, regionSize.height);
        [cell addSubview:self.regionLabel];

        
    
    }else if (indexPath.row==7){
        //工作地点
        self.workLocation = [UILabel new];
        self.workLocation.text = @"工作地点";
        self.workLocation.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.workLocation.font = [UIFont systemFontOfSize:labelText];
        CGSize experienceRequirementSize = [self.workLocation.text sizeWithFont:self.workLocation.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.workLocation.frame = CGRectMake(15, 15, experienceRequirementSize.width, experienceRequirementSize.height);
        [cell addSubview:self.workLocation];
        
        self.line8 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workLocation.frame)+15, 10, 1, self.workLocation.frame.size.height+10)];
        self.line8.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line8];
        
        
        //地区
        self.place = [UILabel new];
        self.place.text = self.info.address;
        self.place.font = [UIFont systemFontOfSize:labelText];
        self.place.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        CGSize placeSize = [self.place.text sizeWithFont:self.place.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.place.frame = CGRectMake(CGRectGetMaxX(self.line8.frame)+15, 15, placeSize.width, placeSize.height);
        [cell addSubview:self.place];
        
    }else if (indexPath.row==8){
        //任职要求
        self.officeRequirement = [UILabel new];
        self.officeRequirement.text = @"任职要求";
        self.officeRequirement.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.officeRequirement.font = [UIFont systemFontOfSize:labelText];
        CGSize officeRequirementSize = [self.officeRequirement.text sizeWithFont:self.officeRequirement.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.officeRequirement.frame = CGRectMake(15, 15, officeRequirementSize.width, officeRequirementSize.height);
        [cell addSubview:self.officeRequirement];
        
        
        
        //具体要求
        self.requirement = [UILabel new];
        self.requirement.text = self.info.demand;
        self.requirement.numberOfLines = 0;
        self.requirement.font = [UIFont systemFontOfSize:labelText];
        self.requirement.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        CGSize requirementSize = [self.requirement.text sizeWithFont:self.requirement.font constrainedToSize:CGSizeMake(viewWidth-61-officeRequirementSize.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        
        
        if (requirementSize.height>officeRequirementSize.height+30) {
             self.line9 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.officeRequirement.frame)+15, 10, 1, requirementSize.height+10)];
        }else{
        
         self.line9 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.officeRequirement.frame)+15, 10, 1, requirementSize.height+10)];
        }
       
        self.line9.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line9];
        
        
       
        
        self.requirement.frame = CGRectMake(CGRectGetMaxX(self.line9.frame)+15, 15, requirementSize.width, requirementSize.height);
        [cell addSubview:self.requirement];
    
        
    }else if (indexPath.row==9){
        //公司简介
        self.companyIntroduction = [UILabel new];
        self.companyIntroduction.text = @"公司简介";
        self.companyIntroduction.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.companyIntroduction.font = [UIFont systemFontOfSize:labelText];
        CGSize companyIntroductionSize = [self.companyIntroduction.text sizeWithFont:self.companyIntroduction.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.companyIntroduction.frame = CGRectMake(15, 15, companyIntroductionSize.width, companyIntroductionSize.height);
        [cell addSubview:self.companyIntroduction];
        
        
        //公司具体简介
        self.introduction = [UILabel new];
        self.introduction.text = self.info.aboutus;
        self.introduction.numberOfLines = 0;
        //根据控件大小改变字体大小
        //self.introduction.adjustsFontSizeToFitWidth = YES;
        self.introduction.font = [UIFont systemFontOfSize:labelText];
        self.introduction.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
     
        
        
        CGSize introductionSize = [self.introduction.text sizeWithFont:self.introduction.font constrainedToSize:CGSizeMake(viewWidth-61-companyIntroductionSize.width, 1000) lineBreakMode:NSLineBreakByCharWrapping];
        
        if (introductionSize.height>companyIntroductionSize.height+30) {
              self.line10 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.companyIntroduction.frame)+15, 10, 1, introductionSize.height+10)];
        }else{
         self.line10 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.companyIntroduction.frame)+15, 10, 1, introductionSize.height+10)];
        
        }
      
        self.line10.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line10];
        
        
       
        self.introduction.frame = CGRectMake(CGRectGetMaxX(self.line10.frame)+15, 15, introductionSize.width, introductionSize.height);
        [cell addSubview:self.introduction];
        
    }else if (indexPath.row==10){
        //联系人
        self.contactPerson = [UILabel new];
        self.contactPerson.text = @"   联系人";
        self.contactPerson.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.contactPerson.font = [UIFont systemFontOfSize:labelText];
        CGSize contactPersonSize = [self.contactPerson.text sizeWithFont:self.contactPerson.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.contactPerson.frame = CGRectMake(15, 15, contactPersonSize.width, contactPersonSize.height);
        [cell addSubview:self.contactPerson];
        
        self.line11 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contactPerson.frame)+16, 10, 1, self.contactPerson.frame.size.height+10)];
        self.line11.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line11];
    
        
        //姓名
        self.name = [UILabel new];
        self.name.text = self.info.linkman;
        self.name.font = [UIFont systemFontOfSize:labelText];
        self.name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        CGSize nameSize = [self.name.text sizeWithFont:self.name.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.name.frame = CGRectMake(CGRectGetMaxX(self.line11.frame)+15, 15, nameSize.width, nameSize.height);
        [cell addSubview:self.name];
        
    }else if (indexPath.row==11){
    
        //电话
        self.telephone = [UILabel new];
        self.telephone.text = @"      电话";
        self.telephone.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        self.telephone.font = [UIFont systemFontOfSize:labelText];
        CGSize telephoneSize = [self.telephone.text sizeWithFont:self.telephone.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.telephone.frame = CGRectMake(15, 15, telephoneSize.width, telephoneSize.height);
        [cell addSubview:self.telephone];
        
        self.line12 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.telephone.frame)+16, 10, 1, self.telephone.frame.size.height+10)];
        self.line12.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [cell addSubview:self.line12];
        
        //电话号码
        self.telephoneNumber = [UILabel new];
        self.telephoneNumber.text = self.info.phone;
        self.telephoneNumber.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.telephoneNumber.font = [UIFont systemFontOfSize:labelText];
        CGSize telephoneNumberSize = [self.telephoneNumber.text sizeWithFont:self.telephoneNumber.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
        self.telephoneNumber.frame = CGRectMake(CGRectGetMaxX(self.line12.frame)+15, 15, telephoneNumberSize.width, telephoneNumberSize.height);
        [cell addSubview:self.telephoneNumber];
        //保密
//        self.confidential = [UILabel new];
//        self.confidential.text = @"保密";
//        self.confidential.font = [UIFont systemFontOfSize:labelText];
//        self.confidential.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//        CGSize confidentialSize = [self.confidential.text sizeWithFont:self.confidential.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
//        self.confidential.frame = CGRectMake(CGRectGetMaxX(self.telephoneNumber.frame)+5, self.telephone.frame.origin.y, confidentialSize.width, confidentialSize.height);
//        [cell addSubview:self.confidential];
        
    }else if (indexPath.row==12){
    //申请按钮
        self.applyBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/2-viewWidth/6, 15, viewWidth/3, 30)];
        [self.applyBtn setBackgroundColor:[UIColor colorWithRed:0 green:193/255.0 blue:90/255.0 alpha:1]];
        self.applyBtn.userInteractionEnabled = YES;
        [self.applyBtn addTarget:self action:@selector(apply:) forControlEvents:UIControlEventTouchUpInside];
        self.applyBtn.layer.cornerRadius = 15;
        self.applyBtn.layer.masksToBounds = YES;
        [cell addSubview:self.applyBtn];
        
        UIImageView* callImage = [[UIImageView alloc]initWithFrame:CGRectMake(13, 5, 20, 20)];
        callImage.image = [UIImage imageNamed:@"home_icon_call.png"];
        [self.applyBtn addSubview:callImage];
        
        UILabel* applyLabel = [[UILabel alloc]init];
        applyLabel.text = @"申请职位";
        applyLabel.font = [UIFont systemFontOfSize:14];
        applyLabel.textColor = [UIColor whiteColor];
        CGSize applySize = [applyLabel.text sizeWithFont:applyLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        applyLabel.frame = CGRectMake(CGRectGetMaxX(callImage.frame)+5, 15-applySize.height/2, applySize.width, applySize.height);
        [self.applyBtn addSubview:applyLabel];
    }
    //分割线顶头
    //[cell setSeparatorInset:UIEdgeInsetsZero];
    //[cell setLayoutMargins:UIEdgeInsetsZero];
    //[cell setPreservesSuperviewLayoutMargins:NO];
    //无选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<2) {
        return textSize.height+30;
    }else if (indexPath.row==2){
        if (textSize3.height>textSize.height) {
          return textSize3.height + 20;
        }else
            return textSize.height + 30;
    }else if (indexPath.row>2&&indexPath.row<7){
        
        return textSize.height+30;
        
    }else if (indexPath.row==8){
  
        return textSize1.height+30;
    }else if (indexPath.row==9){
    
    return textSize2.height+30;
    
    }else if (indexPath.row==10){
    
    return textSize.height+30;
    }else if (indexPath.row==11){
    
        return textSize.height+30;
    }
    return 66;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.00001;
    }else
        return 0.000001;

}
//申请
-(void)apply:(UIButton*)sender{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.info.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
  
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-850-8888"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}
@end
