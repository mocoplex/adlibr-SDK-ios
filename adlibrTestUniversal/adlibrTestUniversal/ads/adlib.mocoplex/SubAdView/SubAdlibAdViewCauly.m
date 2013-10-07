/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with cauly SDK 3.0.2
 */

#import "SubAdlibAdViewCauly.h"
#import "AdlibManager.h"

// CAULY의 APP 아이디를 설정합니다.
#define CAULY_ID @"CAULY_ID"

@implementation SubAdlibAdViewCauly

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
    
    w2 = 320;
    
    return (w-w2)/2;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        iPad = NO;
    else
        iPad = YES;
    
    CaulyAdSetting* ads = [CaulyAdSetting globalSetting];
    [CaulyAdSetting setLogLevel:CaulyLogLevelRelease];
    
    ads.appCode = CAULY_ID;
    ads.animType = CaulyAnimNone;
    
    ad = [[CaulyAdView alloc] initWithParentViewController:parent];
    [self.view addSubview:ad];
    ad.delegate = self;
    ad.localSetting = ads;
    
    [ad startBannerAdRequest];
    
    [self gotAd];
}

- (void)clearAdView
{
    ad.delegate = nil;
    ad.parentController = nil;
    [ad release];
    ad = nil;
    
    [super clearAdView];
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
    
    int w2 = 320;
    int h2 = 48;
    
    if([self isPortrait])
    {
        ad.frame = CGRectMake([self getCenterPos], 0, w2, h2);
    }
    else
    {
        ad.frame = CGRectMake([self getCenterPos], 0, w2, h2);
    }
}

// Banner AD API
#pragma mark - CaulyAdViewDelegate

// 광고 정보 수신 성공
- (void)didReceiveAd:(CaulyAdView *)adView isChargeableAd:(BOOL)isChargeableAd {
    
    if(isChargeableAd)
    {
        [self gotAd];
    }
}

// 광고 정보 수신 실패
- (void)didFailToReceiveAd:(CaulyAdView *)adView errorCode:(int)errorCode errorMsg:(NSString*)errorMsg {
    [self failed];
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
    
    return CGSizeMake(w, 48);
}


+ (void)loadInterstitail:(UIViewController*)viewController
{
    CaulyAdSetting* ads = [CaulyAdSetting globalSetting];
    [CaulyAdSetting setLogLevel:CaulyLogLevelRelease];
    
    ads.appCode = CAULY_ID;
    ads.animType = CaulyAnimNone;
    
    CaulyInterstitialAd* _interstitialAd = [[[CaulyInterstitialAd alloc] initWithParentViewController:viewController] autorelease];
    _interstitialAd.delegate = self;
    [_interstitialAd startInterstitialAdRequest];
}

+ (void)didReceiveInterstitialAd:(CaulyInterstitialAd *)interstitialAd isChargeableAd:(BOOL)isChargeableAd
{
    [interstitialAd show]; // [_interstitialAd show];를 호출하지 않으면 Interstitial AD가 보여지지 않음
    // 전면광고 성공을 알린다.
    [self interstitialReceived:@"cauly"];
    interstitialAd = nil;
}

+ (void)didFailToReceiveInterstitialAd:(CaulyInterstitialAd *)interstitialAd errorCode:(int)errorCode errorMsg:(NSString *)errorMsg
{
    // 전면광고 실패를 알린다.
    [self interstitialFailed:@"cauly"];
    interstitialAd = nil;
}

+ (void)didCloseInterstitialAd:(CaulyInterstitialAd *)interstitialAd
{
    // 전면광고 닫힘을 알린다.
    [self interstitialClosed:@"cauly"];
    interstitialAd = nil;
}


@end
