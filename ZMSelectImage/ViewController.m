//
//  ViewController.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/7/12.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "ZMHead.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetAllImage];
    [self GetAllLibrary];
}
-(void)GetAllImage{
    
    PHFetchResult * results = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    ZMLog(@"相片总数----%ld",results.count);
    PHImageRequestOptions * options = [[PHImageRequestOptions alloc]init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = YES;
    
    for (NSInteger index = 0; index < results.count; index++) {
        PHAsset * asset = results[index];
        [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:CGSizeMake(110, 110) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            ZMLog(@"相片----%@---%@",result,info);
        }];
    }
}

-(void)GetAllLibrary{
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
        PHFetchResult * imgs = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        ZMLog(@"相册名字---%@    相册内容---%@",collection.localizedTitle,imgs);
    }
    
    PHFetchResult * userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    ZMLog(@"用户相册数---%ld",userAlbums.count);
    
    for (NSInteger index = 0; index < userAlbums.count; index++) {
        PHAssetCollection * collection = userAlbums[index];
        PHFetchResult * imgs = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        ZMLog(@"相册名字---%@    相册内容---%@",collection.localizedTitle,imgs);
    }
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
