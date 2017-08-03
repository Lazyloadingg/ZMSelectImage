//
//  PHAsset+RequestImage.h
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/3.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (RequestImage)
-(void)RequestImagwWithSize:(CGSize)size resultHandler:(void(^)(UIImage * image))resultHandler;
@end
