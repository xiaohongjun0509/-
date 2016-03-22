//
//  MbEnterpriseTableViewCell.m
//  Recruitment
//
//  Created by tusm on 15/11/2.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbEnterpriseTableViewCell.h"
@interface MbEnterpriseTableViewCell()

@end

@implementation MbEnterpriseTableViewCell
@synthesize delegate;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{


    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.array = @[@"钢结构一",@"钢结构二",@"钢结构三",@"钢结构四",@"钢结构五",@"钢结构六",@"钢结构七",@"钢结构八",@"......."];
        
      //公司名称
        self.nameLabel = [[UILabel alloc]init];
        //self.nameLabel.text = @"浙江广发建设发展有限公司";
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.font = [UIFont systemFontOfSize:labelText+2];
        //CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(viewWidth-30, 400) lineBreakMode:NSLineBreakByWordWrapping];
        //self.nameLabel.frame = CGRectMake(15, 10, viewWidth-30, nameSize.height);
        [self addSubview:self.nameLabel];
        
        //地区
        self.placeLabel = [[UILabel alloc]init];
        //self.placeLabel.text = @"朝阳";
        self.placeLabel.font = [UIFont systemFontOfSize:labelText];
        //CGSize placeSize = [self.placeLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:labelText]}];
        //self.placeLabel.frame = CGRectMake(viewWidth - 15 - placeSize.width, CGRectGetMaxY(self.nameLabel.frame) + 7, placeSize.width, placeSize.height);
        [self addSubview:self.placeLabel];
        //按钮循环
        
      
//        for (int i = 0; i<self.array.count; i++) {
//              self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
//            NSInteger index = i%5;
//            NSInteger page = i/5;
//            UILabel* la = [[UILabel alloc]init];
//            la.text = @"钢结构一";
//            la.font = [UIFont systemFontOfSize:labelText];
//            CGSize laSize = [la.text sizeWithFont:la.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
//            self.btn.frame = CGRectMake(15+index*(viewWidth-90)/5, CGRectGetMaxY(self.nameLabel.frame) + 10 + page*laSize.height, (viewWidth-90)/5, laSize.height);
//            [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [self.btn setTitle:self.array[i] forState:UIControlStateNormal];
//           
//            [self addSubview:self.btn];
//        }
        
        
//        CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
//        CGFloat h = self.nameLabel.frame.size.height + 20;//用来控制button距离父视图的高
//        for (int i = 0; i < self.array.count; i++) {
//            self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
//            self.btn.tag = 100 + i;
//            if (self.btn.tag%5==1) {
//                [self.btn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:229/255.0 blue:229/255.0 alpha:1]];
//            }else if (self.btn.tag%5==2){
//             [self.btn setBackgroundColor:[UIColor colorWithRed:224/255.0 green:251/255.0 blue:255/255.0 alpha:1]];
//            
//            }else if (self.btn.tag%5==3){
//                 [self.btn setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]];
//                
//            }else if (self.btn.tag%5==4){
//                 [self.btn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:242/255.0 blue:224/255.0 alpha:1]];
//                
//            }else if (self.btn.tag%5==0){
//                
//                 [self.btn setBackgroundColor:[UIColor colorWithRed:242/255.0 green:224/255.0 blue:255/255.0 alpha:1]];
//            }
//            [self.btn setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1] forState:UIControlStateNormal];
//            NSDictionary *attributes = nil;
//            if (viewHeight==480) {
//                self.btn.titleLabel.font = [UIFont systemFontOfSize:labelText-3];
//                  attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:labelText-3]};
//            }else{
//            self.btn.titleLabel.font = [UIFont systemFontOfSize:labelText-4];
//                  attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:labelText-4]};
//            }
//         
//            //根据计算文字的大小
//            
//          
//            CGFloat length = [self.array[i] boundingRectWithSize:CGSizeMake(viewWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
//            
//             CGFloat heigth = [self.array[i] boundingRectWithSize:CGSizeMake(viewWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
//            //为button赋值
//            [self.btn setTitle:self.array[i] forState:UIControlStateNormal];
//            //设置button的frame
//            
//    
//            self.btn.frame = CGRectMake(10 + w, h, length + 10 , heigth+4);
//            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
//            if(10 + w + length + 15 > viewWidth){
//                w = 0; //换行时将w置为0
//                h = h + self.btn.frame.size.height + 10;//距离父视图也变化
//                
//                //CGRectGetMaxY(self.detailName.frame) + 5 + (i/3 * viewWidth/4)
//                
//                self.btn.frame = CGRectMake(10 + w, h, length + 10, heigth+4);//重设button的frame
//            }
//            w = self.btn.frame.size.width + self.btn.frame.origin.x;
//            [self addSubview:self.btn];
//        }
        
        
        
        
        //日期
        self.dateLabel = [[UILabel alloc]init];
        //self.dateLabel.text = @"2015-06-01";
        self.dateLabel.font = [UIFont systemFontOfSize:labelText-1];
        //CGSize dateSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
        //self.dateLabel.frame = CGRectMake(viewWidth-15-dateSize.width, CGRectGetMaxY(self.placeLabel.frame)+7, dateSize.width, dateSize.height);
        [self addSubview:self.dateLabel];
        
      _finalH = CGRectGetMaxY(self.dateLabel.frame) + 10;
    }
    return self;
    
}
- (void)loadContent:(MbUserInfo*)data{

    self.nameLabel.text = data.company;
    
    CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(viewWidth-30, 400) lineBreakMode:NSLineBreakByWordWrapping];
    self.nameLabel.frame = CGRectMake(15, 10, viewWidth-30, nameSize.height);
    self.placeLabel.text = data.area;
    CGSize placeSize = [self.placeLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:labelText]}];
    self.placeLabel.frame = CGRectMake(viewWidth - 15 - placeSize.width, CGRectGetMaxY(self.nameLabel.frame) + 7, placeSize.width, placeSize.height);
    
    
    
    NSTimeInterval time=[data.comtime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    self.dateLabel.text = currentDateStr;
    CGSize dateSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.dateLabel.frame = CGRectMake(viewWidth-15-dateSize.width, CGRectGetMaxY(self.placeLabel.frame)+7, dateSize.width, dateSize.height);
     _finalH = CGRectGetMaxY(self.dateLabel.frame) + 10;
}
@end
