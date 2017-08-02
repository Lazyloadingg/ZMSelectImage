//
//  UIViewController+Extension.h
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,ItemDirection) {
    Left,
    Right
};
@interface UIViewController (Extension)
-(void)setBarButtonItemWith:(UIImage * _Nullable)image title:(NSString * _Nullable)title action:(SEL _Nonnull )action Direction:(ItemDirection)direction;
@end
