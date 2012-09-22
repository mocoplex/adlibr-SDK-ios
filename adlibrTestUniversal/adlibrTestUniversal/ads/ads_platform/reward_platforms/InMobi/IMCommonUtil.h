//
//  IMCommonUtil.h
//  InMobi Commons SDK
//
//  Copyright (c) 2012 InMobi Technology Services Ltd. All rights reserved.
//

#define ___INMOBI_COMMONS_VERSION_3_6_0___
#import <Foundation/Foundation.h>

/**
 * Console Logging Levels.
 */
typedef enum {
    /**
     * IMLogLevelTypeNone
     * No logs. (default)
     */
    IMLogLevelTypeNone    = 0,  
    /**
     * IMLogLevelTypeDebug
     * Log Level for Normal Debugging.
     */
    IMLogLevelTypeDebug   = 1,
    /**
     * IMLogLevelTypeVerbose
     * Log Level for Full Debugging.
     */
    IMLogLevelTypeVerbose = 2,

} IMLogLevelType;

/**
 * Device ID Collection Mask
 */
typedef enum {
    /**
     * IMDevice_IncludeDefaultIds
     * Use default ids for Device Id Collection. (default)
     */
    IMDevice_IncludeDefaultIds      = 0,
    /**
     * IMDevice_ExcludeODIN1
     * Exclude ODIN1 Identifier from Device Id Collection.
     */
    IMDevice_ExcludeODIN1           = 1<<0,
    /**
     * IMDevice_ExcludeAdvertisingId
     * Exclude advertisingIdentifier from Device Id Collection. (iOS 6+)
     */
    IMDevice_ExcludeAdvertisingId    = 1<<1,
    /**
     * IMDevice_ExcludeVendorId
     * Exclude identifierForVendor from Device Id Collection. (iOS 6+)
     */
    IMDevice_ExcludeVendorId        = 1<<2,

} IMDeviceIdMask;

/**
 * InMobi commons that provide common services to all InMobi SDKs.
 */
@interface IMCommonUtil : NSObject {

}
/**
 * Set the console logging level for debugging purpose.
 * @param logLevel - Log Level to be set.
 */
+ (void)setLogLevel:(IMLogLevelType)logLevel;
/**
 * Returns the log level set.
 * @return the log level set.
 */
+ (IMLogLevelType)getLogLevel;

/**
 * This sets the Device Id Mask so as to restrict the Device Tracking not
 * to be based on certain Device Ids.
 * @param deviceIdMask - Device Id Mask to be set.
 */
+ (void)setDeviceIdMask:(IMDeviceIdMask)deviceIdMask;
/**
 * Returns the Device Id Mask set.
 * @return the Device Id Mask set.
 */
+ (IMDeviceIdMask)getDeviceIdMask;

/**
 * Returns the sdk release version.
 * @return the sdk release version.
 */
+ (NSString *)getReleaseVersion;

@end
