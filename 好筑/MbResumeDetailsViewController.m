//
//  MbResumeDetailsViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/23.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbResumeDetailsViewController.h"
#import "JZQCommon.h"
@interface MbResumeDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGSize textSize;
    CGSize textSize1;
    CGSize textSize2;
    CGSize textSize3;
    CGSize textSize4;
}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UILabel* titleLabel;           //标题
@property(nonatomic,strong)UILabel* titleDetail;          //具体标题
@property(nonatomic,strong)UILabel* name;                 //姓名
@property(nonatomic,strong)UILabel* sex;                  //性别
@property(nonatomic,strong)UILabel* age;                  //年龄
@property(nonatomic,strong)UILabel* dateLabel;            //日期
@property(nonatomic,strong)UILabel* workingExperience;    //工作经验
@property(nonatomic,strong)UILabel* years;                //年限
@property(nonatomic,strong)UILabel* educationRequirement; //学历要求
@property(nonatomic,strong)UILabel* education;            //学历
@property(nonatomic,strong)UILabel* educationLevel;       //学历类别
@property(nonatomic,strong)UILabel* jobIntention;         //求职意向
@property(nonatomic,strong)UILabel* type;                 //建造师
@property(nonatomic,strong)UILabel* salary;               //薪资
@property(nonatomic,strong)UILabel* money;                //工资
@property(nonatomic,strong)UILabel* yeartoyear;           //教育时间
@property(nonatomic,strong)UILabel* school;               //学校
@property(nonatomic,strong)UILabel* schoolLabel;          //学校名称
@property(nonatomic,strong)UILabel* professional;         //专业
@property(nonatomic,strong)UILabel* professionalType;     //什么专业
@property(nonatomic,strong)UILabel* eduExperience;        //教育经历
@property(nonatomic,strong)UILabel* eduExperienceDetail;  //教育经历描述
@property(nonatomic,strong)UILabel* workExperience;       //工作经历
@property(nonatomic,strong)UILabel* workExperienceDetail; //工作经历描述

@property(nonatomic,strong)UILabel* company;              //公司
@property(nonatomic,strong)UILabel* position;             //职位
@property(nonatomic,strong)UILabel* content;              //工作内容


@property(nonatomic,strong)UILabel* selfIntroduction;     //自我介绍
@property(nonatomic,strong)UILabel* introduction;         //具体介绍
@property(nonatomic,strong)UIButton* applyBtn;             //申请按钮
@property(nonatomic,strong)UILabel* line1;
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UILabel* line5;
@property(nonatomic,strong)UILabel* line6;
@property(nonatomic,strong)UILabel* line7;
@property(nonatomic,strong)UILabel* text;
@property(nonatomic,strong)UILabel* worktoyear;          //工作时间
@property(nonatomic,strong)UILabel* companyLabel;        //公司名称
@property(nonatomic,strong)UILabel* typeLabel;           //职位
@property(nonatomic,strong)NSString* userid;

@end

