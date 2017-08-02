//
//  M_CollectionModel.m
//  ZMSelectImage
//
//  Created by 圣光大人 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "M_CollectionModel.h"

@implementation M_CollectionModel
+(instancetype)initWithPHAssetCollection:(PHAssetCollection *)collection{
    M_CollectionModel * model = [[M_CollectionModel alloc]init];
    
//     [ZMRequestPhoto RequestImageWithPHAssetCollection:collection original:NO block:^(NSArray * array) {
//          model.arr_image = array;
//    }];
    
//    [ZMRequestPhoto RequestImageWithPHAssetCollection:collection imageSize:CGSizeZero complete:^(NSArray * array) {
//           model.arr_image = array;
//    }];
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    if (assets.count == 0) {
        return nil;
    }
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:assets.count];
    for (PHAsset * asset in assets) {
        
        M_CollectionCellModel * cell_model = [M_CollectionCellModel initWithPHAsset:asset];
        [array addObject:cell_model];
    }
    model.arr_image = array;
    model.str_collectionTitle = collection.localizedTitle;
    
    return model;
}
@end
