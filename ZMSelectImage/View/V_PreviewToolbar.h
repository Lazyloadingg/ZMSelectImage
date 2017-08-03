//
//  V_PreviewToolbar.h
//  ZMSelectImage
//
//  Created by 圣光大人 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol V_PreviewToolbarDelegate <NSObject>
-(void)sendAction:(UIButton *)btn;
-(void)originalImageAction:(UIButton *)btn;
@end
@interface V_PreviewToolbar : UIView
@property(nonatomic,weak)id<V_PreviewToolbarDelegate>  delegate ;
@end