@implementation MbResumeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"简历详情(北京)";
    self.view.backgroundColor = [UIColor whiteColor];
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    
    self.text = [UILabel new];
    self.text.text = @"测试详情";
    self.text.font = [UIFont systemFontOfSize:labelText];
    textSize = [self.text.text sizeWithFont:self.text.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    
  
    
    
    
    self.introduction = [[UILabel alloc]init];
    self.introduction.text = self.info.intruduction;
    self.introduction.font = [UIFont systemFontOfSize:labelText];
    textSize2 = [self.introduction.text sizeWithFont:self.introduction.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
   
    for (int i = 0; i<self.info.business.count; i++) {
        self.info.content = [self.info.business[i] objectForKey:@"content"];
        textSize3 = [self.info.content sizeWithFont:self.introduction.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    

    
      textSize4 = [self.introduction.text sizeWithFont:self.introduction.font constrainedToSize:CGSizeMake(viewWidth-61-textSize.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;
    
    [self judgetwo];
    
}
-(void)judgetwo{
    NSString* path = [NSString stringWithFormat:@"%@userid=%@&resumeid=%@",judge2,self.userid,self.info.resumeid];
    
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
//收藏按钮
-(void)shoucang{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
    
[MbPaser sendResumeCollectByUserid:self.userid resumeid:self.info.resumeid result:^(ResumeidCollectResponse *response, NSError *error) {
    if (response.message) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [self judgetwo];
    }
    
    
}];
    }

}
//已经收藏
-(void)shoucang1{



}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 6;
    }else if (section==1){
       
       
        if (!self.info.experienced.count) {
            return 1;
        }else{
            return self.info.experienced.count;
        
        }
    
    }else if (section==2){
    
        if (self.info.business.count==0) {
            return 1;
        }else{
            return self.info.business.count;
        
        }
    
    }else
    return 2;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString* identifire = @"Cell";
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        
    }
    if (indexPath.section==0) {
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
            //姓名
            self.name = [UILabel new];
            self.name.text = self.info.username;
         

            self.name.font = [UIFont systemFontOfSize:labelText];
            self.name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize nameSize = [self.name.text sizeWithFont:self.name.font constrainedToSize:CGSizeMake(200, 100) lineBreakMode:NSLineBreakByWordWrapping];
            if (nameSize.width>60) {
               self.name.frame = CGRectMake(15, 15, 60, nameSize.height);
            }else{
            self.name.frame = CGRectMake(15, 15, nameSize.width, nameSize.height);
            }
            
            [cell addSubview:self.name];
            //性别
            
            self.sex = [UILabel new];
            if (self.info.sex==1) {
                self.sex.text = @"男";
            }else if (self.info.sex==2){
                
                self.sex.text = @"女";
            }
            
            self.sex.font = [UIFont systemFontOfSize:labelText];
            self.sex.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize sexSize = [self.sex.text sizeWithFont:self.sex.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
            self.sex.frame = CGRectMake(CGRectGetMaxX(self.name.frame)+30, 15, sexSize.width, sexSize.height);
            [cell addSubview:self.sex];
            //年龄
            self.age = [UILabel new];
            self.age.text = [NSString stringWithFormat:@"%d岁",self.info.age];
            self.age.font = [UIFont systemFontOfSize:labelText];
            self.age.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize ageSize = [self.age.text sizeWithFont:self.age.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
            self.age.frame = CGRectMake(CGRectGetMaxX(self.sex.frame)+30, 15, ageSize.width, ageSize.height);
            [cell addSubview:self.age];
            //日期
            self.dateLabel = [UILabel new];
            
            NSTimeInterval time=[self.info.restime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
            NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            
            //实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
            
            self.dateLabel.text = [NSString stringWithFormat:@"%@更新",currentDateStr];
            self.dateLabel.font = [UIFont systemFontOfSize:labelText-1];
            self.dateLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
            CGSize dateLabelSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.dateLabel.frame = CGRectMake(viewWidth-15-dateLabelSize.width, 15, dateLabelSize.width, dateLabelSize.height);
            [cell addSubview:self.dateLabel];
            
        }else if (indexPath.row==2){
            //工作经验
            self.workingExperience = [[UILabel alloc]init];
            self.workingExperience.text = @"工作经验";
            self.workingExperience.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
            self.workingExperience.font = [UIFont systemFontOfSize:labelText];
            CGSize workingExperienceSize = [self.workingExperience.text sizeWithFont:self.workingExperience.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.workingExperience.frame = CGRectMake(15, 15, workingExperienceSize.width, workingExperienceSize.height);
            [cell addSubview:self.workingExperience];
            
            self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workingExperience.frame)+15, 10, 1, self.workingExperience.frame.size.height+10)];
            self.line2.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
            [cell addSubview:self.line2];
            
            self.years = [[UILabel alloc]init];
            self.years.text = self.info.suffer;
            
            self.years.font = [UIFont systemFontOfSize:labelText];
            self.years.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize yearsSize = [self.years.text sizeWithFont:self.years.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.years.frame = CGRectMake(CGRectGetMaxX(self.line2.frame)+15, 15, yearsSize.width, yearsSize.height);
            [cell addSubview:self.years];
        }else if (indexPath.row==3){
            //学历
            self.educationRequirement = [[UILabel alloc]init];
            self.educationRequirement.text = @"       学历";
            self.educationRequirement.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
            self.educationRequirement.font = [UIFont systemFontOfSize:labelText];
            CGSize educationRequirementSize = [self.educationRequirement.text sizeWithFont:self.educationRequirement.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.educationRequirement.frame = CGRectMake(15, 15, educationRequirementSize.width, educationRequirementSize.height);
            [cell addSubview:self.educationRequirement];
            
            self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.educationRequirement.frame)+15, 10, 1, self.educationRequirement.frame.size.height+10)];
            self.line3.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
            [cell addSubview:self.line3];
            
            self.education = [[UILabel alloc]init];
            self.education.text = self.info.diploma;
            self.education.font = [UIFont systemFontOfSize:labelText];
            self.education.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize educationSize = [self.education.text sizeWithFont:self.education.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.education.frame = CGRectMake(CGRectGetMaxX(self.line3.frame)+15, 15, educationSize.width, educationSize.height);
            [cell addSubview:self.education];
        }else if (indexPath.row==4){
            //求职意向
            self.jobIntention = [[UILabel alloc]init];
            self.jobIntention.text = @"求职意向";
            self.jobIntention.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
            self.jobIntention.font = [UIFont systemFontOfSize:labelText];
            CGSize jobIntentionSize = [self.jobIntention.text sizeWithFont:self.jobIntention.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.jobIntention.frame = CGRectMake(15, 15, jobIntentionSize.width, jobIntentionSize.height);
            [cell addSubview:self.jobIntention];
            
            self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jobIntention.frame)+15, 10, 1, self.jobIntention.frame.size.height+10)];
            self.line4.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
            [cell addSubview:self.line4];
            
            self.type = [[UILabel alloc]init];
            self.type.text = self.info.position;
            self.type.font = [UIFont systemFontOfSize:labelText];
            self.type.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize typeSize = [self.type.text sizeWithFont:self.type.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.type.frame = CGRectMake(CGRectGetMaxX(self.line4.frame)+15, 15, typeSize.width, typeSize.height);
        
            [cell addSubview:self.type];
        }else if (indexPath.row==5){
            //期望薪资
            self.salary = [[UILabel alloc]init];
            self.salary.text = @"期望薪资";
            self.salary.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
            self.salary.font = [UIFont systemFontOfSize:labelText];
            CGSize salarySize = [self.salary.text sizeWithFont:self.salary.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.salary.frame = CGRectMake(15, 15, salarySize.width, salarySize.height);
            [cell addSubview:self.salary];
            
            self.line5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.salary.frame)+15, 10, 1, self.salary.frame.size.height+10)];
            self.line5.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
            [cell addSubview:self.line5];
            
            self.money = [[UILabel alloc]init];
            self.money.text = self.info.wages;
            self.money.font = [UIFont systemFontOfSize:labelText];
            self.money.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize moneySize = [self.money.text sizeWithFont:self.money.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.money.frame = CGRectMake(CGRectGetMaxX(self.line5.frame)+15, 15, moneySize.width, moneySize.height);
            [cell addSubview:self.money];
        }
    }else if (indexPath.section==1){
        if (self.info.experienced.count==0){
            //教育经历
            self.eduExperience = [[UILabel alloc]init];
            self.eduExperience.text = @"教育经历";
            self.eduExperience.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
            self.eduExperience.font = [UIFont systemFontOfSize:labelText];
            CGSize eduExperienceSize = [self.eduExperience.text sizeWithFont:self.eduExperience.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.eduExperience.frame = CGRectMake(15, 15, eduExperienceSize.width, eduExperienceSize.height);
            [cell addSubview:self.eduExperience];
            
            self.line6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.eduExperience.frame)+15, 10, 1, self.eduExperience.frame.size.height+10)];
            self.line6.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
            [cell addSubview:self.line6];
            
            self.eduExperienceDetail = [[UILabel alloc]init];
            self.eduExperienceDetail.text = @"未填写";
            self.eduExperienceDetail.font = [UIFont systemFontOfSize:labelText];
            self.eduExperienceDetail.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize eduExperienceDetailSize = [self.eduExperienceDetail.text sizeWithFont:self.eduExperienceDetail.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.eduExperienceDetail.frame = CGRectMake(CGRectGetMaxX(self.line6.frame)+15, 15, eduExperienceDetailSize.width, eduExperienceDetailSize.height);
            [cell addSubview:self.eduExperienceDetail];
            
        }else{
        
        
        
            //教育时间
        self.info.intervalstart = [self.info.experienced[indexPath.row] objectForKey:@"intervalstart"];
        self.info.intervalstop = [self.info.experienced[indexPath.row] objectForKey:@"intervalstop"];
        self.info.level = [self.info.experienced[indexPath.row] objectForKey:@"level"];
        self.info.school = [self.info.experienced[indexPath.row] objectForKey:@"school"];
        self.info.specialty = [self.info.experienced[indexPath.row] objectForKey:@"specialty"];

        
            self.yeartoyear = [UILabel new];
            self.yeartoyear.text = [NSString stringWithFormat:@"%@-%@",self.info.intervalstart,self.info.intervalstop];
            self.yeartoyear.font = [UIFont systemFontOfSize:labelText];
            self.yeartoyear.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize yeartoyearSize = [self.yeartoyear.text sizeWithFont:self.yeartoyear.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.yeartoyear.frame = CGRectMake(15, 15, yeartoyearSize.width, yeartoyearSize.height);
            [cell addSubview:self.yeartoyear];
            //学校
            self.school = [UILabel new];
            self.school.text = @"学校";
            self.school.font = [UIFont systemFontOfSize:labelText];
            self.school.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize schoolSize = [self.school.text sizeWithFont:self.school.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.school.frame = CGRectMake(15, CGRectGetMaxY(self.yeartoyear.frame)+10, schoolSize.width, schoolSize.height);
            [cell addSubview:self.school];
            
            self.schoolLabel = [UILabel new];
            self.schoolLabel.text = self.info.school;
            self.schoolLabel.font = [UIFont systemFontOfSize:labelText];
            self.schoolLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize schoolLabelSize = [self.schoolLabel.text sizeWithFont:self.schoolLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.schoolLabel.frame = CGRectMake(CGRectGetMaxX(self.school.frame)+20, self.school.frame.origin.y, schoolLabelSize.width, schoolLabelSize.height);
            [cell addSubview:self.schoolLabel];
            //学历
            self.education = [UILabel new];
            self.education.text = @"学历";
            self.education.font = [UIFont systemFontOfSize:labelText];
            self.education.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize educationSize = [self.education.text sizeWithFont:self.education.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.education.frame = CGRectMake(15, CGRectGetMaxY(self.school.frame)+10, educationSize.width, educationSize.height);
            [cell addSubview:self.education];
            
            self.educationLevel = [UILabel new];
            self.educationLevel.text = self.info.level;
            self.educationLevel.font = [UIFont systemFontOfSize:labelText];
            self.educationLevel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize educationLevelSize = [self.educationLevel.text sizeWithFont:self.educationLevel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.educationLevel.frame = CGRectMake(CGRectGetMaxX(self.education.frame)+20, self.education.frame.origin.y, educationLevelSize.width, educationLevelSize.height);
            [cell addSubview:self.educationLevel];
            //专业
            self.professional = [UILabel new];
            self.professional.text = @"专业";
            self.professional.font = [UIFont systemFontOfSize:labelText];
            self.professional.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize professionalSize = [self.professional.text sizeWithFont:self.professional.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.professional.frame = CGRectMake(15, CGRectGetMaxY(self.education.frame)+10, professionalSize.width, professionalSize.height);
            [cell addSubview:self.professional];
            
            self.professionalType = [UILabel new];
            self.professionalType.text = self.info.specialty;
            self.professionalType.font = [UIFont systemFontOfSize:labelText];
            self.professionalType.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize professionalTypeSize = [self.professionalType.text sizeWithFont:self.professionalType.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.professionalType.frame = CGRectMake(CGRectGetMaxX(self.professional.frame)+20, self.professional.frame.origin.y, professionalTypeSize.width, professionalTypeSize.height);
            [cell addSubview:self.professionalType];
            
        
        }
    }else if (indexPath.section==2){
        if (self.info.business.count==0){
            //工作经历
            self.workExperience = [[UILabel alloc]init];
            self.workExperience.text = @"工作经历";
            self.workExperience.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
            self.workExperience.font = [UIFont systemFontOfSize:labelText];
            CGSize workExperienceSize = [self.workExperience.text sizeWithFont:self.workExperience.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.workExperience.frame = CGRectMake(15, 15, workExperienceSize.width, workExperienceSize.height);
            [cell addSubview:self.workExperience];
            
            self.line6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.workExperience.frame)+15, 10, 1, self.workExperience.frame.size.height+10)];
            self.line6.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
            [cell addSubview:self.line6];
            
            self.workExperienceDetail = [[UILabel alloc]init];
            self.workExperienceDetail.text = @"未填写";
            self.workExperienceDetail.font = [UIFont systemFontOfSize:labelText];
            self.workExperienceDetail.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize workExperienceDetailSize = [self.workExperienceDetail.text sizeWithFont:self.workExperienceDetail.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.workExperienceDetail.frame = CGRectMake(CGRectGetMaxX(self.line6.frame)+15, 15, workExperienceDetailSize.width, workExperienceDetailSize.height);
            [cell addSubview:self.workExperienceDetail];
            
        }else{
            
            self.info.content = [self.info.business[indexPath.row] objectForKey:@"content"];
            self.info.corporate = [self.info.business[indexPath.row] objectForKey:@"corporate"];
            self.info.position = [self.info.business[indexPath.row] objectForKey:@"position"];
            self.info.timestart = [self.info.business[indexPath.row] objectForKey:@"timestart"];
            self.info.timestop = [self.info.business[indexPath.row] objectForKey:@"timestop"];
            //工作时间
            self.worktoyear = [UILabel new];
            self.worktoyear.text = [NSString stringWithFormat:@"%@-%@",self.info.timestart,self.info.timestop];
            self.worktoyear.font = [UIFont systemFontOfSize:labelText];
            self.worktoyear.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize worktoyearSize = [self.worktoyear.text sizeWithFont:self.worktoyear.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.worktoyear.frame = CGRectMake(15, 15, worktoyearSize.width, worktoyearSize.height);
            [cell addSubview:self.worktoyear];
            
            //公司
            self.company = [UILabel new];
            self.company.text = @"公司";
            self.company.font = [UIFont systemFontOfSize:labelText];
            self.company.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize companySize = [self.company.text sizeWithFont:self.company.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.company.frame = CGRectMake(15, CGRectGetMaxY(self.worktoyear.frame)+10, companySize.width, companySize.height);
            [cell addSubview:self.company];
            
 
            self.companyLabel = [UILabel new];
            self.companyLabel.text = self.info.corporate;
            self.companyLabel.font = [UIFont systemFontOfSize:labelText];
            self.companyLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize companyLabelSize = [self.companyLabel.text sizeWithFont:self.companyLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.companyLabel.frame = CGRectMake(CGRectGetMaxX(self.company.frame) + 15, CGRectGetMaxY(self.worktoyear.frame)+10, companyLabelSize.width, companyLabelSize.height);
            [cell addSubview:self.companyLabel];
            
            //职位
            self.position = [UILabel new];
            self.position.text = @"职位";
           
            self.position.font = [UIFont systemFontOfSize:labelText];
            self.position.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize positionSize = [self.company.text sizeWithFont:self.company.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.position.frame = CGRectMake(15, CGRectGetMaxY(self.companyLabel.frame)+10, positionSize.width, positionSize.height);
            [cell addSubview:self.position];
            
            self.typeLabel = [UILabel new];
            self.typeLabel.text = self.info.position;
             self.typeLabel.numberOfLines = 0;
            self.typeLabel.font = [UIFont systemFontOfSize:labelText];
            self.typeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize typeLabelSize = [self.typeLabel.text sizeWithFont:self.typeLabel.font constrainedToSize:CGSizeMake(viewWidth - 45 - positionSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.typeLabel.frame = CGRectMake(CGRectGetMaxX(self.position.frame) + 15, CGRectGetMaxY(self.companyLabel.frame)+10, typeLabelSize.width, typeLabelSize.height);
            [cell addSubview:self.typeLabel];
            
            
            //工作内容
            self.content = [UILabel new];
            self.content.text = @"工作内容";
            self.content.font = [UIFont systemFontOfSize:labelText];
            self.content.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize contentSize = [self.content.text sizeWithFont:self.content.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.content.frame = CGRectMake(15, CGRectGetMaxY(self.typeLabel.frame)+10, contentSize.width, contentSize.height);
            [cell addSubview:self.content];
            
            //工作描述
            self.workExperienceDetail = [UILabel new];
            self.workExperienceDetail.text = self.info.content;
            self.workExperienceDetail.numberOfLines = 0;
            self.workExperienceDetail.font = [UIFont systemFontOfSize:labelText];
            self.workExperienceDetail.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize workExperienceDetailSize = [self.workExperienceDetail.text sizeWithFont:self.workExperienceDetail.font constrainedToSize:CGSizeMake(viewWidth - 45 - contentSize.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
            self.workExperienceDetail.frame = CGRectMake(CGRectGetMaxX(self.content.frame) + 15, CGRectGetMaxY(self.typeLabel.frame)+10, workExperienceDetailSize.width, workExperienceDetailSize.height);
            [cell addSubview:self.workExperienceDetail];
        
    
    
        }
    }else{
        if (indexPath.row==0){
            //自我介绍
            self.selfIntroduction = [UILabel new];
            self.selfIntroduction.text = @"自我介绍";
            self.selfIntroduction.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
            self.selfIntroduction.font = [UIFont systemFontOfSize:labelText];
            CGSize selfIntroductionSize = [self.selfIntroduction.text sizeWithFont:self.selfIntroduction.font constrainedToSize:CGSizeMake(200, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.selfIntroduction.frame = CGRectMake(15, (textSize2.height+30-selfIntroductionSize.height)/2, selfIntroductionSize.width, selfIntroductionSize.height);
            [cell addSubview:self.selfIntroduction];
            
            
            //自我具体介绍
            self.introduction = [UILabel new];
            self.introduction.text = self.info.intruduction;
            self.introduction.numberOfLines = 0;
            //根据控件大小改变字体大小
            //self.introduction.adjustsFontSizeToFitWidth = YES;
            self.introduction.font = [UIFont systemFontOfSize:labelText];
            self.introduction.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize introductionSize = [self.introduction.text sizeWithFont:self.introduction.font constrainedToSize:CGSizeMake(viewWidth-61-selfIntroductionSize.width, 1000) lineBreakMode:NSLineBreakByCharWrapping];
            
            if (introductionSize.height>selfIntroductionSize.height+15) {
                self.line7 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selfIntroduction.frame)+15, 10, 1, introductionSize.height+10)];
            }else{
                self.line7 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selfIntroduction.frame)+15, 10, 1, introductionSize.height+10)];
                
            }
            
            self.line7.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
            [cell addSubview:self.line7];
            
            
            
            self.introduction.frame = CGRectMake(CGRectGetMaxX(self.line7.frame)+15, 15, introductionSize.width, introductionSize.height);
            [cell addSubview:self.introduction];
        }else if (indexPath.row==1){
            //姓名
            self.name = [UILabel new];
            self.name.text = self.info.username;
            self.name.textAlignment = NSTextAlignmentLeft;
            self.name.font = [UIFont systemFontOfSize:labelText];
            self.name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            CGSize nameSize = [self.name.text sizeWithFont:self.name.font constrainedToSize:CGSizeMake(90, 200) lineBreakMode:NSLineBreakByWordWrapping];
            self.name.frame = CGRectMake(15, 30-nameSize.height/2, nameSize.width, nameSize.height);
            [cell addSubview:self.name];
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
    if (indexPath.section==0) {
        return textSize.height+30;
    }else if (indexPath.section==1){
        if (self.info.experienced.count==0) {
            return textSize.height + 30;
        }else
    return textSize.height*4+60;
    
    }else if (indexPath.section==2){
        if (self.info.business.count==0) {
            return textSize.height + 30;
        }else
    return textSize.height*3+60+textSize3.height;
    }else if (indexPath.section==3){
        if (indexPath.row==0) {
            return textSize2.height+30;
        }else
            return 66;
    
    }
        

    return 66;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
        return 0.000001;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.00000001;

}
//申请职位
-(void)apply:(UIButton* )sender{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.info.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

}
@end
