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
+(void)RequestImageWithPHAssetCollection:(PHAssetCollection *)collection original:(BOOL)original block:(void(^)(NSArray *))block;
+(void)RequestImageithPHAsset:(PHAsset *)asset original:(BOOL)original block:(void(^)(UIImage*))block;
+(void)RequestImageWithPHAssetCollection:(PHAssetCollection *)collection imageSize:(CGSize)size complete:(void(^)(NSArray *))complete;
+(void)RequestImageithPHAsset:(PHAsset *)asset imageSize:(CGSize)size block:(void(^)(UIImage*))block;
@end
