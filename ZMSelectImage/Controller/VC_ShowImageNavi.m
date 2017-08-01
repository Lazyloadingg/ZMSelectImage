//
//  VC_ShowImageNavi.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/7/13.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "VC_ShowImageNavi.h"
#import "VC_ShowImageList.h"
@interface VC_ShowImageNavi ()

@end

@implementation VC_ShowImageNavi

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = @[[[VC_ShowImageList alloc]init]];
}



@end
