//
//  IRDeviceTools.h
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/19.
//  Copyright © 2017年 irisZL. All rights reserved.
//

/*
 
 deviceID: 设备相关     
 （1）获取设备UUID
 （2）获取当前设备的型号 （iPhone4，iPhone5.....）
 （4）获取系统版本
 
 （6）获取应用的version
 （7）获取应用的build
 （8）获取应用的bundle identify
 
 */

#import <Foundation/Foundation.h>

@interface IRDeviceTools : NSString

/**
 获取设备真实UUID
 */
+ (NSString *)getDeviceUUID;


/**
 获取当前设备的型号
 */
+ (NSString *)getDeviceName;


/**
 获取系统版本
 */
+ (NSString *)getOriginalSystemVersion;


/**
 获取应用的version
 */
+ (NSString *)getAppVersion;


/**
 获取应用的build
 */
+ (NSString *)getAppBuild;


/**
 获取应用的bundle identify
 */
+ (NSString *)getAppBundleIdentify;



@end
