//
//  V_ShowImageCell.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/7/13.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "V_ShowImageCell.h"
#import "ZMSelectImage.h"
#define btnW 30
@interface V_ShowImageCell()
@property(nonatomic,strong)UIImageView * v_image;
@property(nonatomic,strong)UIButton * btn_selectState;
@end
@implementation V_ShowImageCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self loadDefaultsSetting];
    [self initSubViews];
    
    return self;
    
}
-(void)setImg_show:(UIImage *)img_show{
    _img_show = img_show;
    self.v_image.image = _img_show;
}
#pragma mark >_<! --> 加载默认设置
-(void)loadDefaultsSetting{
    self.contentView.backgroundColor = [UIColor whiteColor];
}
#pragma mark >_<! --> 初始化子视图
-(void)initSubViews{
    
    UIImageView * v_image = [[UIImageView alloc]init];
    [self.contentView addSubview:v_image];
    self.v_image = v_image;
    
    UIButton * btn_selectState = [[UIButton alloc]init];
    btn_selectState.backgroundColor = [UIColor redColor];
    [btn_selectState addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn_selectState];
    self.btn_selectState = btn_selectState;
}
-(void)btnAction:(UIButton * )button{
    ZMLog(@"做点什么");
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.v_image.frame = self.bounds;
    
    self.btn_selectState.frame = CGRectMake(Self_Width - btnW, Self_Height-btnW, btnW, btnW);
}
@end
