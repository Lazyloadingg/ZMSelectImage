//
//  VC_ShowImage.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/7/13.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "VC_ShowImage.h"
#import "ZMSelectImage.h"
#import "V_ShowImageCell.h"
#import "V_ShowImageFooter.h"


@interface VC_ShowImage ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property(nonatomic,strong)UICollectionView * v_collection;
@end
static NSString * const ZMSelectShowCollectionItemID = @"ZMSelectShowCollectionItemID";
static NSString * const ZMSelectShowCollectionFotterID = @"ZMSelectShowCollectionFotterID";
@implementation VC_ShowImage
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.v_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.arr_image.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self InitSubViews];

}

#pragma mark >_<! 👉🏻 🐷Life cycle🐷
#pragma mark >_<! 👉🏻 🐷System Delegate🐷
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr_image.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    V_ShowImageCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:ZMSelectShowCollectionItemID forIndexPath:indexPath];
    if (!item) {
        item  = [[V_ShowImageCell alloc]init];
    }
    item.img_show = self.arr_image[indexPath.row];
    item.contentView.backgroundColor = [UIColor yellowColor];
    return item;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionFooter) {
        V_ShowImageFooter * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ZMSelectShowCollectionFotterID forIndexPath:indexPath];
        if (!footer) {
            footer = [[V_ShowImageFooter alloc]initWithFrame:CGRectMake(0, 0, MainScreen_Width, 40)];
        }
        footer.backgroundColor = [UIColor greenColor];
        //    footer.d
        return footer;
    }else{
        return nil;
    }

}

#pragma mark >_<! 👉🏻 🐷Custom Delegate🐷
#pragma mark >_<! 👉🏻 🐷Event  Response🐷
#pragma mark >_<! 👉🏻 🐷Private Methods🐷
#pragma mark >_<! 👉🏻 🐷Lazy loading🐷
#pragma mark >_<! 👉🏻 🐷Init SubViews🐷
-(void)InitSubViews{
    UICollectionViewFlowLayout * layout  = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((MainScreen_Width-10)/4, (MainScreen_Width-5)/4);
    layout.footerReferenceSize = CGSizeMake(MainScreen_Width, 40);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;;
    
    UICollectionView * v_collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_Width, MainScreen_Height-44) collectionViewLayout:layout];
    [ v_collection registerClass:[V_ShowImageCell class] forCellWithReuseIdentifier:ZMSelectShowCollectionItemID];
    [v_collection registerClass:[V_ShowImageFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ZMSelectShowCollectionFotterID];
    v_collection.delegate = self;
    v_collection.dataSource = self;
    v_collection.pagingEnabled = YES;
    v_collection.backgroundColor = [UIColor whiteColor];
    self.v_collection = v_collection;
    [self.view addSubview:v_collection];
}

@end
