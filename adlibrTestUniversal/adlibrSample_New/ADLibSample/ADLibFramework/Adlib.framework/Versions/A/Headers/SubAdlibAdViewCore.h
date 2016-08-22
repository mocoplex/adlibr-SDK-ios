//
//  SubAdlibAdViewCore.h
//  AdlibTestProject
//
//  Created by Nara Park on 12. 2. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubAdlibAdsView.h"

@class AdlibManager, ADLibMediator;

@interface SubAdlibAdViewCore : NSObject {
    
}

+ (BOOL)isStaticObject;

- (SubAdlibAdViewCore*)initWithManager:(AdlibManager*)m;
- (SubAdlibAdViewCore*)initWithMediator:(ADLibMediator*)mediator;

- (void)query:(UIViewController*)parent;
- (void)clearAdView;
- (void)startAdRequest;
- (void)stopAdRequest;
- (void)adsizeChanged;
- (void)gotAd;
- (void)failed;
- (BOOL)isLoaded;
- (BOOL)isPortrait;
- (void)orientationChanged;
- (void)resizeAdView;

- (void)setContainerView:(UIView *)cView;
- (UIViewController*)getParentController;

/**
 * 상속 받는 플랫폼 광고뷰 클래스에서 재정의 
 * 반환하는 값에 의해 SubAdlibAdView의 Superview(ContainerView)에서의 위치를 조정하는데 사용됨.
 * 재정의 하지 않는다면 기본 적으로 Superview의 가로 넓이 값과 기본 50의 높이값이 사용된다.
 *
 * @param CGSize 플랫폼 광고 뷰의 사이즈를 반환
 */
- (CGSize)size;

/**
 * AdlibManager를 사용한 호출 메소드
 */
- (void)subAdlibViewLoadInterstitial:(UIViewController*)viewController;
- (void)subAdlibViewInterstitialReceived:(NSString*)from;
- (void)subAdlibViewInterstitialFailed:(NSString*)from;
- (void)subAdlibViewInterstitialClosed:(NSString*)from;

// 광고 화면 처리 (2014.09.24 - yongsun)
- (void)queryAd;

// 띠배너 광고 클릭 이벤트를 애드립 대시보드에 리포트
- (void)reportBannerClickEvent;

// 전면 광고 클릭 이벤트를 애드립 대시보드에 리포트
- (void)reportInterstitialClickEvent;

/**
 *  애드립 매니저에 의한 전면광고 강제 종료 요청 처리
 *  @param animated 종료시 애니메이션 옵션
 *  @return 해당 서브뷰에서 재정의 시 YES,
 */
- (BOOL)autoCloseInterstitialAd:(BOOL)animated;

/**
 *  애드립 매니저에 의한 전면광고 네트워크 요청 중지 처리
 *  @return 해당 서브뷰에서 재정의 시 YES,
 */
- (BOOL)stopInterstitialAdRequest;

@property (nonatomic, strong) SubAdlibAdsView* view;
@property (nonatomic, weak)   UIViewController* parentController;

@end
