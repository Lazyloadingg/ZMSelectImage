//
//  UIViewController+Extension.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "UIView+FrameExtension.h"
@implementation UIViewController (Extension)
-(void)setBarButtonItemWith:(UIImage * _Nullable)image title:(NSString * _Nullable)title action:(SEL _Nonnull)action Direction:(ItemDirection)direction{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    button.imageView.contentMode = UIViewContentModeLeft;
    button.width = button.imageView.width+button.titleLabel.width;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *BarButtomItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (direction == Left) {
        self.navigationItem.leftBarButtonItem = BarButtomItem;
    }else{
        self.navigationItem.rightBarButtonItem = BarButtomItem;
    }

}
@end
