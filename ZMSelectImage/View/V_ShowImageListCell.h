//
//  V_ShowImageListCell.h
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/1.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMSelectImage.h"
@interface V_ShowImageListCell : UITableViewCell

@property(nonatomic,strong)M_CollectionModel * model;
+(instancetype)initWithTableView:(UITableView *)tableView ID:(NSString *)ID;

@end
