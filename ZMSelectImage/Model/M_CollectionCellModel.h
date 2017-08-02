//
//  M_CollectionCellModel.h
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "ZMSelectImage.h"
@interface M_CollectionCellModel : NSObject
@property(nonatomic,copy)NSString * str_title;
@property(nonatomic,strong)UIImage * img_preview;
@property(nonatomic,strong)PHAsset * asset;
+(instancetype)initWithPHAsset:(PHAsset *)asset;
@end
