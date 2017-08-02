//
//  M_CollectionModel.h
//  ZMSelectImage
//
//  Created by 圣光大人 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "ZMRequestPhoto.h"
@interface M_CollectionModel : NSObject
/*相册所有的图片model**/
@property(nonatomic,strong)NSArray * arr_image;
/*相册名称**/
@property(nonatomic,strong)NSString * str_collectionTitle;
+(instancetype)initWithPHAssetCollection:(PHAssetCollection *)collection;
@end
