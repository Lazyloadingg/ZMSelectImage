//
//  V_ShowImageListCell.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/1.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "V_ShowImageListCell.h"
#import "UIView+FrameExtension.h"
@interface V_ShowImageListCell()
@property(nonatomic,strong)UIImageView * img_title;
@property(nonatomic,strong)UILabel * lab_title;
@property(nonatomic,strong)UILabel * lab_detailTitle;
@end
@implementation V_ShowImageListCell

+(instancetype)initWithTableView:(UITableView *)tableView ID:(NSString *)ID{
    V_ShowImageListCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[V_ShowImageListCell alloc]init];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self loadDefaultsSetting];
    [self initSubViews];
    
    return self;
    
}
#pragma mark >_<! --> 加载默认设置
-(void)loadDefaultsSetting{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.contentView.backgroundColor = [[UIColor yellowColor]colorWithAlphaComponent:0.5];
}
#pragma mark >_<! --> 初始化子视图
-(void)setModel:(M_CollectionModel *)model{
    _model = model;
    M_CollectionCellModel * cell_model =_model.arr_image.firstObject;
    self.img_title.image = cell_model.img_preview;
    self.lab_title.text = _model.str_collectionTitle;
}
-(void)initSubViews{
    
    UIImageView * img_title = [[UIImageView alloc]init];
    img_title.contentMode = UIViewContentModeScaleAspectFill;
    img_title.clipsToBounds = YES;
    [self.contentView addSubview:img_title];
    self.img_title = img_title;
    
    UILabel * lab_title = [[UILabel alloc]init];
    [self.contentView addSubview:lab_title];
    self.lab_title = lab_title;
    
    UILabel * lab_detailTitle = [[UILabel alloc]init];
    [self.contentView addSubview:lab_detailTitle];
    self.lab_detailTitle = lab_detailTitle;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.img_title.frame = CGRectMake(0, 0, self.contentView.height, self.contentView.height);
    
    self.lab_title.frame = CGRectMake(self.img_title.width+5, 0, 200, self.contentView.height);
    
}
@end
