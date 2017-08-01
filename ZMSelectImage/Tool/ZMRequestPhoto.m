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
+(NSArray*)RequestImageWithPHAssetCollection:(PHAssetCollection *)collection original:(BOOL)original{
    
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:assets.count];
    for (PHAsset *asset in assets) {
     UIImage * image= [ZMRequestPhoto RequestImageithPHAsset:asset original:original];
    [array addObject:image];
    }
    return array;
}
//+(NSArray*)RequestImageWithPHAssetCollection:(PHAssetCollection *)collection imageSize:(CGSize)size{
//    
//}
+(UIImage *)RequestImageithPHAsset:(PHAsset *)asset original:(BOOL)original{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
//    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    CGSize size = original == YES ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
    __block  UIImage * image;
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        image = result;
        ZMLog(@"请求成功--%@",result);
    }];
    
    return image;
}
-(void)dealloc{
    ZMLog(@"ZMRequestPhoto 号机自报完成");
}
@end
