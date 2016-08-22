//
//  ALAdapterFacebook.m
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 8. 18..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import "ALAdapterFacebook.h"
#import <FBAudienceNetwork/FBAudienceNetwork.h>


/*
 * confirmed compatible with Facebook SDK 
 */

@interface ALAdapterFacebook () <FBAdViewDelegate, FBInterstitialAdDelegate>

@property (nonatomic, strong) FBAdView *adView;
@property (nonatomic, strong) FBInterstitialAd *fbInterstitialAd;

@end


@implementation ALAdapterFacebook

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.mediationPlatform = ALMEDIATION_PLATFORM_FACEBOOK;
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
    //광고뷰 생성시 배너키 값이 필요해서 미리 생성해두고 사용할 수 없다.
    //광고 수신 완료 후의 배너뷰를 애드립 미디에이션으로 전달하여 사용한다.
    //따라서 수신 요청 단계에서 SDK 내부에서 미리 뷰를 추가해 둘 수는 없다.
    //_adView == nil 인 경우에 해당
    
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
        
        // 광고뷰를 생성합니다.
        FBAdView *adView = [[FBAdView alloc] initWithPlacementID:key
                                                          adSize:kFBAdSizeHeight50Banner
                                              rootViewController:self.rootViewController];
        self.adView = adView;
        self.adView.delegate = self;
        [self.adView disableAutoRefresh];
        
        _adView.frame = self.bannerContainerView.bounds;
    }
    
    [_adView loadAd];
    
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
    
    FBInterstitialAd *interstitialAd = [[FBInterstitialAd alloc] initWithPlacementID:key];
    self.fbInterstitialAd = interstitialAd;
    self.fbInterstitialAd.delegate = self;
    
    [self.fbInterstitialAd loadAd];
    
    return YES;
}

#pragma mark - FBAdViewDelegate

- (void)adViewDidLoad:(FBAdView *)adView
{
    NSLog(@"FB Ad was loaded and ready to be displayed");
    
    // 화면에 광고를 보여줍니다.
    [self mediationBannerAdReceivedWithView:adView];
}

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error
{
    NSLog(@"FB Ad failed to load");
    
    // 광고 수신에 실패 처리를 요청합니다.
    [self mediationBannerAdFailedAd];
}

- (void)adViewDidClick:(FBAdView *)adView
{
    NSLog(@"The user clicked on the ad and will be taken to its destination.");
}

- (void)adViewDidFinishHandlingClick:(FBAdView *)adView
{
    NSLog(@"The user finished to interact with the ad.");
    
    [self mediationBannerReportClickEvent];
}

- (UIViewController *)viewControllerForPresentingModalView
{
    // return the view controller that is currently presenting the ad unit.
    return self.rootViewController;
}

#pragma mark - FBInterstitialAdDelegate

- (void)interstitialAdDidLoad:(nonnull FBInterstitialAd *)interstitialAd
{
    // 전면광고 성공을 알린다.
    [self mediationInterstitialAdReceived];
    
    [interstitialAd showAdFromRootViewController:self.rootViewController];
}

- (void)interstitialAd:(nonnull FBInterstitialAd *)interstitialAd didFailWithError:(nonnull NSError *)error
{
    // 전면광고 실패를 알린다.
    [self mediationInterstitialAdFailedAd];
    
    self.fbInterstitialAd.delegate = nil;
    self.fbInterstitialAd = nil;
}

- (void)interstitialAdDidClick:(nonnull FBInterstitialAd *)interstitialAd
{
    // 전면 광고 클릭 리포팅
    [self mediationInterstitialAdReportClickEvent];
}

- (void)interstitialAdDidClose:(nonnull FBInterstitialAd *)interstitialAd
{
    // 전면광고 닫힘을 알린다.
    [self mediationInterstitialAdViewClosed];
    
    self.fbInterstitialAd.delegate = nil;
    self.fbInterstitialAd = nil;
}

@end
