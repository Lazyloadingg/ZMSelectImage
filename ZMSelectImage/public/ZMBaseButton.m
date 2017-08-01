//
//  ZMBaseButton.m
//  ZMSelectImage
//
//  Created by 圣光大人 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "ZMBaseButton.h"

@implementation ZMBaseButton
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected == YES) {
        [self setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }else{
        [self setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }
}

@end
