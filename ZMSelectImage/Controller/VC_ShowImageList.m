//
//  VC_ShowImageList.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/7/13.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "VC_ShowImageList.h"
#import "V_ShowImageListCell.h"
#import "ZMRequestPhoto.h"
@interface VC_ShowImageList ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)UITableView * v_table;
@end

static NSString * const VC_ShowImageListCellID = @"VC_ShowImageListCellID";
@implementation VC_ShowImageList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.3];
    [self initSubViews];
}
#pragma mark >_<! 👉🏻 🐷Life cycle🐷
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBarButtonItemWith:nil title:@"返回" action:@selector(dismiss) Direction:Right];
}
#pragma mark >_<! 👉🏻 🐷System Delegate🐷

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_imageLibrary.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    V_ShowImageListCell * cell = [V_ShowImageListCell initWithTableView:tableView ID:VC_ShowImageListCellID];
    M_CollectionModel * model = self.arr_imageLibrary[indexPath.row];
    cell.model = model;
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VC_ShowImage * vc = [[VC_ShowImage alloc]init];
    M_CollectionModel * model = self.arr_imageLibrary[indexPath.row];
    vc.arr_image =model.arr_image;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark >_<! 👉🏻 🐷Custom Delegate🐷
#pragma mark >_<! 👉🏻 🐷Event  Response🐷
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark >_<! 👉🏻 🐷Private Methods🐷
#pragma mark >_<! 👉🏻 🐷Lazy loading🐷
#pragma mark >_<! 👉🏻 🐷Init SubViews🐷
-(void)setArr_imageLibrary:(NSArray *)arr_imageLibrary{
    _arr_imageLibrary  = arr_imageLibrary;

    [self.v_table reloadData];
}
-(void)initSubViews{
    UITableView * v_table1 = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    v_table1.delegate = self;
    v_table1.dataSource = self;
    [self.view addSubview:v_table1];
//    self.v_table = v_table1;
}


@end
