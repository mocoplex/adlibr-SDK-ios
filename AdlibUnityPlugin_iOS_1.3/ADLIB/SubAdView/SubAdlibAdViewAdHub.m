/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with SamsungAdHub SDK 2.0.0
 */

#import "SubAdlibAdViewAdHub.h"

// ADHUB의 APP 아이디를 설정합니다. 아래는 테스트키 입니다.
#define ADHUB_ID @"ADHUB_ID"
#define ADHUB_INTERSTITIAL_ID @"ADHUB_INTERSTITIAL_ID"

@implementation SubAdlibAdViewAdHub

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    self.view.autoresizesSubviews = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        iPad = NO;
    else
        iPad = YES;
    
    // 광고뷰를 생성합니다.
    
    AdHubView *ad = nil;
    
    if(iPad)
        ad = [[AdHubView alloc] initWithAdSize:kAdHubAdSize_B_728x90 origin:CGPointMake([self getAdHubViewOriginX], 0) inventoryID:ADHUB_ID];
    else
        ad = [[AdHubView alloc] initWithAdSize:kAdHubAdSize_B_320x48 origin:CGPointMake([self getAdHubViewOriginX], 0) inventoryID:ADHUB_ID];
    
    self.adView = ad;
    
    ad.delegate = self;
    ad.rootViewController = parent;
    
    [self.view addSubview:ad];
    
    [self queryAd];
    [ad startAd];
}

- (void)clearAdView
{
    if(_adView != nil)
    {
        [_adView stopRefresh];
        _adView.delegate = nil;
        _adView.rootViewController = nil;
        self.adView = nil;
    }
    
    [super clearAdView];
}

- (CGSize)size
{
    if(iPad)
        return CGSizeMake(728, 90);
    else
        return CGSizeMake(320, 48);
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    int w;
    int h;
    if (iPad) {
        w = 728;
        h = 90;
    }
    else
    {
        w = 320;
        h = 48;
    }
    
    _adView.frame = CGRectMake([self getAdHubViewOriginX], 0, w, h);
}


- (CGFloat)getAdHubViewOriginX
{
    CGFloat w,w2=0;
    
    w = self.view.bounds.size.width;
    if (iPad) {
        w2 = 728;
    }
    else
    {
        w2 = 320;
    }
    
    return (w-w2)/2;
}

- (void)subAdlibViewLoadInterstitial:(UIViewController*)viewController
{
    AdHubInterstitial* interstitial_ = [[AdHubInterstitial alloc] initWithInventoryID:ADHUB_INTERSTITIAL_ID];
    interstitial_.delegate = self;
    [interstitial_ presentFromViewController:viewController];
}

#pragma AdHubViewDelegate

- (void)bannerViewDidLoadAd:(SADBannerView *)banner
{
    // 화면에 광고를 보여줍니다.
    [self gotAd];
}

- (void)bannerView:(SADBannerView *)banner didFailToReceiveAdWithError:(AdHubRequestError *)error
{
    // 광고 수신에 실패하였습니다.
    [self failed];
}

- (void)interstitialAdDidLoad:(AdHubInterstitial *)interstitialAd
{
    // 전면광고 성공을 알린다.
    [self subAdlibViewInterstitialReceived:@"adhub"];
}

- (void)interstitialAd:(AdHubInterstitial *)interstitialAd didFailWithError:(AdHubRequestError *)error
{
    // 전면광고 실패를 알린다.
    [self subAdlibViewInterstitialFailed:@"adhub"];
}


- (void)interstitialAdDidUnload:(AdHubInterstitial *)interstitialAd
{
    // 전면광고 닫힘을 알린다.
    [self subAdlibViewInterstitialClosed:@"adhub"];
}

@end