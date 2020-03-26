//
//  TakeAPictureView.m
//  自定义相机
//
//  Created by macbook on 16/9/2.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import "TakeAPictureView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "UIImage+info.h"

@interface TakeAPictureView ()
@property (nonatomic, strong)AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureSession *session;/**< 输入和输出设备之间的数据传递 */
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;/**< 输入设备 */
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;/**< 照片输出流 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;/**< 预览图片层 */
@property (nonatomic, strong) UIImage *image;

@end

@implementation TakeAPictureView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initAVCaptureSession];
    [self initCameraOverlayView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initAVCaptureSession];
        [self initCameraOverlayView];
    }
    return self;
}

- (void)startRunning
{
    if (self.session) {
        [self.session startRunning];
    }
}

- (void)stopRunning
{
    if (self.session) {
        [self.session stopRunning];
    }
}

- (void)initCameraOverlayView
{
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    CGFloat imageW = width - 100;
    CGFloat imageH = imageW / 0.7358;
    CGFloat imageX = 50;
    CGFloat imageY = (height -imageH) / 4;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    imageV.image = [UIImage imageNamed:@"头像框"];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame) + 30, width, 40)];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"请将人脸移入框内";
//    label.font = [UIFont systemFontOfSize:16];
//    [label setBackgroundColor:[UIColor blackColor]];
//    label.textColor = [UIColor whiteColor];
    
    
    UIButton* remindBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame) + 30, width, 50)];
    [remindBtn setTitle:@"请将人脸移入框内" forState:UIControlStateNormal];
    [remindBtn setImage:[UIImage imageNamed:@"photoRemind"] forState:UIControlStateNormal];
    [remindBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,
                                                    remindBtn.imageView.frame.size.width + 5, 0, remindBtn.imageView.frame.size.width)];
    [remindBtn setImageEdgeInsets:UIEdgeInsetsMake(0, - remindBtn.titleLabel.bounds.size.width - 5, 0, - remindBtn.titleLabel.bounds.size.width)];
    remindBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [remindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [remindBtn setBackgroundColor:[UIColor blackColor]];
    
    
    UIView* backView = [[UIView alloc] init];
    [backView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    backView.frame = CGRectMake(0, 0, width, height);
    
//    //半透明背景View
//    UIView *viewTop = [[UIView alloc] init];
//    [viewTop setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
//    viewTop.frame = CGRectMake(0, 0, width, (height - imageH) / 2);
//
//    UIView *viewLeft = [[UIView alloc] init];
//    [viewLeft setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
//    viewLeft.frame = CGRectMake(0, (height - imageH) / 2 , imageX, imageH);
//
//    UIView *viewRight = [[UIView alloc] init];
//    [viewRight setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
//    viewRight.frame = CGRectMake(imageW + 20, (height - imageH) / 2 , imageX, imageH);
//
//    UIView *viewBottom = [[UIView alloc] init];
//    [viewBottom setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
//    viewBottom.frame = CGRectMake(0, imageY + imageH, width, height-imageY - imageH );

    
//    [self addSubview:viewTop];
//    [self addSubview:viewLeft];
//    [self addSubview:viewRight];
//    [self addSubview:viewBottom];
    [self addSubview:backView];
    [self addSubview:remindBtn];
    [self addSubview:imageV];
    
}

- (void)initAVCaptureSession {
    self.session = [[AVCaptureSession alloc] init];
    NSError *error;
    self.device = [self cameraWithPosition:AVCaptureDevicePositionFront];//[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [self.device lockForConfiguration:nil];
    
    // 设置闪光灯自动
    [self.device setFlashMode:AVCaptureFlashModeAuto];
    [self.device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    // 照片输出流
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    // 设置输出图片格式
    NSDictionary *outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    // 初始化预览层
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    self.previewLayer.frame = self.bounds;
    [self.layer addSublayer:self.previewLayer];
    
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}
// 获取设备方向

- (AVCaptureVideoOrientation)getOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft) {
        return AVCaptureVideoOrientationLandscapeRight;
    } else if ( deviceOrientation == UIDeviceOrientationLandscapeRight){
        return AVCaptureVideoOrientationLandscapeLeft;
    }else{
        return AVCaptureVideoOrientationPortrait;
    }
    return (AVCaptureVideoOrientation)deviceOrientation;
}

// 拍照
- (void)takeAPicture
{
    UIImageOrientation imgOrientation; //拍摄后获取的的图像方向
    
    if ([self.device.localizedName isEqualToString:@"背面相机"]) {
        
        // 后置摄像头图像方向 UIImageOrientationRight
        imgOrientation = UIImageOrientationRight;
        
        NSLog(@"后置摄像头");
        
    } else {
        
        // 前置摄像头图像方向 UIImageOrientationLeftMirrored
        // IOS前置摄像头左右成像
        imgOrientation = UIImageOrientationLeftMirrored;
        
        NSLog(@"前置摄像头");
    }
    

    
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation avOrientation = [self getOrientationForDeviceOrientation:curDeviceOrientation];
    [stillImageConnection setVideoOrientation:avOrientation];
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];

        UIImage *t_image = [UIImage imageWithData:jpegData];
        UIImage *image = [[UIImage alloc]initWithCGImage:t_image.CGImage scale:1.0f orientation:imgOrientation];

        
        //定义保存图片的大小
        CGFloat width =image.size.width;
        CGFloat height =image.size.height;
        image = [UIImage image:image scaleToSize:CGSizeMake(width, height)];

        NSLog(@"屏幕宽高==%f==%f",self.frame.size.width,self.frame.size.height);
        NSLog(@"裁剪前宽高==%f==%f",image.size.width,image.size.height);
        //定义裁剪
        CGFloat imageW = width - 140;
        CGFloat imageH = imageW / 0.7358;
        CGFloat imageX = 70;
        CGFloat imageY = (height -imageH) / 4;
        CGRect rect = CGRectMake(imageX, imageY, imageW, imageH);
        image = [UIImage imageFromImage:image inRect:rect];
        

        
        //回调
        if(_blockTakePicture != nil){
            self.blockTakePicture(image);   
        }
        
    }];
    
}




@end
