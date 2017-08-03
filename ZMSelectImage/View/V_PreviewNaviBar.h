//
//  V_PreviewNaviBar.h
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/3.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol V_PreviewNaviBarDelegate <NSObject>
-(void)backAction:(UIButton *)btn;
@optional
-(void)didSelectedAction:(UIButton *)btn;
@end
@interface V_PreviewNaviBar : UIView
@property(nonatomic,weak)id<V_PreviewNaviBarDelegate>  delegate;
@end
