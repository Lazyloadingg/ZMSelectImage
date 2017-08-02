//
//  ZMRequestPhoto.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/1.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "ZMRequestPhoto.h"
#import <Photos/Photos.h>
@implementation ZMRequestPhoto
+(void)RequestImageWithPHAssetCollection:(PHAssetCollection *)collection original:(BOOL)original block:(void(^)(NSArray *))block{
    
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:assets.count];
    for (PHAsset *asset in assets) {

      [ZMRequestPhoto RequestImageithPHAsset:asset original:original block:^(UIImage *image) {
       [array addObject:image];
     }];
    }

    if (block) {
        block(array);
    }
}
+(void)RequestImageithPHAsset:(PHAsset *)asset original:(BOOL)original block:(void(^)(UIImage*))block{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
//    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    CGSize size = original == YES ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            ZMLog(@"请求成功--%@",result);
            if (block) {
                block(result);
            }
        }];
//    });
}
+(void)RequestImageWithPHAssetCollection:(PHAssetCollection *)collection imageSize:(CGSize)size complete:(void (^)(NSArray *))complete{
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:assets.count];
    for (PHAsset *asset in assets) {
         [ZMRequestPhoto RequestImageithPHAsset:asset imageSize:size block:^(UIImage * image) {
             [array addObject:image];
         }];
    }
    
    if (complete) {
        complete(array);
    }
}
+(void)RequestImageithPHAsset:(PHAsset *)asset imageSize:(CGSize)size block:(void(^)(UIImage*))block{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;

    [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
             ZMLog(@"请求成功--%@",result);
        if (block) {
            block(result);
        }
    }];
    
}
-(void)dealloc{
    ZMLog(@"ZMRequestPhoto 号机自报完成");
}
@end
