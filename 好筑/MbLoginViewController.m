//
//  MbLoginViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbLoginViewController.h"
#import "JZQCommon.h"
#import "MbRegistViewController.h"
#import "MbFindPassWordViewController.h"
#import "JZQHttpTools.h"
@interface MbLoginViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UIImageView* userNameImage;
@property(nonatomic,strong)UILabel* userName;
@property(nonatomic,strong)UITextField* nameField;

@property(nonatomic,strong)UIImageView* passWordImage;
@property(nonatomic,strong)UILabel* passWord;
@property(nonatomic,strong)UITextField* passWordField;

@property(nonatomic,strong)UILabel* line1;
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UIButton* loginBtn;
@property(nonatomic,strong)UIButton* registBtn;
@property(nonatomic,strong)UIButton* forgetBtn;
@property(nonatomic,strong)UIView* view1;
@property(nonatomic,strong)MbRegistViewController* registVC;  //注册页面
@property(nonatomic,strong)MbFindPassWordViewController* findPassWordVC;  //找回密码页面
@property(nonatomic,strong)UIImageView* logo;
@property(nonatomic,strong)NSString* string;
@property(nonatomic,assign)NSInteger* userid;
@end

@implementation MbLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"我的账号";
    //self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    //self.imageView.image = [UIImage imageNamed:@"bg.png"];
    //[self.view addSubview:self.imageView];
    
    
   
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self onCreate];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

}
-(void)onCreate{
    //白色背景
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 10, viewWidth - 30, 91)];
    self.view1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.view1];
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, viewWidth-30, 1)];
    self.line1.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view1 addSubview:self.line1];
    
    //用户名
//    self.userName = [[UILabel alloc]init];
//    self.userName.text = @"用户名";
//    self.userName.textColor = [UIColor whiteColor];
//    self.userName.font = [UIFont systemFontOfSize:labelText];
//    CGSize userNameSize = [self.userName.text sizeWithFont:self.userName.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByCharWrapping];
//    
    self.userNameImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12.5, 20, 20)];
    self.userNameImage.image = [UIImage imageNamed:@"zhanghu.png"];
    [self.view1 addSubview:self.userNameImage];
    
//    self.userName.frame = CGRectMake(CGRectGetMaxX(self.userNameImage.frame)+10, 12, userNameSize.width, userNameSize.height);
//    [self.view1 addSubview:self.userName];
    //竖线1
//    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userName.frame)+10, 8, 1, self.userNameImage.frame.size.height+4)];
//    self.line1.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.line1];
//    
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameImage.frame)+10, 10, viewWidth/3*2, 25)];
    self.nameField.textColor = [UIColor blackColor];
    self.nameField.font = [UIFont systemFontOfSize:labelText];
     self.nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameField.placeholder = @"用户名/手机号";
    [self.nameField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
   [self.nameField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.nameField];
    
    //横线
//    self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.line1.frame)+8, viewWidth, 1)];
//    self.line2.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.line2];
    
    //密码
//    self.passWord = [[UILabel alloc]init];
//    self.passWord.text = @"密   码";
//    self.passWord.textColor = [UIColor whiteColor];
//    self.passWord.font = [UIFont systemFontOfSize:labelText];
//    CGSize passWordSize = [self.userName.text sizeWithFont:self.passWord.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByCharWrapping];
//    
    self.passWordImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.line1.frame) + 12.5, 20, 20)];
    self.passWordImage.image = [UIImage imageNamed:@"tubiao.png"];
    [self.view1 addSubview:self.passWordImage];
//
//    self.passWord.frame = CGRectMake(CGRectGetMaxX(self.passWordImage.frame)+10, CGRectGetMaxY(self.line2.frame) + 12, passWordSize.width, passWordSize.height);
//    [self.view addSubview:self.passWord];
    //竖线
//    self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.passWord.frame)+10, CGRectGetMaxY(self.line2.frame)+8, 1, self.passWordImage.frame.size.height+4)];
//    self.line3.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.line3];
//    
    self.passWordField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.passWordImage.frame)+10, CGRectGetMaxY(self.line1.frame) + 10, viewWidth/3*2, 25)];
    self.passWordField.textColor = [UIColor blackColor];
    self.passWordField.font = [UIFont systemFontOfSize:labelText];
    self.passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passWordField.secureTextEntry = YES;
    self.passWordField.placeholder = @"请输入密码";
    [self.passWordField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.passWordField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.passWordField];
    //横线
