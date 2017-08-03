//
//  V_PreviewToolbar.m
//  ZMSelectImage
//
//  Created by 圣光大人 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "V_PreviewToolbar.h"
#import "ZMSelectImage.h"
@interface V_PreviewToolbar()
@property(nonatomic,strong)ZMBaseButton * btn_select;
@property(nonatomic,strong)UIButton * btn_send;
@property(nonatomic,strong)UILabel * lab_imageSize;
@end
@implementation V_PreviewToolbar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self loadDefaultsSetting];
    [self initSubViews];
    
    return self;
}
-(void)selectAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    ZMLog(@"选择");
    if (self.delegate && [self.delegate respondsToSelector:@selector(originalImageAction:)]) {
        [self.delegate originalImageAction:btn];
    }
}
-(void)sendAction:(UIButton *)btn{
    ZMLog(@"确定发送");
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendAction:)]) {
        [self.delegate sendAction:btn];
    }
}
-(void)loadDefaultsSetting{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
}
-(void)initSubViews{
    
    
    ZMBaseButton * btn_select = [[ZMBaseButton alloc]init];
    [btn_select setImage:image(@"select") forState:UIControlStateNormal];
    [btn_select addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_select];
    self.btn_select = btn_select;
    
    UIButton * btn_send = [[UIButton alloc]init];
    btn_send.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.5];
    [btn_send setTitle:@"发送" forState:UIControlStateNormal];
    [btn_send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_send.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn_send addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_send];
    self.btn_send = btn_send;
    
    UILabel * lab_imageSize = [[UILabel alloc]init];
    lab_imageSize.font = [UIFont systemFontOfSize:12];
    lab_imageSize.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
    lab_imageSize.text = @"原图";
    [self addSubview:lab_imageSize];
    self.lab_imageSize = lab_imageSize;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.btn_select.frame = CGRectMake(10, (self.height - 30)/2,30,30);
    
    self.lab_imageSize.bounds = CGRectMake(0, 0, 40, 10);
    self.lab_imageSize.centerX = self.btn_select.right + 25;
    self.lab_imageSize.centerY = self.btn_select.centerY;
    
    self.btn_send.frame =CGRectMake(self.right - 70, (self.height - 30)/2,60,30);
    self.btn_send.layer.cornerRadius = 5;
    self.btn_send.layer.masksToBounds = YES;
    
}
@end
