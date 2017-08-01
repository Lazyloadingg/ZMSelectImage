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
    
    model.arr_image = [ZMRequestPhoto RequestImageWithPHAssetCollection:collection original:NO];
    model.str_collectionTitle = collection.localizedTitle;
    
    return model;
}
@end
