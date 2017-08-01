//
//  ZMRequestPhoto.h
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/1.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMSelectImage.h"
@interface ZMRequestPhoto : NSObject
+(NSArray*)RequestImageWithPHAssetCollection:(PHAssetCollection *)collection original:(BOOL)original;
+(UIImage *)RequestImageithPHAsset:(PHAsset *)asset original:(BOOL)original;
+(NSArray*)RequestImageWithPHAssetCollection:(PHAssetCollection *)collection imageSize:(CGSize)size;
@end
