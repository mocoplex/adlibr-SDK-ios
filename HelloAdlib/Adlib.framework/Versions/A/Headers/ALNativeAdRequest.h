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
    ALAdRequestErrCodeEmptyAd,          //광고 없음
    ALAdRequestErrCodeInternal,         //광고 요청 내부오류 발생
    ALAdRequestErrCodeSessionFailed,    //광고 요청 키 인증 오류
    ALAdRequestErrCodeResponseError,    //광고 응답 오류
    ALAdRequestErrCodeResCodeError,     //광고 서버 응답코드 오류
    ALAdRequestErrCodeNetworkError,     //광고 요청 네트워크 에러
    ALAdRequestErrCodeResourceDownload, //광고 소재 다운로드 에러
};

typedef NS_ENUM(NSInteger, ALAdRequestItemType){
    
    ALAdRequestItemTypeImageAd = 1,
    ALAdRequestItemTypeVideoAd = 2,
    ALAdRequestItemTypeAll     = 3,
};

@class ALNativeAdRequest, ALNativeAd;

@protocol ALNativeAdRequestDelegate <NSObject>

- (void)nativeAdRequest:(ALNativeAdRequest *)request didFinishWithAdCount:(NSInteger)adCount;
- (void)nativeAdRequest:(ALNativeAdRequest *)request didFailWithErrorCode:(ALAdRequestErrCode)code;

- (void)nativeAdRequest:(ALNativeAdRequest *)request didReceivedAd:(ALNativeAd *)nativeAd;

@end

@interface ALNativeAdRequest : NSObject {
    
}

@property (nonatomic, weak) id<ALNativeAdRequestDelegate> delegate;

// 광고 요청 타입을 지정할 수 있다.
// 기본으로 이미지 소재 광고만을 요청하며,
// 비디오 광고만 요청할 수 있고, 추가로 두 타입 모든 광고를 내려받도록 지정할 수 있다.
// default : ALAdRequestItemTypeImageAd
@property (nonatomic) ALAdRequestItemType requestItemType;

// 개발모드시 해당 값을 YES로 설정하고, 제공되는 개발키를 사용하여
// 노출 테스트를 할 수 있다.
@property (nonatomic) BOOL isTestMode; //default : NO

// 내부에서 발생된 에러 객체를 확인 할 수있다.
@property (nonatomic, readonly) NSError *error;


// 생성자 : 광고 키값을 지정하여 생성해야 광고를 수신할 수 있다.
- (id)initAdRequestWithKey:(NSString *)key;


// 네이티브 광고를 요청하는 함수 (기본값으로 1개의 광고를 요청한다.)
- (BOOL)startAdRequest;

// 네이티브 광고를 요청하는 함수, 한번에 n개 까지 광고를 묶음으로 요청할 수 있다.
// 최대 값은 10개로 제한된다.
- (BOOL)startAdRequestWithMaximumAdCount:(NSUInteger)count;

- (BOOL)startAdRequestWithMaximumAdCount:(NSUInteger)count
                                 timeout:(NSTimeInterval)timeout;

// 수행중인 광고 요청을 취소한다.
- (void)cancelAdRequest;

@end