//    self.line4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.line3.frame)+8, viewWidth, 1)];
//    self.line4.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.line4];

   
    //新用户注册
    self.registBtn = [[UIButton alloc]init];
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.registBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    
     CGSize size = [self.registBtn.titleLabel.text sizeWithFont:self.registBtn.titleLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByCharWrapping];
    
      self.registBtn.frame = CGRectMake(15, CGRectGetMaxY(self.view1.frame)+10, size.width, size.height);
    //self.registBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.loginBtn.frame)+20, (viewWidth-60)/2, 40)];
    [self.registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[self.registBtn setBackgroundColor:[UIColor whiteColor]];
    [self.registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //self.registBtn.titleLabel.font = [UIFont systemFontOfSize:12];
  
    [self.registBtn addTarget:self action:@selector(registBtn:) forControlEvents:UIControlEventTouchUpInside];
//    self.registBtn.layer.cornerRadius = 20;
//    self.registBtn.layer.masksToBounds = YES;
//    self.registBtn.layer.borderWidth = 1;
//    self.registBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:self.registBtn];
    
    //忘记密码
    self.forgetBtn = [[UIButton alloc]init];
    [self.forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[self.forgetBtn setBackgroundColor:[UIColor whiteColor]];
    self.forgetBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    
   
    self.forgetBtn.frame = CGRectMake(viewWidth - 15 - size.width, CGRectGetMaxY(self.view1.frame)+10, size.width, size.height);
    //self.forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.registBtn.frame)+20, CGRectGetMaxY(self.loginBtn.frame)+20, (viewWidth-60)/2, 40)];
    
    [self.forgetBtn addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchUpInside];
//    self.forgetBtn.layer.cornerRadius = 20;
//    self.forgetBtn.layer.masksToBounds = YES;
//    self.forgetBtn.layer.borderWidth = 1;
//    self.forgetBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:self.forgetBtn];
    
    
    //登录按钮
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 180, viewWidth-40, 40)];
    //[self.loginBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:166/255.0 blue:238/255.0 alpha:1]];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"home_6_btn1.png"] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"home_6_btn1_col.png"] forState:UIControlStateSelected];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.layer.cornerRadius = 20;
    self.loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.loginBtn];

    
   
    
    
    
    
    
    //LOGO
    self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth/4, CGRectGetMaxY(self.loginBtn.frame)+20, viewWidth/2, viewWidth/2/1.2)];
    self.logo.image = [UIImage imageNamed:@"LOGO.png"];
    
    [self.view addSubview:self.logo];
    
    //改变按钮线框的颜色
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//    
//    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){255,255,255,1});
//    
//    [self.registBtn.layer setBorderColor:color];

    

    //改变按钮线框的颜色
//    CGColorSpaceRef colorSpaceRef1 = CGColorSpaceCreateDeviceRGB();
//    
//    CGColorRef color1 = CGColorCreate(colorSpaceRef1, (CGFloat[]){255,255,255,1});
//    
//    [self.forgetBtn.layer setBorderColor:color1];
//    [self.view addSubview:self.forgetBtn];

}
//登录
-(void)loginBtn:(UIButton*)sender{
    //手机号验证正则表达式
    NSString *regex = @"^((1[0-9][0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self.nameField.text];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
      
    }else if (self.passWordField.text.length==0){
    
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }else{
    

        [JZQHttpTools postWithPath:login params:@{@"telephone":self.nameField.text,@"password":self.passWordField.text}
                           success:^(id JSON)
         {
             self.string = JSON[@"return"];
             if ([JSON[@"return"] isEqualToString:@"200"]) {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:JSON[@"msg"] message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                 
                 [alert show];
                 NSDictionary* dic = JSON[@"data"];
                 
                 
                 
                 [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"userid"] forKey:@"userid"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"telephone"] forKey:@"telephone"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 
          
                 
             }else if ([JSON[@"return"] isEqualToString:@"3000"]){
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                 [alert show];
             
             }else if ([JSON[@"return"] isEqualToString:@"300"]){
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:JSON[@"msg"] message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                 [alert show];
                 
             }
    
         }
                           failure:^(NSError *error)
         {
             NSLog(@"error:%@",[error localizedDescription]);
         }];
    }


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.string isEqualToString:@"200"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
    }
    
    

}

//新用户注册
-(void)registBtn:(UIButton*)sender{
    self.registVC = [[MbRegistViewController alloc]init];
    [self.navigationController pushViewController:self.registVC animated:YES];

}
//忘记密码
-(void)forget:(UIButton*)sender{
    self.findPassWordVC = [[MbFindPassWordViewController alloc]init];
    [self.navigationController pushViewController:self.findPassWordVC animated:YES];

}
@end
