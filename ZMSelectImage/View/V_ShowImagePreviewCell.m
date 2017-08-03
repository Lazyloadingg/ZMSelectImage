//
//  V_ShowImagePreviewCell.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "V_ShowImagePreviewCell.h"
@interface V_ShowImagePreviewCell()
<
UIScrollViewDelegate
>
@property(nonatomic,strong)UIImageView * v_image;
@property(nonatomic,strong)UIScrollView * v_scroll;
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
        
        [model.asset RequestImagwWithSize:size resultHandler:^(UIImage *image) {
            weakself.v_image.image = image;
        }];
      });
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.v_image;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    ZMLog(@"缩放比例--%f", scrollView.zoomScale );
    ZMLog(@"image  %@",NSStringFromCGRect(self.v_image.bounds));
    ZMLog(@"scrollview  %@",NSStringFromCGRect(self.v_scroll.bounds));
}
#pragma mark >_<! --> 加载默认设置
-(void)loadDefaultsSetting{
    self.contentView.backgroundColor = [UIColor blackColor];
}
#pragma mark >_<! --> 初始化子视图
-(void)initSubViews{

    UIScrollView * v_scrollview = [[UIScrollView alloc]init];
    v_scrollview.contentSize = self.bounds.size;
    v_scrollview.minimumZoomScale = 1;
    v_scrollview.maximumZoomScale = 2;
    v_scrollview.userInteractionEnabled = YES;
    v_scrollview.delegate = self;
    v_scrollview.showsHorizontalScrollIndicator = NO;
    v_scrollview.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:v_scrollview];
    self.v_scroll = v_scrollview;
    
    UIImageView * v_image = [[UIImageView alloc]init];
    v_image.contentMode = UIViewContentModeScaleAspectFit;
    v_image.clipsToBounds = YES;
    [self.v_scroll addSubview:v_image];
    self.v_image = v_image;

}

-(void)layoutSubviews{
    [super layoutSubviews];
 
    self.v_scroll.frame = self.bounds;

    self.v_image.frame = self.bounds;
    
    ZMLog(@"---------%f",self.left);
}
@end
