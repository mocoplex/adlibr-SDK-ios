//
//  ALAdapterAdam.m
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 8. 12..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import "ALAdapterAdam.h"
#import "AdamAdView.h"
#import "AdamInterstitial.h"

// ADAM의 TEST APP ID
#define ADAM_BANNER_TEST_ID  @"DAN-1hux8dwpvj581"
#define ADAM_INTERS_TEST_ID  @"DAN-rl2vglcby4hj"

/*
 * confirmed compatible with Adfit SDK
 */

@interface ALAdapterAdam () <AdamAdViewDelegate, AdamInterstitialDelegate>

@property (nonatomic, strong) AdamAdView *adView;

@end


@implementation ALAdapterAdam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mediationPlatform = ALMEDIATION_PLATFORM_ADAM;
    }
    return self;
}

- (AdamAdView *)adView
{
    return [AdamAdView sharedAdView];
}

/**
 *  띠배너 미디에이션 관련 구현 코드
 */

#pragma mark - mediation Banner protocol

- (BOOL)resizedAdViewWithBounds:(CGRect)adViewBounds
{
    //해당 광고뷰를 담는 부모뷰의 bounds내에서 프레임을 설정할 수 있다.
    //광고뷰의 프레임을 직접할경우 프레임 변경후 YES 리턴하도록 변경한다.
    //NO일 경우 애드립 SDK에서 프레임 조정
    return NO;
}

- (UIView *)platformAdView
{
    return self.adView;
}

- (UIView *)mediationBannerAdRequest:(UIViewController*)viewController withKey:(NSString *)key
{
    if (key == nil) {
        // 전면광고 실패를 알린다.
        [self mediationBannerAdFailedAd];
        return nil;
    }
    
    self.adView.frame    = self.bannerContainerView.bounds;
    self.adView.clientId = key;
    self.adView.delegate = self;
    
    [self.adView requestAd];
    
    return _adView;
}

/**
 *  전면배너 미디에이션 관련 구현 코드
 */

#pragma mark - mediation Interstitial protocol

// 해당 플래폼 광고에 전면광고 요청을 처리합니다.
- (BOOL)mediationInterstitialAdReqeust:(UIViewController*)viewController withKey:(NSString *)key
{
    if (key == nil) {
        // 전면광고 실패를 알린다.
        [self mediationInterstitialAdFailedAd];
        return YES;
    }
    
    AdamInterstitial *interstitial = [AdamInterstitial sharedInterstitial];
    interstitial.clientId = key;
    interstitial.superViewController = viewController;
    interstitial.delegate = self;
    [interstitial requestAndPresent];
    
    return YES;
}

#pragma mark - BannerViewDelegate

/**
 광고 수신 성공시 호출되는 메소드.
 @param adView 광고 수신 성공 이벤트가 발생한 AdamAdView 객체.
 */
- (void)didReceiveAd:(AdamAdView *)adView
{
    [self mediationBannerAdReceivedWithView:adView];
}

/**
 광고 수신 실패시 호출되는 메소드.
 광고 수신에 실패한 원인을 알고자 하는 경우, error.localizedDescription 값을 출력해보면 된다.
 @param adView 광고 수신 실패 이벤트가 발생한 AdamAdView 객체.
 @param error 광고 수신에 실패한 원인이 되는 error 객체.
 */
- (void)didFailToReceiveAd:(AdamAdView *)adView error:(NSError *)error
{
    NSLog(@"Adam didFailToReceiveAd : %@", error);
    [self mediationBannerAdFailedAd];
}

/**
 전체화면 광고가 보여질 때 호출되는 메소드.
 배너 광고를 터치하여 광고 페이지가 전체화면에 보여질 때 호출된다.
 @param adView 광고 페이지 열림 이벤트가 발생한 AdamAdView 객체.
 */
- (void)willOpenFullScreenAd:(AdamAdView *)adView
{
    
}

/**
 전체화면 광고가 닫힐 때 호출되는 메소드.
 전체화면으로 보여지고 있는 광고 페이지가 닫힐 때 호출된다.
 @param adView 광고 페이지 닫힘 이벤트가 발생한 AdamAdView 객체.
 */
- (void)willCloseFullScreenAd:(AdamAdView *)adView
{
}

/**
 광고 터치로 인해 애플리케이션이 종료될 때 호출되는 메소드.
 배너 광고를 터치하여 전화 걸기 또는 앱스토어로 이동하는 경우, 애플리케이션이 백그라운드로 들어가게 될 때 호출된다.
 @param adView 백그라운드로 전환 이벤트를 발생시킨 AdamAdView 객체.
 */
- (void)willResignByAd:(AdamAdView *)adView
{
    
}

#pragma mark - InterstitialDelegate

- (void)didReceiveInterstitialAd:(AdamInterstitial *)interstitial
{
    // 전면광고 성공을 알린다.
    [self mediationInterstitialAdReceived];
}

- (void)didFailToReceiveInterstitialAd:(AdamInterstitial *)interstitial error:(NSError *)error
{
    // 전면광고 실패를 알린다.
    [self mediationInterstitialAdFailedAd];
}

- (void)didCloseInterstitialAd:(AdamInterstitial *)interstitial
{
    // 전면광고 닫힘을 알린다.
    [self mediationInterstitialAdViewClosed];
}

@end
