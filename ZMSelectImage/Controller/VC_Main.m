//
//  ViewController.m
//  ZMSelectImage
//
//  Created by Mac2 on 2017/7/12.
//  Copyright © 2017年 圣光大人. All rights reserved.
//

#import "VC_Main.h"
#import <Photos/Photos.h>
#import "ZMSelectImage.h"
#import "VC_ShowImage.h"
#import "VC_ShowImageList.h"
#import "VC_ShowImageNavi.h"
#import "ZMRequestPhoto.h"
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
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    VC_ShowImage * vc = [[VC_ShowImage alloc]init];
//    vc.arr_image = self.arr_image;
    VC_ShowImageList * vc = [[VC_ShowImageList alloc]init];
    vc.arr_imageLibrary = self.arr_imageLibrary;
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)GetAllImage{
    
    PHFetchResult * results = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
//    ZMLog(@"相片总数----%ld",results.count);
    PHImageRequestOptions * options = [[PHImageRequestOptions alloc]init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = YES;
    NSMutableArray * arr_image = [NSMutableArray arrayWithCapacity:results.count];
    for (NSInteger index = 0; index < results.count; index++) {
        PHAsset * asset = results[index];
        ZMLog(@"原始尺寸------宽%lu---高%lu",(unsigned long)asset.pixelWidth,(unsigned long)asset.pixelHeight);
        UIImage * image = [ZMRequestPhoto RequestImageithPHAsset:asset original:YES];
        ZMLog(@"原图大小------%@",image);
//        0.5  0.33
        CGFloat scale = [UIScreen mainScreen].scale;
        CGFloat scale1 = asset.pixelHeight * 1.0 / asset.pixelWidth;
        CGSize size = CGSizeMake(60*scale1, 60*scale1);
        CGSize size1 = CGSizeMake(size.width * scale, size.height * scale);
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size1 contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//            image = result;
            ZMLog(@"请求成功--%@",result);
        }];
//        [arr_image addObject:image];
    }
    self.arr_image = arr_image;
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
        NSArray * arr_image = [ZMRequestPhoto RequestImageWithPHAssetCollection:collection original:NO];
        [array addObject:collection];
    }
    
    PHFetchResult * userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    ZMLog(@"用户相册数---%ld",userAlbums.count);
    
    for (NSInteger index = 0; index < userAlbums.count; index++) {
        PHAssetCollection * collection = userAlbums[index];
        PHFetchResult * imgs = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        ZMLog(@"相册名字---%@    相册内容---%@",collection.localizedTitle,imgs);
        [array addObject:collection];
        
    }
    self.arr_imageLibrary = array;
     
}
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original{

    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    ZMLog(@"相册名字---%@    相册内容---%@",assetCollection.localizedTitle,assets);
    
    for (PHAsset *asset in assets) {
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            ZMLog(@"相片----%@---图片信息---%@ 图片质量---%d",result,info,downloadFinined);

        }];
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
