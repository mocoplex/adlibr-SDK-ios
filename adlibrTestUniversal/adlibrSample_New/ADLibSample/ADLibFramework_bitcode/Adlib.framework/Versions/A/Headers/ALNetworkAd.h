//
//  ALNetworkAd.h
//  Adlib
//
//  Created by gskang on 2017. 5. 12..
//  Copyright © 2017년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALNetworkAdResCode) {
    
    ALNetworkAdResCodeReceivedAd = 0,     //광고 응답 성공
    
    AALNetworkAdResCodeEmptyAd = 9000,    //광고 응답 실패 - 광고 없음
    
    ALNetworkAdResCodeInvalidKey,         //요청 매체키 에러
    ALNetworkAdResCodeADLibSessionError,  //애드립 세션연결 실패 에러
    
    ALNetworkAdResCodeNetworkError,       //요청 네트워크 에러
};

@class ALNetworkAd;

@protocol ALNetworkAdDelegate <NSObject>

- (void)alNetworkAdDidReceivedAd:(ALNetworkAd *)networkAd;
- (void)alNetworkAd:(ALNetworkAd *)networkAd didFailedAdWithState:(ALNetworkAdResCode)state;

@end


@interface ALNetworkAd : NSObject {
    
}

@property (nonatomic) BOOL isTestMode;  //default : NO
@property (nonatomic) BOOL isHouseMode; //default : NO

@property (nonatomic, readonly) BOOL isLoaded;

/**
 *  애드립 키값으로 초기화합니다.
 *  애드립 설정 세션 연결은 내부적으로 처리됩니다.
 */
- (id)initWithKey:(NSString *)key
         delegate:(id<ALNetworkAdDelegate>)delegate;

// 전면 배너 요청
- (BOOL)loadRequestInterstitial;

// 광고 요청 취소
- (void)cancelAdRequest;

// 배너 뷰 화면에 노출 처리
- (BOOL)attachToView:(UIView *)adContainerView withFrame:(CGRect)frame;

// 배너 뷰 화면에서 제거 처리
- (void)detachFromContainerView;

// 배너 뷰의 프레임을 재조정할 필요가 있을 경우 호출
- (void)needLayoutSubviews:(CGRect)frame;


// 광고 컨텐츠 로딩 시작
- (BOOL)loadContents;

// 광고 컨텐츠 로딩 중지
- (void)stopLoadingContents;

+ (NSString *)logForResultCode:(ALNetworkAdResCode)state;

@end
