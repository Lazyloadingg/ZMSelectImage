//
//  V_PreviewNaviBar.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/3.
//  Copyright © 2017年 圣光大人. All rights reserved.
//


#import "V_PreviewNaviBar.h"
#import "ZMSelectImage.h"
@interface V_PreviewNaviBar()
@property(nonatomic,strong)UIButton * btn_back;
@property(nonatomic,strong)ZMBaseButton * btn_select;
@end
@implementation V_PreviewNaviBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self loadDefaultsSetting];
    [self initSubViews];
    
    return self;
    
}
-(void)selectAction:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedAction:)]) {
        [self.delegate didSelectedAction:btn];
    }
}
-(void)backAction:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backAction:)]) {
        [self.delegate backAction:btn];
    }
}
#pragma mark >_<! --> 加载默认设置
-(void)loadDefaultsSetting{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
}
#pragma mark >_<! --> 初始化子视图
-(void)initSubViews{
    
    ZMBaseButton * btn_select = [[ZMBaseButton alloc]init];
    [btn_select setImage:image(@"select") forState:UIControlStateNormal];
    [btn_select addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_select];
    self.btn_select = btn_select;
    
    UIButton * btn_back = [[UIButton alloc]init];
    [self addSubview:btn_back];
    [btn_back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn_back setTitle:@"back" forState:UIControlStateNormal];
    self.btn_back = btn_back;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.btn_select.frame = CGRectMake(self.right - 50, 10, 30, 30);
    
    self.btn_back.frame = CGRectMake(15, 10, 60, 40);
    
    
}
@end
