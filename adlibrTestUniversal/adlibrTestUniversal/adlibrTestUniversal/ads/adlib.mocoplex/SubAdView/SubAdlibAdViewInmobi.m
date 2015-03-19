/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 4.4.1
 */

#import "SubAdlibAdViewInmobi.h"

// 여기에 인모비에서 발급받은 key 를 입력하세요.
#define INMOBI_ID @"INMOBI_ID"
#define INMOBI_INTERSTITIAL_ID @"INMOBI_INTERSTITIAL"

@interface SubAdlibAdViewInmobi () <IMInterstitialDelegate>

@property (nonatomic, strong) IMInterstitial *interstitial;

@end

@implementation SubAdlibAdViewInmobi

// 객체를 전역적으로 하나만 생성합니다.
+ (BOOL)isStaticObject
{
    return YES;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    static BOOL bIninintedObject = NO;
    
    if(!bIninintedObject)
    {
        // Inmobi Initialize
        [InMobi initialize:INMOBI_ID];
        [InMobi setLogLevel:IMLogLevelDebug];
        
        self.view.autoresizesSubviews = NO;
    
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            iPad = NO;
        else
            iPad = YES;
        
        // only iPhone size
        iPad = NO;
        IMBanner *bannerView = nil;
        
        CGFloat ptX = [self getInmobiViewOriginX];
        
        if(iPad)
            bannerView = [[IMBanner alloc] initWithFrame:CGRectMake(ptX, 0, 728, 90) appId:INMOBI_ID adSize:IM_UNIT_728x90];
        else
            bannerView = [[IMBanner alloc] initWithFrame:CGRectMake(ptX, 0, 320, 50) appId:INMOBI_ID adSize:IM_UNIT_320x50];
    
        self.adView = bannerView;
        _adView.delegate = self;
        _adView.refreshInterval = 20;
        
        //[InMobi setLogLevel:IMLogLevelDebug];
        
        bIninintedObject = YES;
    }
    
    [_adView removeFromSuperview];
    [self.view addSubview:_adView];
    
    [self queryAd];
    [_adView loadBanner];
}

- (void)clearAdView
{
    if(_adView != nil)
    {
        [_adView stopLoading];
        [_adView removeFromSuperview];
    }
    
    [super clearAdView];
}

- (CGSize)size
{
    if(iPad)
        return CGSizeMake(728, 90);
    else
        return CGSizeMake(320, 50);
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    CGFloat height = 90;
    if(!iPad)
        height = 50;
    
    CGFloat ptX = [self getInmobiViewOriginX];
    if(iPad)
        _adView.frame = CGRectMake(ptX, 0, 728, height);
    else
        _adView.frame = CGRectMake(ptX, 0, 320, height);
}

- (CGFloat)getInmobiViewOriginX
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
    [InMobi initialize:INMOBI_INTERSTITIAL_ID];
    
    IMInterstitial *interstitial = [[IMInterstitial alloc] initWithAppId:INMOBI_INTERSTITIAL_ID];
    self.interstitial = interstitial;
    
    interstitial.delegate = self;
    [interstitial loadInterstitial];
}

#pragma mark - Banner Request Notifications

// Sent when an ad request was successful
- (void)bannerDidReceiveAd:(IMBanner *)banner {
    
    NSLog(@"banner receiveAd inmobi");
    
    // 화면에 광고를 보여줍니다.
    [self queryAd];
    [self gotAd];
}

// Sent when the ad request failed. Please check the error code and
// localizedDescription for more information on wy this occured
- (void)banner:(IMBanner *)banner didFailToReceiveAdWithError:(IMError *)error {
    
    NSString *errorMessage = [NSString stringWithFormat:@"Loading ad failed. Error code: %zd, message: %@", [error code], [error localizedDescription]];
    NSLog(@"%@", errorMessage);
    
    // 광고 수신에 실패하였습니다.
    [self failed];
}

- (void)interstitialDidReceiveAd:(IMInterstitial *)ad
{
    // 전면광고 성공을 알린다.
    [self subAdlibViewInterstitialReceived:@"inmobi"];
    
    [ad presentInterstitialAnimated:YES];
}

- (void)interstitial:(IMInterstitial *)ad didFailToReceiveAdWithError:(IMError *)error
{
    // 전면광고 실패를 알린다.
    [self subAdlibViewInterstitialFailed:@"inmobi"];
}

- (void)interstitialDidDismissScreen:(IMInterstitial *)ad
{
    // 전면광고 닫힘을 알린다.
    [self subAdlibViewInterstitialClosed:@"inmobi"];
}

- (void)interstitialWillLeaveApplication:(IMInterstitial *)ad
{
    // 전면 광고 클릭 리포팅
    [self reportInterstitialClickEvent];
}

@end
