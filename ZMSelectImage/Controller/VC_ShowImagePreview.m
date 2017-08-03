//
//  VC_ShowImagePreview.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/8/2.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "VC_ShowImagePreview.h"
#import "ZMSelectImage.h"
#import "V_ShowImagePreviewCell.h"
#import "V_PreviewToolbar.h"
#import "V_PreviewNaviBar.h"
@interface VC_ShowImagePreview ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
V_PreviewNaviBarDelegate,
V_PreviewToolbarDelegate
>

@property(nonatomic,strong)UICollectionView * v_collection;
@property(nonatomic,strong)V_PreviewToolbar * toolbar;
@property(nonatomic,strong)V_PreviewNaviBar * navibar;
@property(nonatomic,assign)BOOL  isHidden;
@end


static NSString * const VC_ShowImagePreviewCellID = @"VC_ShowImagePreviewCellID";
@implementation VC_ShowImagePreview

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultsSetting];
    [self InitSubViews];
}
#pragma mark >_<! 👉🏻 🐷Life cycle🐷
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [self.v_collection scrollToItemAtIndexPath:self.idx_current atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark >_<! 👉🏻 🐷System Delegate🐷

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr_data.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    V_ShowImagePreviewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:VC_ShowImagePreviewCellID forIndexPath:indexPath];
    cell.model = self.arr_data[indexPath.row];

    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        NSLog(@"显示--%@",indexPath);
    [self toolbarHidden];
}
#pragma mark >_<! 👉🏻 🐷Custom Delegate🐷
-(void)backAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didSelectedAction:(UIButton *)btn{
    ZMLog(@"选中当前图片");
}
-(void)sendAction:(UIButton *)btn{
    ZMLog(@"发送");
}
-(void)originalImageAction:(UIButton *)btn{
    ZMLog(@"需要原图");
}
#pragma mark >_<! 👉🏻 🐷Event  Response🐷
#pragma mark >_<! 👉🏻 🐷Private Methods🐷
-(void)toolbarHidden{
    self.isHidden = !self.isHidden;;
    if (self.isHidden == YES) {
        self.toolbar.hidden = YES;
        self.navibar.hidden = YES;
    }else{
        self.toolbar.hidden = NO;
        self.navibar.hidden = NO;
    }
}
#pragma mark >_<! 👉🏻 🐷Lazy loading🐷
#pragma mark >_<! 👉🏻 🐷Init SubViews🐷
-(void)setArr_data:(NSArray *)arr_data{
    _arr_data = arr_data;
    [self.v_collection reloadData];
}

-(void)loadDefaultsSetting{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isHidden = NO;
}
-(void)InitSubViews{
    UICollectionViewFlowLayout * layout  = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(MainScreen_Width,MainScreen_Height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;;
    
    UICollectionView * v_collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [ v_collection registerClass:[V_ShowImagePreviewCell class] forCellWithReuseIdentifier:VC_ShowImagePreviewCellID];
    v_collection.delegate = self;
    v_collection.dataSource = self;
    v_collection.pagingEnabled = YES;
    v_collection.backgroundColor = [UIColor blackColor];
    v_collection.showsHorizontalScrollIndicator = NO;
    self.v_collection = v_collection;
    [self.view addSubview:v_collection];
    
    V_PreviewToolbar * toolbar = [[V_PreviewToolbar alloc]initWithFrame:CGRectMake(0, MainScreen_Height-50, MainScreen_Width, 50)];
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    V_PreviewNaviBar * navibar = [[V_PreviewNaviBar alloc]initWithFrame:CGRectMake(0, 0, MainScreen_Width, 60)];
    navibar.delegate = self;
    [self.view addSubview:navibar];
    self.navibar = navibar;
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
