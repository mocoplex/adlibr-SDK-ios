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
#define ADHUB_ID @"xv0c00000001ck"
#define ADHUB_INTERSTITIAL_ID @"xv0c00000001aw"

@implementation SubAdlibAdViewAdHub

- (int)getCenterPos
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    int w,w2=0;
    if([self isPortrait])
    {
        w = screenWidth;
    }
    else
    {
        w = screenHeight;
    }
    
    if (iPad) {
        w2 = 728;
    }
    else
    {
        w2 = 320;
    }
    
    return (w-w2)/2;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    self.view.autoresizesSubviews = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        iPad = NO;
    else
        iPad = YES;
    
    // Create a view of the standard size at the bottom of the screen.
    if(iPad)
        ad = [[AdHubView alloc] initWithAdSize:kAdHubAdSize_B_728x90 origin:CGPointMake([self getCenterPos],0) inventoryID:ADHUB_ID];
    else
        ad = [[AdHubView alloc] initWithAdSize:kAdHubAdSize_B_320x48 origin:CGPointMake([self getCenterPos],0) inventoryID:ADHUB_ID];
    
    // 광고뷰를 생성합니다.
    
    ad.delegate = self;
    ad.rootViewController = parent;
        
    [self.view addSubview:ad];
    
    [ad startAd];
}

- (void)clearAdView
{
    if(ad != nil)
    {
        [ad stopRefresh];
        ad.delegate = nil;
        ad.rootViewController = nil;
        [ad release];
        ad = nil;
    }
    
    [super clearAdView];
}

- (CGSize)size
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    int w;
    if([self isPortrait])
    {
        w = screenWidth;
    }
    else
    {
        w = screenHeight;
    }
    
    if(iPad)
        return CGSizeMake(w, 90);
    else
        return CGSizeMake(w, 48);
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    int w;
    if([self isPortrait])
    {
        w = screenWidth;
    }
    else
    {
        w = screenHeight;
    }
    
    int w2;
    if (iPad) {
        w2 = 728;
    }
    else
    {
        w2 = 320;
    }
    
    int h2 = 90;
    if(!iPad)
        h2 = 48;
    
    if([self isPortrait])
    {
        ad.frame = CGRectMake([self getCenterPos], 0, w2, h2);
    }
    else
    {
        ad.frame = CGRectMake([self getCenterPos], 0, w2, h2);
    }
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

+ (void)loadInterstitail:(UIViewController*)viewController
{
    AdHubInterstitial* interstitial_ = [[AdHubInterstitial alloc] initWithInventoryID:ADHUB_INTERSTITIAL_ID];
    interstitial_.delegate = self;
    [interstitial_ presentFromViewController:viewController];
}

+ (void)interstitialAdDidLoad:(AdHubInterstitial *)interstitialAd
{
    // 전면광고 성공을 알린다.
    [self interstitialReceived:@"adhub"];
}

+ (void)interstitialAd:(AdHubInterstitial *)interstitialAd didFailWithError:(AdHubRequestError *)error
{
    // 전면광고 실패를 알린다.
    [self interstitialFailed:@"adhub"];
}


+ (void)interstitialAdDidUnload:(AdHubInterstitial *)interstitialAd
{
    // 전면광고 닫힘을 알린다.
    [self interstitialClosed:@"adhub"];
}

@end