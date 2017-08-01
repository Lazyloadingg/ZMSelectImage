//
//  V_ShowImageListCell.h
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/1.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface V_ShowImageListCell : UITableViewCell
@property(nonatomic,strong)UIImageView * img_title;
@property(nonatomic,strong)UILabel * lab_title;
@property(nonatomic,strong)UILabel * lab_detailTitle;
+(instancetype)initWithTableView:(UITableView *)tableView ID:(NSString *)ID;

@end
