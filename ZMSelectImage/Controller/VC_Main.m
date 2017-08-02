//
//  ViewController.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/7/12.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "VC_Main.h"
#import <Photos/Photos.h>
#import "VC_ShowImage.h"
#import "VC_ShowImageList.h"
#import "ZMRequestPhoto.h"
#import "ZMSelectImage.h"
@interface VC_Main ()
@property(nonatomic,strong)NSArray * arr_image;
@property(nonatomic,strong)NSArray * arr_imageLibrary;
@end

@implementation VC_Main

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self GetAllImage];
    [self GetAllLibrary];
    
    
    UIButton * btn  =[[UIButton alloc ]init];
    btn.frame = CGRectMake(100, 100, 100, 60);
    btn.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.5];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
-(void)btnAction:(UIButton *)btn{
    VC_ShowImage * vc = [[VC_ShowImage alloc]init];
    vc.arr_image = self.arr_image;
    
    VC_ShowImageList * vc_list = [[VC_ShowImageList alloc]init];
    vc_list.arr_imageLibrary = self.arr_imageLibrary;
    
    ZMNavigationController * navi = [[ZMNavigationController alloc]init];
    navi.viewControllers = @[vc_list,vc];
    
    [self presentViewController:navi animated:YES completion:nil];

//    [self.navigationController pushViewController:vc_list animated:YES];
}

-(void)GetAllImage{
    
//    PHFetchResult * results = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
//    PHImageRequestOptions * options = [[PHImageRequestOptions alloc]init];
//    options.resizeMode = PHImageRequestOptionsResizeModeExact;
//    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
//    options.synchronous = YES;
//    NSMutableArray * arr_image = [NSMutableArray arrayWithCapacity:results.count];
//    for (NSInteger index = 0; index < results.count; index++) {
//        PHAsset * asset = results[index];
//        M_CollectionCellModel * model = [M_CollectionCellModel initWithPHAsset:asset];
//        [arr_image addObject:model];
//    }
//    self.arr_image = arr_image;
}

-(void)GetAllLibrary{
    NSMutableArray * array = [NSMutableArray array];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            ZMLog(@"已授权");
        }
    }];
    
    [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    
    PHFetchResult * smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    ZMLog(@"系统相册数---%ld",smartAlbums.count);
    
    for (NSInteger index = 0; index < smartAlbums.count; index++) {
        PHAssetCollection * collection = smartAlbums[index];
        M_CollectionModel * model = [M_CollectionModel initWithPHAssetCollection:collection];
        if (model) {
            [array addObject:model];
        }
    }
    
    PHFetchResult * userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    ZMLog(@"用户相册数---%ld",userAlbums.count);
    
    for (NSInteger index = 0; index < userAlbums.count; index++) {
        PHAssetCollection * collection = userAlbums[index];
        
        M_CollectionModel * model = [M_CollectionModel initWithPHAssetCollection:collection];
        if (model) {
                        [array addObject:model];
        }
    }
    
    NSMutableArray * arr_image = [NSMutableArray array];
    self.arr_imageLibrary = array;
    for (NSInteger index = 0; index < self.arr_imageLibrary.count; index++) {
        M_CollectionModel * model = self.arr_imageLibrary[index];
        [arr_image addObjectsFromArray:model.arr_image];
    }
        self.arr_image = arr_image;
}

-(void)convertMovWithSourceURL:(NSURL *)sourceUrl fileName:(NSString *)fileName saveExportFilePath:(NSString *)path{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceUrl options:nil];
    NSArray *compatiblePresets=[AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];//输出模式标识符的集合
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        
        AVAssetExportSession *exportSession=[[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        NSString *resultPath = [path stringByAppendingFormat:@"/%@.mp4",fileName];
        exportSession.outputURL=[NSURL fileURLWithPath:resultPath];//输出路径
        exportSession.outputFileType = AVFileTypeMPEG4;//输出类型
        exportSession.shouldOptimizeForNetworkUse = YES;//为网络使用时做出最佳调整
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void){//异步输出转码视频
            switch (exportSession.status) {
                case AVAssetExportSessionStatusCancelled:
                    ZMLog(@"转码状态：取消转码");
                    break;
                case AVAssetExportSessionStatusUnknown:
                    ZMLog(@"转码状态：未知");
                    break;
                case AVAssetExportSessionStatusWaiting:
                    ZMLog(@"转码状态：等待转码");
                    break;
                case AVAssetExportSessionStatusExporting:
                    ZMLog(@"转码状态：正在转码");
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    ZMLog(@"转码状态：完成转码");
                    NSArray *files=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
                    for (NSString *fn in files) {
                        if ([resultPath isEqualToString:fn]) {
                            ZMLog(@"转码状态：完成转码 文件存在");
                        }
                    }
                    break;
                }
                case AVAssetExportSessionStatusFailed:
                    ZMLog(@"转码状态：转码失败");
                    ZMLog(@"%@",exportSession.error.description);
                    break;
            }
        }];
    }
}

@end
