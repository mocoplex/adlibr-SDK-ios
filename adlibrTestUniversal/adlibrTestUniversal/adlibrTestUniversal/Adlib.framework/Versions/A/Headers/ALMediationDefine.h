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

typedef NS_ENUM(NSInteger, ALMEDIAION_STATE) {
    
    ALMEDIAION_STATE_INVALID_SUPERVIEW = -9999,
    ALMEDIAION_STATE_INVALID_MEDIATION_KEY,
    ALMEDIAION_STATE_INVALID_SESSION,
    ALMEDIAION_STATE_INVALID_MEDIATION_SCHEDULE,
    ALMEDIAION_STATE_INVALID_PLATFORM_KEY,
    
    ALMEDIAION_STATE_STARTED = 0,
    ALMEDIAION_STATE_PREPARED,
    ALMEDIAION_STATE_STOPPED,
    
    ALMEDIAION_STATE_RECEIVED_AD,
    ALMEDIAION_STATE_FAILED_AD,
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
- (BOOL)mediationBannerAdRequest:(UIViewController*)viewController withKey:(NSString *)key;

- (void)mediationBannerAdReceivedWithView:(UIView *)view;
- (void)mediationBannerAdFailedAd;

- (void)mediationBannerReportClickEvent;

@end


@interface ALMediationDefine : NSObject {
    
}

+ (NSString *)nameOfPlatform:(ALMEDIATION_PLATFORM)ptype;

+ (NSString *)descriptionOfState:(ALMEDIAION_STATE)state;

@end
