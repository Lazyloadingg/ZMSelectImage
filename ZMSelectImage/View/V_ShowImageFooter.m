//
//  V_ShowImageFooter.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/7/13.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "V_ShowImageFooter.h"
@interface V_ShowImageFooter()
@property(nonatomic,strong)UILabel * lab_imageCount;
@end
@implementation V_ShowImageFooter
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self loadDefaultsSetting];
    [self initSubViews];
    
    return self;
    
}
-(void)setImgCount:(NSInteger)imgCount{
    _imgCount = imgCount;
    self.lab_imageCount.text = [NSString stringWithFormat:@"共有%ld张图片",imgCount];
}
#pragma mark >_<! --> 加载默认设置
-(void)loadDefaultsSetting{
    
}
#pragma mark >_<! --> 初始化子视图
-(void)initSubViews{
    
    UILabel * lab_imageCount = [[UILabel alloc]init];
    lab_imageCount.textAlignment = NSTextAlignmentCenter;
    lab_imageCount.font = [UIFont systemFontOfSize:15];
    lab_imageCount.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    lab_imageCount.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:lab_imageCount];
    self.lab_imageCount = lab_imageCount;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.lab_imageCount.frame = self.bounds;
    
}
@end
