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
@interface VC_ShowImagePreview ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>


@property(nonatomic,strong)UICollectionView * v_collection;
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
    [self.v_collection scrollToItemAtIndexPath:self.idx_current atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
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
#pragma mark >_<! 👉🏻 🐷Custom Delegate🐷
#pragma mark >_<! 👉🏻 🐷Event  Response🐷
#pragma mark >_<! 👉🏻 🐷Private Methods🐷
#pragma mark >_<! 👉🏻 🐷Lazy loading🐷
#pragma mark >_<! 👉🏻 🐷Init SubViews🐷
-(void)setArr_data:(NSArray *)arr_data{
    _arr_data = arr_data;
    [self.v_collection reloadData];
}

-(void)loadDefaultsSetting{
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)InitSubViews{
    UICollectionViewFlowLayout * layout  = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(MainScreen_Width,MainScreen_Height);
    layout.footerReferenceSize = CGSizeMake(MainScreen_Width, 60);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;;
    
    UICollectionView * v_collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [ v_collection registerClass:[V_ShowImagePreviewCell class] forCellWithReuseIdentifier:VC_ShowImagePreviewCellID];

    v_collection.delegate = self;
    v_collection.dataSource = self;
    v_collection.pagingEnabled = YES;
    v_collection.backgroundColor = [UIColor blackColor];
    self.v_collection = v_collection;
    [self.view addSubview:v_collection];
}
@end
