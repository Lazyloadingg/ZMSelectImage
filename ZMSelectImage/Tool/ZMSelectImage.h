//
//  ZMSelectImage.h
//  ZMSelectImage
//
//  Created by Mac2 on 2017/7/13.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#ifndef ZMSelectImage_h
#define ZMSelectImage_h

#import <Photos/Photos.h>
#import "ZMBaseButton.h"
#import "ZMNavigationController.h"
#import "ZMBaseViewController.h"


#import "UIView+FrameExtension.h"
#import "UIViewController+Extension.h"

#import "VC_ShowImage.h"
#import "M_CollectionModel.h"
#import "M_CollectionCellModel.h"




#define Self_Width  self.bounds.size.width
#define Self_Height  self.bounds.size.width
#define MainScreen_Width [UIScreen mainScreen].bounds.size.width
#define MainScreen_Height [UIScreen mainScreen].bounds.size.height

#define WEAKSELF(weakself)      __weak __typeof(&*self)    weakself  = self;
#define image(a) [UIImage imageNamed:a]
#ifdef DEBUG
/**  //获取类名(文件名)；
 NSString *className = NSStringFromClass([self class]);
 NSLog(@"类名--------%@",className);
 
 //获取当前方法名；
 NSLog(@"%s",__FUNCTION__);
 
 //获取当前方法名；
 NSLog(@"%s",__func__);
 
 //获取当前方法名；
 NSLog(@"%s",__PRETTY_FUNCTION__);
 
 //获取当前所在行；
 NSLog(@"%d",__LINE__);
 
 //获取该文件的绝对路径；
 NSLog(@"%s",__FILE__);
 
 //获取当前日期；
 NSLog(@"%s",__DATE__);
 
 //获取当前时分秒；
 NSLog(@"%s",__TIME__);
 
 //获取当前时间戳；
 NSLog(@"%s",__TIMESTAMP__);*/
#define ZMLog(FORMAT, ...) fprintf(stderr,"%s:%s:%d\t : %s\n",__TIME__, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define ZMLog(FORMAT, ...) nil
#endif



#endif /* ZMSelectImage_h */
