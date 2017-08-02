//
//  M_CollectionCellModel.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "M_CollectionCellModel.h"

@implementation M_CollectionCellModel
+(instancetype)initWithPHAsset:(PHAsset *)asset{
    M_CollectionCellModel * model = [[M_CollectionCellModel alloc]init];
    
    model.asset = asset;
    model.str_title = asset.description;
    
    CGFloat scale = asset.pixelHeight * 1.0 / asset.pixelWidth;
    
    
    
    CGSize size = CGSizeMake(100, 100);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [ZMRequestPhoto RequestImageithPHAsset:asset imageSize:size block:^(UIImage * image) {
        model.img_preview = image;
    }];
        });
    return model;
}
@end
