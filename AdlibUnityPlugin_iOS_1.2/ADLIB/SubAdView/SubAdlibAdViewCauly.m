/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with cauly SDK 3.0.4
 */

#import "SubAdlibAdViewCauly.h"

// CAULY의 APP 아이디를 설정합니다.
#define CAULY_ID @"CAULY_ID"

@implementation SubAdlibAdViewCauly

// 객체를 전역적으로 하나만 생성합니다.
+ (BOOL)isStaticObject
{
    return YES;
}

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
    
    static BOOL bIninintedObject = NO;
    
    CaulyAdSetting* ads = [CaulyAdSetting globalSetting];
    [CaulyAdSetting setLogLevel:CaulyLogLevelRelease];
    
    ads.adSize = CaulyAdSize_IPhone;
    ads.appCode = CAULY_ID;
    ads.animType = CaulyAnimNone;
    
    if(!bIninintedObject)
    {
        ad = [CaulyAdView caulyAdViewWithController:parent];
        [self.view addSubview:ad];
        ad.delegate = self;
        ad.localSetting = ads;
        
        bIninintedObject = YES;
    }
    
    [self queryAd];
    
    [ad startBannerAdRequest];
}

- (void)clearAdView
{
    [ad stopAdRequest];
    
    [super clearAdView];
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    ad.frame = CGRectMake([self getCenterPos], 0, 320, 48);
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
    return CGSizeMake(320, 48);
}


+ (void)loadInterstitail:(UIViewController*)viewController
{
    // 아이패드는 전면배너를 지원하지 않는다는 메시지만 출력되며, fail함수가 호출되지 않아, 실패를 알리고 return 시킨다.
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self interstitialFailed:@"cauly"];
        return;
    }
    
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
