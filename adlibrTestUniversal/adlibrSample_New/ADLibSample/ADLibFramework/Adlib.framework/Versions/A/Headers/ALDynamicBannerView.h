//
//  ALDynamicBannerView.h
//  Adlib
//
//  Created by gskang on 2015. 10. 6..
//  Copyright © 2015년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADLibSession.h"

// 다이나믹 사이즈 하우스 광고 뷰 (이미지 광고만 지원)
//
// 업로드 가능 이미지 사이즈 500K
// ex : 600x600 사이즈 이미지 업로드시
// SDK 광고 이미지는 300x300 크기로 사용 (서버 이미지는 @2x 기준)
//
// 등록이 허가된 사이즈만을 등록/요청할 수 있음.
// 해당내용에 대한 요청이 필요

typedef NS_ENUM(NSInteger, ALDynamicBannerState){
    
    ALDynamicBannerStateRequestStart    = -1000,
    ALDynamicBannerStateReceivedAd      = -1001,
    
    ALDynamicBannerStateNetworkError    = -1002,
    ALDynamicBannerStateRequestFailed   = -1003,
    ALDynamicBannerStateResponseFailed  = -1004,
    
    ALDynamicBannerStateResponseEmptyAd = -1005,
    ALDynamicBannerStateNotFoundImageSource = -1006,
    
    ALDynamicBannerStateADLibSessionError = -1007,
    ALDynamicBannerStateNotFoundAdmSource = -1008,
    
    ALDynamicBannerStateInvalidKey = -1009,
    ALDynamicBannerStateSessionLinkError = -1010,
    
    //광고뷰 속성 hidden YES로 변경되는 상태를 알림
    ALDynamicBannerStateSetViewHidden  = 9998,
    
    //광고뷰 속성 hidden NO로 변경되는 상태를 알림
    ALDynamicBannerStateSetViewVisible = 9999,
};

@interface ALDynamicBannerView : UIView {
    
}

@property (nonatomic, strong) UIColor *bannerBackgroundColor;

//광고 이미지의 contentMode 설정
//기본 값 : UIViewContentModeScaleAspectFit
@property (nonatomic) UIViewContentMode imageContentMode;

//광고 소재 이미지 재사용 여부
//기본 값 : YES
@property (nonatomic) BOOL useImageCache;

//자동 갱신 시간
//기본 값 : 0 (0으로 지정시 자동 갱신 없음)
//최소 값 : 3 초
@property (nonatomic) NSTimeInterval refreshTimeinterval;

//네트워크 에러
@property (nonatomic, strong, readonly) NSError *error;

//테스트 모드 설정 값 (기본값 : NO)
@property (nonatomic) BOOL isTestMode;

/**
 *  광고 요청 시작 메소드
 *  @param session 애드립 설정정보가 연결된 세션 객체 (Weak Ref.)
 *  @param bannerSize 광고 이미지 크기 (내부적으로는 정수값으로 변환되어 호출함)
 */

// startAdRequestWithAdlibKey: 메소드로 대체한다.
- (void)startAdRequestWithAdlibSession:(ADLibSession *)session bannerSize:(CGSize)bannerSize;

/**
 *  광고 요청 시작 메소드
 *  @param key 애드립 키
 *  @param bannerSize 광고 이미지 크기 (내부적으로는 정수값으로 변환되어 호출함)
 */
- (void)startAdRequestWithAdlibKey:(NSString *)key bannerSize:(CGSize)bannerSize;

/**
 *  광고 요청 중지 메소드
 */
- (void)stopAdRequest;

- (void)setRequestAdStateHandler:(void (^)(ALDynamicBannerState state))handler;

+ (UIImage *)closeButtonImage;

/**
 *  Error Log 출력 설정
 */
+ (void)setLogging:(BOOL)logging;

@end
