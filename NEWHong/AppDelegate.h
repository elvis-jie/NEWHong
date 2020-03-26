//
//  AppDelegate.h
//  NEWHong
//
//  Created by 尚广杰 on 2020/3/25.
//  Copyright © 2020 尚广杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX mDeviceWidth >=375.0f && mDeviceHeight >=812.0f&& kIs_iphone
#define mDeviceWidth [UIScreen mainScreen].bounds.size.width        //屏幕宽
#define mDeviceHeight [UIScreen mainScreen].bounds.size.height      //屏幕高
#define kNavBarHeight (kIs_iPhoneX ? 88.f : 64.f)

#define KSAFEBAR_HEIGHT  ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 34 : 0.0) //底部安全区域高度
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

