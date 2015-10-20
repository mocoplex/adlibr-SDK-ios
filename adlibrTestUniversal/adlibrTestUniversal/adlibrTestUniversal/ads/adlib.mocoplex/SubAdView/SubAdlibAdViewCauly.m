/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with cauly SDK 3.0.6
 */

#import "SubAdlibAdViewCauly.h"

// CAULY의 APP 아이디를 설정합니다.
#define CAULY_ID @"CAULY_ID"

@interface SubAdlibAdViewCauly () <CaulyInterstitialAdDelegate>

@property (nonatomic, strong) CaulyInterstitialAd *interstitialAd;

@end

@implementation SubAdlibAdViewCauly

// 객체를 전역적으로 하나만 생성합니다.
+ (BOOL)isStaticObject
{
    return YES;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        iPad = NO;
    else
        iPad = YES;
    
    if (_adView == nil) {
        CaulyAdSetting* ads = [CaulyAdSetting globalSetting];
        [CaulyAdSetting setLogLevel:CaulyLogLevelRelease];
        
        ads.appCode = CAULY_ID;
        ads.animType = CaulyAnimNone;
        ads.reloadTime = CaulyReloadTime_120;
        ads.useDynamicReloadTime = NO;
        
        CaulyAdView *ad = [[CaulyAdView alloc] initWithParentViewController:parent];
        self.adView = ad;
        ad.delegate = self;
        ad.localSetting = ads;
        [self.view addSubview:_adView];
    }
    
    [self queryAd];
    [_adView startBannerAdRequest];
}

- (void)clearAdView
{
    if (_adView) {
        [_adView stopAdRequest];
    }
    
    [super clearAdView];
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    int w = 320;
    int h = 48;
    
    CGFloat originX = 0;
    originX = (self.view.bounds.size.width - w)/2;
    
    CGFloat originY = self.view.bounds.size.height - h;
    if (originY < 0) {
        originY = 0;
    }
    
    _adView.frame = CGRectMake(originX, originY, w, h);
}

- (CGSize)size
{
    return CGSizeMake(320, 48);
}

// 애드립 매니저에 의한 전면광고 강제 종료 요청 처리
- (BOOL)autoCloseInterstitialAd:(BOOL)animated
{
    [self.interstitialAd close];
    
    self.interstitialAd.delegate =nil;
    self.interstitialAd = nil;
    
    return YES;
}

- (void)subAdlibViewLoadInterstitial:(UIViewController*)viewController
{
    // 아이패드는 전면배너를 지원하지 않는다는 메시지만 출력되며, fail함수가 호출되지 않아, 실패를 알리고 return 시킨다.
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self subAdlibViewInterstitialFailed:@"cauly"];
        return;
    }
    
    CaulyAdSetting* ads = [CaulyAdSetting globalSetting];
    [CaulyAdSetting setLogLevel:CaulyLogLevelRelease];
    
    ads.appCode = CAULY_ID;
    ads.animType = CaulyAnimNone;
    
    CaulyInterstitialAd *interstitialAd = [[CaulyInterstitialAd alloc] initWithParentViewController:viewController];
    self.interstitialAd = interstitialAd;
    self.interstitialAd.delegate = self;
    
    [self.interstitialAd startInterstitialAdRequest];
}


// Banner AD API
#pragma mark - CaulyAdViewDelegate

// 광고 정보 수신 성공
- (void)didReceiveAd:(CaulyAdView *)adView isChargeableAd:(BOOL)isChargeableAd {
    
    NSLog(@"CaulyAdView didReceiveAd : %xd", isChargeableAd);
    [self gotAd];
}

// 광고 정보 수신 실패
- (void)didFailToReceiveAd:(CaulyAdView *)adView errorCode:(int)errorCode errorMsg:(NSString*)errorMsg {
    
    NSLog(@"CaulyAdView requestDidFailed : %@", errorMsg);
    [self failed];
}

#pragma mark -

- (void)didReceiveInterstitialAd:(CaulyInterstitialAd *)interstitialAd isChargeableAd:(BOOL)isChargeableAd
{
    // [_interstitialAd show];를 호출하지 않으면 Interstitial AD가 보여지지 않음
    [interstitialAd show];
    
    // 전면광고 성공을 알린다.
    [self subAdlibViewInterstitialReceived:@"cauly"];
}

- (void)didFailToReceiveInterstitialAd:(CaulyInterstitialAd *)interstitialAd errorCode:(int)errorCode errorMsg:(NSString *)errorMsg
{
    // 전면광고 실패를 알린다.
    [self subAdlibViewInterstitialFailed:@"cauly"];
    
    self.interstitialAd.delegate = nil;
    self.interstitialAd = nil;
}

- (void)didCloseInterstitialAd:(CaulyInterstitialAd *)interstitialAd
{
    // 전면광고 닫힘을 알린다.
    [self subAdlibViewInterstitialClosed:@"cauly"];
    
    self.interstitialAd.delegate = nil;
    self.interstitialAd = nil;
}


@end
