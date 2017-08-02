//
//  V_ShowImagePreviewCell.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "V_ShowImagePreviewCell.h"
@interface V_ShowImagePreviewCell()
@property(nonatomic,strong)UIImageView * v_image;
@end
@implementation V_ShowImagePreviewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self loadDefaultsSetting];
    [self initSubViews];
    
    return self;
    
}
-(void)setModel:(M_CollectionCellModel *)model{
    _model = model;
    self.v_image.image = model.img_preview;
    
    
    WEAKSELF(weakself);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        CGFloat scale = model.asset.pixelHeight / model.asset.pixelWidth;
        CGSize size = CGSizeMake(MainScreen_Width, MainScreen_Height * scale);
        
        [ZMRequestPhoto RequestImageithPHAsset:model.asset imageSize:size block:^(UIImage * image) {
            weakself.v_image.image = image;
        }];
});

}
#pragma mark >_<! --> 加载默认设置
-(void)loadDefaultsSetting{
    self.contentView.backgroundColor = [UIColor blackColor];
}
#pragma mark >_<! --> 初始化子视图
-(void)initSubViews{
    UIImageView * v_image = [[UIImageView alloc]init];
    v_image.contentMode = UIViewContentModeScaleAspectFit;
    v_image.clipsToBounds = YES;
    [self.contentView addSubview:v_image];
    self.v_image = v_image;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.v_image.frame = self.bounds;
    ZMLog(@"---------%f",self.left);
}
@end
