/**
 * IMSDKUtil.h
 * @description InMobi SDK Utility class
 * @author: InMobi
 * Copyright (c) 2012 InMobi Pte Limited. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef enum {
    /**
     * The default minimal log level.
     */
    IMLogLevelMinimal = 1,
    /**
     * The log level used for debugging purposes.
     */
    IMLogLevelDebug = 2,
    /**
     * The log level used for critical debugging.
     */
    IMLogLevelCritical = 3
} LogLevel;

@interface IMSDKUtil : NSObject {
    LogLevel logLevel;
}
/**
 * The LogLevel, for printing console messages.
 */
@property (nonatomic, assign) LogLevel logLevel;
/**s
 * @description - This method returns the InMobi iOS SDK version.
 * Typically of the format @"3.0.2", @"3.5.0", and so on.
 */
- (NSString *)sdkVersion;
/**
 * Returns the singleton instance of this class.
 */
+ (IMSDKUtil *)util;
/**
 * Send the application installed tracker conversion ping to the server. The
 * information will be sent only once and calling multiple times does not
 * have any effect.
 * 
 * @param itunesId - App Store/iTunes ID of your app, as obtained from Apple.
 * @param advertiserId - Advertiser ID.
 */
- (void)startAppTrackerConversion:(NSString *)advertiserId iTunesId:(NSString *)itunesId;

@end
