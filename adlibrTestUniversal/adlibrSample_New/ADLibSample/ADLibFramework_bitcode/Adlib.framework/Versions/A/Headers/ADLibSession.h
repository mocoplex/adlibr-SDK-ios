//
//  AdlibManager.h
//  ADLibSDK
//
//  Created by mocoplex on 2015. 1. 12..
//  Copyright (c) 2015년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const ADLibSessionDidFinishedLinkNotification;
extern NSString * const ADLibSessionDidFailedLinkNotification;

@class ADLibSession;

@protocol ADLibSessionDelegate <NSObject>

@optional

- (void)ADLibSession:(ADLibSession *)session didFinishedLinkWithUserInfo:(NSDictionary *)userInfo;
- (void)ADLibSession:(ADLibSession *)session didFailedLinkWithError:(NSError *)error;

@end


@interface ADLibSession : NSObject

@property (nonatomic, weak) id<ADLibSessionDelegate> delegate;
@property (nonatomic, copy, readonly) NSString *appKey;

- (instancetype)initWithAdlibKey:(NSString *)appKey;
- (instancetype)initTestSessionWithAdlibKey:(NSString *)appKey;

- (instancetype)initWithAdlibKey:(NSString *)appKey configSession:(ADLibSession *)session;

- (void)linkSession;
- (NSDictionary *)appConfigurations;

+ (void)setDebugMode;

+ (ADLibSession *)sharedSessionForKey:(NSString *)key isTestMode:(BOOL)isTestMode;
+ (void)clearAllSharedSession;

@end
