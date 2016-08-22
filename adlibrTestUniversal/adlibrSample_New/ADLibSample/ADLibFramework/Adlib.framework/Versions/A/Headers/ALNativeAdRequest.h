//
//  ALNativeAdRequest.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 9..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ALAdRequestErrCode){
    
    ALAdRequestErrCodeNone = 0,
    ALAdRequestErrCodeEmptyAd,
    ALAdRequestErrCodeInternal,
    ALAdRequestErrCodeSessionFailed,
    ALAdRequestErrCodeResponseError,
    ALAdRequestErrCodeResCodeError,
    ALAdRequestErrCodeNetworkError,
};

typedef NS_ENUM(NSInteger, ALAdRequestItemType){
    
    ALAdRequestItemTypeImageAd = 1,
    ALAdRequestItemTypeVideoAd = 2,
    ALAdRequestItemTypeAll     = 3,
};

@class ALNativeAdRequest, ALNativeAd;

@protocol ALNativeAdRequestDelegate <NSObject>

- (void)nativeAdRequest:(ALNativeAdRequest *)request didFinishWithData:(ALNativeAd *)nativeAd;
- (void)nativeAdRequest:(ALNativeAdRequest *)request didFailWithErrorCode:(ALAdRequestErrCode)code;

@end

@interface ALNativeAdRequest : NSObject {
    
}

@property (nonatomic, weak) id<ALNativeAdRequestDelegate> delegate;

- (id)initAdRequestWithAppId:(NSString *)appid;

- (BOOL)startAdRequest;
- (void)cancelAdRequest;

@end
