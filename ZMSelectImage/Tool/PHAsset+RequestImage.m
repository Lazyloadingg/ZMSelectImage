//
//  PHAsset+RequestImage.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/3.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "PHAsset+RequestImage.h"

@implementation PHAsset (RequestImage)
-(void)RequestImagwWithSize:(CGSize)size resultHandler:(void(^)(UIImage * image))resultHandler{
    
    [[PHImageManager defaultManager]requestImageForAsset:self targetSize:size contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (resultHandler) {
            resultHandler(result);
        }
    }];
}
@end
