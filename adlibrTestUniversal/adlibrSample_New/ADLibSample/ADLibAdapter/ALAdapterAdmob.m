//
//  ALAdapterAdmob.m
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 4. 19..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import "ALAdapterAdmob.h"
#import <GoogleMobileAds/GADBannerView.h>
#import <GoogleMobileAds/GADInterstitial.h>


/*
 * confirmed compatible with Admob SDK 7.16.0
 */

@interface ALAdapterAdmob () <GADInterstitialDelegate, GADBannerViewDelegate>

@property (nonatomic, strong) GADBannerView *adView;
@property (nonatomic, strong) GADInterstitial* interstitial;

@end


@implementation ALAdapterAdmob

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mediationPlatform = ALMEDIATION_PLATFORM_ADMOB;
    }
    return self;
}

- (GADBannerView *)adView
{
    if (_adView == nil) {
        
        GADAdSize gadSize = kGADAdSizeBanner;
        GADBannerView *adView = [[GADBannerView alloc] initWithAdSize:gadSize];
        _adView = adView;
        _adView.frame = CGRectMake(0,
                                   0,
                                   self.bannerContainerView.frame.size.width,
                                   _adView.frame.size.height);
    }
    
    return _adView;
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
    
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    self.adView.adUnitID = key;
    self.adView.delegate = self;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    self.adView.rootViewController = viewController;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID];
    
    self.adView.autoloadEnabled = NO;
    [self.adView loadRequest:request];
    
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
    
    GADInterstitial* interstitial = [[GADInterstitial alloc] initWithAdUnitID:key];
    self.interstitial = interstitial;
    
    interstitial.delegate = self;
    self.rootViewController = viewController;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID];
    
    [interstitial loadRequest:request];
    
    return YES;
}

#pragma mark - GADBannerViewDelegate

- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"\n\n admob receive Ad");
    
    // 화면에 광고를 보여줍니다.
    [self mediationBannerAdReceivedWithView:view];
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"\n\n admob receive fail Ad : %@", error);
    
    // 광고 수신에 실패 처리를 요청합니다.
    [self mediationBannerAdFailedAd];
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    ;
}

// Called just before dismissing a full screen view.
- (void)adViewWillDismissScreen:(GADBannerView *)adView
{
    ;
}

#pragma mark - GADInterstitialDelegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial
{
    if (self.rootViewController) {
        
        //전면광고를 화면에 표시합니다.
        [interstitial presentFromRootViewController:self.rootViewController];
        
        // 전면광고 성공을 알린다.
        [self mediationInterstitialAdReceived];
        
    } else {
        
        // 전면광고 실패를 알린다.
        [self mediationInterstitialAdFailedAd];
    }
}

- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error
{
    // 전면광고 실패를 알린다.
    [self mediationInterstitialAdFailedAd];
    
    self.interstitial = nil;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    // 전면광고 닫힘을 알린다.
    [self mediationInterstitialAdViewClosed];
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad
{
    // 전면광고 닫힘을 알린다.
    [self mediationInterstitialAdViewClosed];
}

@end


