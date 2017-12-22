//
//  ALAdapterAdfit.m
//  AdlibNativeADSample
//
//  Created by mocoplex on 2017. 11. 20..
//  Copyright © 2017년 mocoplex. All rights reserved.
//

#import "ALAdapterAdfit.h"
#import <AdFitSDK/AdFitSDK-Swift.h>

// ADAM의 TEST APP ID
#define ADAM_BANNER_TEST_ID  @"DAN-"
#define ADAM_INTERS_TEST_ID  @"DAN-"

/*
 * confirmed compatible with Adfit SDK 3.0
 *
 * Adfit 3.0 이상에서만 지원되는 어뎁터 파일입니다.
 * 3.0 이전버전 사용의 경우 ALAdapterAdam 클래스를 참고하세요.
 *
 * Adfit 3.0 버전에서 전면광고를 지원하고 있지 않기 때문에 구현에서 제외됩니다.
 */

@interface ALAdapterAdfit () <AdFitBannerAdViewDelegate>

@property (nonatomic, strong) AdFitBannerAdView *adView;

@end


@implementation ALAdapterAdfit

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mediationPlatform = ALMEDIATION_PLATFORM_ADAM;
    }
    return self;
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
    return _adView;
}

- (UIView *)mediationBannerAdRequest:(UIViewController*)viewController withKey:(NSString *)key
{
    if (key == nil) {
        // 전면광고 실패를 알린다.
        [self mediationBannerAdFailedAd];
        return nil;
    }
    
    if (_adView == nil) {
        AdFitBannerAdView *adView = [[AdFitBannerAdView alloc] initWithClientId:key adUnitSize:@"320*50"];
        self.adView = adView;
        _adView.refreshInterval = 0.f;
        _adView.delegate = self;
    }
    
    self.adView.frame = self.bannerContainerView.bounds;
    self.adView.rootViewController = viewController;
    [self.adView loadAd];
    
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
    
    //SDK에서 전면광고를 지원하고 있지 않지만,
    //미디에이션 실패를 전다랗기 위해 전면광고 실패를 호출합니다.
    [self mediationInterstitialAdFailedAd];
    return YES;
}

#pragma mark - BannerViewDelegate

/**
 광고 수신 성공시 호출되는 메소드.
 */
- (void)adViewDidReceiveAd:(AdFitBannerAdView *)bannerAdView {
    NSLog(@"didReceiveAd");
    
    [self mediationBannerAdReceivedWithView:bannerAdView];
}

/**
 광고 수신 실패시 호출되는 메소드.
 광고 수신에 실패한 원인을 알고자 하는 경우, error.localizedDescription 값을 출력해보면 된다.
 */
- (void)adViewDidFailToReceiveAd:(AdFitBannerAdView *)bannerAdView error:(NSError *)error {
    NSLog(@"didFailToReceiveAd - error = %@", [error localizedDescription]);
    
    [self mediationBannerAdFailedAd];
}

- (void)adViewDidClickAd:(AdFitBannerAdView *)bannerAdView {
    NSLog(@"didClickAd");
}

@end

