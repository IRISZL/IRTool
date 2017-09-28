//
//  IRDeviceTools.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/19.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "IRDeviceTools.h"
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
#import "sys/utsname.h"

@implementation IRDeviceTools

/**
 获取设备真实UUID
 */
+ (NSString *)getDeviceUUID
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Identifier" accessGroup:nil];
    NSString *UUID = [keychainItem objectForKey:(__bridge id)kSecAttrGeneric];
    
    if ((UUID == nil) || UUID.length <= 0) {
        
        //UUID不存在则先创建UUID并保存，并且传值出去
        UUID = [self getUUIDString];
        [self saveUUIDToKeyChainWithUUIDString:UUID];
    }
    
    return UUID;
}

+ (void)saveUUIDToKeyChainWithUUIDString:(NSString *)uuidString
{
    // 如果想要跟其他的应用共享，则将accessGroup修改为共享使用的ID，具体如何配置请参考百度
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Identifier" accessGroup:nil];
    NSString *string = [keychainItem objectForKey:(__bridge id)kSecAttrGeneric];
    
    if (string && string.length > 0) {
        
        if (![uuidString isEqualToString:string]) {
            NSLog(@"警告警告：需要查找原因，为什么会出现不相等的情况");
        }
    }
    else
    {
        [keychainItem setObject:uuidString.length > 0 ? uuidString : @"" forKey:(__bridge id)kSecAttrGeneric];
    }
}


+ (NSString *)getUUIDString
{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    NSString *uuidString = [(__bridge NSString *)strRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(strRef);
    CFRelease(uuidRef);
    return uuidString;
}


/**
 获取当前设备的型号 
 备注：目前只到iPhone7 plus，等iphone8 跟iphone8plus and iphone X出现之后再进行补充
 */
+ (NSString *)getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    
    if ([deviceString isEqualToString:@"iPhone4,2"])    return @"iPhone 4S";
    
    if ([deviceString isEqualToString:@"iPhone4,3"])    return @"iPhone 4S";
    
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iphone10,1"])     return @"iphone 8";
    
    if ([deviceString isEqualToString:@"iphone10,4"])     return @"iphone 8";
    
    if ([deviceString isEqualToString:@"iphone10,2"])     return @"iphone 8 plus";
    
    if ([deviceString isEqualToString:@"iphone10,5"])     return @"iphone 8";
    
    if ([deviceString isEqualToString:@"iphone10,3"])     return @"iphone X";
    
    if ([deviceString isEqualToString:@"iphone10,6"])     return @"iphone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"%s Error NOTE: Unknown device type: %@", __func__, deviceString);
    return @"iPhone";

}


/**
 获取系统版本
 */
+ (NSString *)getOriginalSystemVersion
{
    NSString *version = @"IOS version is unknow";
    float systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (systemVersion > 0)
    {
        version = [NSString stringWithFormat:@"%.2f",systemVersion];
    }
    return version;
}


/**
 获取应用的version
 */
+ (NSString *)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/**
 获取应用的build
 */
+ (NSString *)getAppBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}

/**
 获取应用的bundle identify
 */
+ (NSString *)getAppBundleIdentify
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

@end
