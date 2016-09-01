/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2015 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

#import "SubAdlibAdViewCore.h"
#import "ADLibSession.h"

#define kAdlibDefaultBannerSize CGSizeMake(320, 50)

// 더 이상 지원하지 않음.
//
//typedef NS_ENUM(NSInteger, ADLIB_BANNER_ALIGN) {
//    ADLIB_BANNER_ALIGN_LEFT   = 1,
//    ADLIB_BANNER_ALIGN_CENTER = 2, //DEFAULT
//    ADLIB_BANNER_ALIGN_RIGHT  = 3,
//};

typedef NS_ENUM(NSInteger, ADLIB_ADVIEW_VERTICAL_ALIGN) {

    ADLIB_ADVIEW_VERTICAL_ALIGN_BOTTOM = 0, //DEFAULT
    ADLIB_ADVIEW_VERTICAL_ALIGN_TOP    = 1,
};

typedef NS_ENUM(NSInteger, ADLIB_MEDPLATFORM) {
    
    ADLIB_MEDPLATFORM_ADMOB = 0,
    ADLIB_MEDPLATFORM_ADAM,
    ADLIB_MEDPLATFORM_ADMIXER,
    ADLIB_MEDPLATFORM_CAULY,
    ADLIB_MEDPLATFORM_INMOBI,
    ADLIB_MEDPLATFORM_TAD,
    ADLIB_MEDPLATFORM_SHALLWEAD,
    ADLIB_MEDPLATFORM_IAD,
    
    ADLIB_MEDPLATFORM_ADHUB,
    ADLIB_MEDPLATFORM_DOMOB,
    ADLIB_MEDPLATFORM_MEDIBAAD,
    ADLIB_MEDPLATFORM_MMEDIA,
    ADLIB_MEDPLATFORM_NAVER,
    
    ADLIB_MEDPLATFORM_FACEBOOK,
};

@class AdlibManager;

/**
 * 애드립 세션 연결 관련 델리게이트
 */
@protocol AdlibSessionDelegate <NSObject>

@optional

//애드립 세션 연결 성공 시 호출되는 메소드.
- (void)adlibManager:(AdlibManager *)manager didLinkedSessionWithUserInfo:(NSDictionary *)userInfo;
- (void)adlibManager:(AdlibManager *)manager didFailedSessionLinkWithError:(NSError *)error;

@end


/**
 * 애드립 배너 델리게이트 (띠 배너/전면 배너)
 */
@protocol AdlibManagerDelegate <NSObject>

@optional

//광고 수신 성공시 호출되는 메소드.
- (void)gotAd;

//광고 수신 성공시 호출되는 메소드.
- (void)didReceiveAdlibAd:(NSString*)from;

//광고 수신 실패시 호출되는 메소드.
- (void)didFailToReceiveAdlibAd:(NSString*)from;

// 전면광고 수신 성공시 호출되는 메소드.
- (void)didReceiveAdlibInterstitialAd:(NSString*)from;

// 전면광고 수신 실패시 호출되는 메소드.
- (void)didFailToReceiveAdlibInterstitialAd:(NSString*)from;

// 전면광고 닫힌 직후 호출되는 메소드.
- (void)didCloseAdlibInterstitialAd:(NSString*)from;

// 스케줄링 된 모든 전면광고 수신 실패시 호출되는 메소드.
- (void)didFailToReceiveAllInterstitialAd;

// 실패 시 호출되는 메소드.
- (void)failed;

@end


@interface AdlibManager : NSObject {
    
}

@property (nonatomic, weak) id<AdlibManagerDelegate> delegate;
@property (nonatomic, weak) id<AdlibSessionDelegate> sessionDelegate;


/**
 * AdlibManager 전역 객체
 */
+ (AdlibManager *)sharedSingletonClass;

/**
 * 설정 메소드
 */
- (void)linkWithAdlibKey:(NSString *)key;
- (void)testModeLinkWithAdlibKey:(NSString *)key;
- (void)unlink;

- (BOOL)registerPlatform:(ADLIB_MEDPLATFORM)ptype withClass:(Class)className;
- (void)setPlatform:(NSString*)name withClass:(Class)className;

- (void)setLogging:(BOOL)logging;

- (NSString*)getCurrentVersion;
- (ADLibSession *)adlibSharedSession;

/**
 * 띠 배너 관련 메소드
 */
- (void)attachWithViewController:(UIViewController *)controller
                 atContainerView:(UIView *)adView;

- (void)detach:(UIViewController*)parent;

- (void)attach:(UIViewController*)parent
      withView:(UIView*)view
  withDelegate:(id<AdlibManagerDelegate>)del;

- (void)attachWithViewController:(UIViewController *)controller
                 atContainerView:(UIView *)adView
                     adViewAlign:(ADLIB_ADVIEW_VERTICAL_ALIGN)vAlign;

- (void)attachWithViewController:(UIViewController *)controller
                 atContainerView:(UIView *)adView
                    withDelegate:(id<AdlibManagerDelegate>)del
                     adViewAlign:(ADLIB_ADVIEW_VERTICAL_ALIGN)vAlign;

- (void)moveAdContainer:(CGPoint)pt;

- (CGSize)size;

//  애드립 리워드배너만을 강제로 보여준다. 설정된 기타 플랫폼 광고 롤링 정보를 무시함.
// attach 수행 이후에 호출해야 정상 적용됨.
- (void)forceRewardBanner:(BOOL)bForce;

/**
 *  전면 광고 호출 메소드
 */
- (void)loadInterstitialAd:(UIViewController*)parent
              withDelegate:(id<AdlibManagerDelegate>)del;

/**
 *  전면 광고 뷰컨트롤러 종료 메소드
 *  @return 요청 성공 여부 (서브뷰에서 정의 되지 않은 경우 NO 리턴)
 */
- (BOOL)closeInterstitialAd:(BOOL)animated;

/**
 *  전면 광고 모든 플랫폼에 대한 요청 중단 메소드
 */
- (void)stopInterstitialAdRequest;

@end
