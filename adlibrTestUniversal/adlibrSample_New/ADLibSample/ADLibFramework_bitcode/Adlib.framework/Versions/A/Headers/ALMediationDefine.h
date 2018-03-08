//
//  ALMediationDefine.h
//  Adlib
//
//  Created by gskang on 2016. 4. 21..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//플랫폼 AID 정의 타입
typedef NS_ENUM(NSInteger, ALMEDIATION_PLATFORM) {
    
    ALMEDIATION_PLATFORM_DEFAULT       = -100,
    ALMEDIATION_PLATFORM_ADLIB         = 7,    //Adlib
    ALMEDIATION_PLATFORM_ADLIBHOUSE    = 711,  //Adlib-House
    
    ALMEDIATION_PLATFORM_ADAM          = 0,
    ALMEDIATION_PLATFORM_ADCUBE        = 1,
    ALMEDIATION_PLATFORM_ADMOB         = 2,
    ALMEDIATION_PLATFORM_CAULY         = 3,
    ALMEDIATION_PLATFORM_TAD           = 4,
    ALMEDIATION_PLATFORM_IAD           = 5,
    ALMEDIATION_PLATFORM_INMOBI        = 6,
    
    ALMEDIATION_PLATFORM_NAVER         = 9,
    ALMEDIATION_PLATFORM_MM            = 10,
    ALMEDIATION_PLATFORM_MOJIVA        = 11,
    ALMEDIATION_PLATFORM_SHALLWEAD     = 12,
    ALMEDIATION_PLATFORM_ADHUB         = 13,
    ALMEDIATION_PLATFORM_AROUNDERS     = 14,
    ALMEDIATION_PLATFORM_ADSQUARE      = 15,
    ALMEDIATION_PLATFORM_ADMIXER       = 16,
    
    ALMEDIATION_PLATFORM_MMEDIA        = 20,
    ALMEDIATION_PLATFORM_MOPUB         = 21,
    ALMEDIATION_PLATFORM_MOBCLIX       = 22,
    ALMEDIATION_PLATFORM_AMOAD         = 23,
    ALMEDIATION_PLATFORM_MEDIBAAD      = 24,
    ALMEDIATION_PLATFORM_MEZZO         = 25,
    ALMEDIATION_PLATFORM_GOOGLEMED     = 26,
    ALMEDIATION_PLATFORM_ADMOBECPM     = 27,
    ALMEDIATION_PLATFORM_DOMOB         = 28,
    ALMEDIATION_PLATFORM_UPLUSAD       = 29,   //U+Ad 지원 종료
    
    ALMEDIATION_PLATFORM_FACEBOOK      = 33,
};


typedef NS_ENUM(NSInteger, ALMEDIATION_STATE) {
    
    ALMEDIATION_STATE_INVALID_SUPERVIEW = -9999,
    ALMEDIATION_STATE_INVALID_MEDIATION_KEY,
    ALMEDIATION_STATE_INVALID_SESSION,
    ALMEDIATION_STATE_INVALID_MEDIATION_SCHEDULE,
    ALMEDIATION_STATE_INVALID_PLATFORM_KEY,
    
    ALMEDIATION_STATE_STARTED = 0,
    ALMEDIATION_STATE_PREPARED,
    ALMEDIATION_STATE_STOPPED,
    
    ALMEDIATION_STATE_RECEIVED_AD,
    ALMEDIATION_STATE_FAILED_AD,
    ALMEDIATION_STATE_FAILED_ALL,
    ALMEDIATION_STATE_BANNER_CLICKED,
    
};

@protocol ALMediationInterstitialProtocol <NSObject>

// 해당 플래폼 광고에 전면광고 요청을 처리합니다.
- (BOOL)mediationInterstitialAdReqeust:(UIViewController*)viewController withKey:(NSString *)key;

- (void)mediationInterstitialAdReceived;
- (void)mediationInterstitialAdFailedAd;
- (void)mediationInterstitialAdViewClosed;

- (void)mediationInterstitialAdReportClickEvent;

@end


@protocol ALMediationBannerProtocol <NSObject>

// 해당 플래폼 광고에 배너광고 요청을 처리합니다.

/**
 *  미디에이션 광고 플랫폼의 배너 뷰를 반환한다.
 */
- (UIView *)platformAdView;

/**
 *  배너뷰의 프레임이 변경되면 하위 광고 뷰들에게 해당 메소드를 통해
 *  뷰사이즈 변경을 알린다.
 *
 *  @param adViewBounds 변경된 뷰의 크기
 *  @return YES : 플랫폼 미디에이션 구현 코드에서 직접 프레임의 사이즈를 변경함을 알림
 *           NO : 직접 변경하지 않고 NO 리턴 시 배너뷰의 크기와 동일하게 변경됨
 */
- (BOOL)resizedAdViewWithBounds:(CGRect)adViewBounds;

/**
 *  미디에이션 광고 플랫폼의 광고요청 처리를 구현한다.
 *
 *  @return 광고를 요청한 플랫폼 광고 뷰
 */
- (UIView *)mediationBannerAdRequest:(UIViewController*)viewController withKey:(NSString *)key;

/**
 *  미디에이션 광고 플랫폼의 광고 수신 성공 후 해당 광고 뷰를 반환한다.
 */
- (void)mediationBannerAdReceivedWithView:(UIView *)view;

/**
 *  미디에이션 광고 플랫폼의 광고 수신 실패를 반환한다.
 */
- (void)mediationBannerAdFailedAd;

/**
 *  미디에이션 광고 플랫폼의 광고 클릭 이벤트 발생을 반환한다.
 */
- (void)mediationBannerReportClickEvent;

/**
 *  광고 뷰 정지 이벤트를 처리한다.
 */
- (void)removeBannerViewFromSuperview;

@end


@interface ALMediationDefine : NSObject {
    
}

+ (NSString *)nameOfPlatform:(ALMEDIATION_PLATFORM)ptype;

+ (NSString *)descriptionOfState:(ALMEDIATION_STATE)state;

@end
