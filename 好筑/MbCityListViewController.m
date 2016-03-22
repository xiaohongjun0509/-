//
//  MbCityListViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbCityListViewController.h"
#import "JZQCommon.h"
#import "TRUtils.h"
#import "ChineseString.h"
@interface MbCityListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property(nonatomic,strong)NSArray* lists;
@property(nonatomic,strong)UITableViewHeaderFooterView* hf;
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)NSArray *resultArray;
@property (nonatomic,strong) NSMutableDictionary *headDic;
@property (nonatomic,strong)NSArray *headArray;

@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;
@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic,strong)UILabel* line;
@property (nonatomic,strong)NSMutableArray* cityList;    //城市列表
@end

@implementation MbCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrayHotCity = [NSMutableArray arrayWithObjects:@"北京市",@"天津市",@"青岛市",@"济南市",@"深圳市", nil];
//    self.keys = [NSMutableArray array];
    self.arrayCitys = [NSMutableArray array];
//    self.cityList = [NSMutableArray array];
//    self.resultArray = [NSArray array];
//    self.headArray = [NSArray array];
//    self.headDic = [NSMutableDictionary dictionary];
//    self.headDic = [TRUtils getDicWithArray:self.array];
//    self.headArray = [TRUtils getArrayWithArray:self.array];
//    [self getCityData];
    
    UISearchBar* searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 10, viewWidth-40, 30)];
    searchBar.backgroundImage = [UIImage imageNamed:@"home_btn_wh.png"];
    searchBar.placeholder = @"输入城市名或拼音查询";
    searchBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:searchBar];
    
    self.line = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(searchBar.frame)+2, viewWidth-40, 1)];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.line];
    //self.titleArray =@[@"热门",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
    [self getCityList];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, viewWidth, viewHeight-106) style:UITableViewStyleGrouped];
          self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    
    
    
    
    
    
}
//获取城市列表
-(void)getCityList{
    NSString* path = citylist;
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
       
        self.cityList = [MbPaser paserCityListByDic:dic];
        for (MbUserInfo* info in self.cityList) {
            [self.arrayCitys addObject:info.name];
            
        }
        self.indexArray = [ChineseString IndexArray:self.self.arrayCitys];
        self.letterResultArr = [ChineseString LetterSortArray:self.self.arrayCitys];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [task resume];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}


#pragma mark -
#pragma mark - UITableViewDataSource

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

#pragma mark -
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 10)];
    //lab.backgroundColor = [UIColor grayColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor blackColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSArray* array = [self.letterResultArr objectAtIndex:indexPath.section];
   
    NSString* str = [array objectAtIndex:indexPath.row];
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:str forKey:@"cityName"];
    [userDefaults synchronize];
    self.homeVC.cityName = str;
    //self.homeVC.nameid = info.areaid;
    [self.navigationController popViewControllerAnimated:YES];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                    message:[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]
//                                                   delegate:nil
//                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
//    [alert show];
}




/*
 -(void)getCityData
 {
 NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
 ofType:@"plist"];
 self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
 
 [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
 
 //添加热门城市
 NSString *strHot = @"热门";
 [self.keys insertObject:strHot atIndex:0];
 [self.cities setObject:_arrayHotCity forKey:strHot];
 }
 
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    //bgView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    
    NSString *key = [_keys objectAtIndex:section];
    if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    }
    else
        titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//
//    return [_keys count];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

//    NSString *key = [_keys objectAtIndex:section];
//    NSArray *citySection = [_cities objectForKey:key];
//    return [citySection count];
    return self.cityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
  
    }
 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:labelText];
    MbUserInfo* info = [self.cityList objectAtIndex:indexPath.row];
    cell.textLabel.text = info.name;
    //cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSString *key = [_keys objectAtIndex:indexPath.section];
    //NSArray *citySection = [_cities objectForKey:key];
    //self.array = [self.cities objectForKey:[indexPath.section]];
    //NSString* title = citySection[indexPath.row];
    MbUserInfo* info = [self.cityList objectAtIndex:indexPath.row];
    self.homeVC.cityName = info.name;
    self.homeVC.nameid = info.areaid;
     [self.navigationController popViewControllerAnimated:YES];


}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 25;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
    
    
}
//索引列点击事件
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

{

    //点击索引，列表跳转到对应索引的行
    
//    [tableView
//     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index+1]
//     atScrollPosition:UITableViewScrollPositionNone animated:YES];
    return index;
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    static NSString * identy = @"headFoot";
//    UITableViewHeaderFooterView * hf = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
//    
//    if (section==0) {
//        //hf = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identy];
//        UISearchBar* searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 10, viewWidth-40, 30)];
//        searchBar.placeholder = @"输入城市名或拼音查询";
//        
//        return searchBar;
//
//        //return hf;
//    }
//    return nil;
//}
*/
@end
