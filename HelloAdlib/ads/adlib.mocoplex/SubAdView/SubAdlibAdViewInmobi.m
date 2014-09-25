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
#define INMOBI_ID @"INMOBI"
#define INMOBI_INTERSTITIAL_ID @"INMOBI_INTERSTITIAL"

@implementation SubAdlibAdViewInmobi

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
    
    static BOOL bIninintedObject = NO;
    
    if(!bIninintedObject)
    {
        // Inmobi Initialize
        [InMobi initialize:INMOBI_ID];
    
        self.view.autoresizesSubviews = NO;
    
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            iPad = NO;
        else
            iPad = YES;
        
        // only iPhone size
        iPad = NO;
        
        if(iPad)
            ad = [[IMBanner alloc] initWithFrame:CGRectMake([self getCenterPos], 0, 728, 90) appId:INMOBI_ID adSize:IM_UNIT_728x90];
        else
            ad = [[IMBanner alloc] initWithFrame:CGRectMake([self getCenterPos], 0, 320, 50) appId:INMOBI_ID adSize:IM_UNIT_320x50];
    
        ad.delegate = self;
        ad.refreshInterval = 20;
    
        [self.view addSubview:ad];
        
        bIninintedObject = YES;
    }
    
    [self queryAd];
    
    [ad loadBanner];
}

- (void)clearAdView
{
    if(ad != nil)
    {
        [ad stopLoading];
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
        return CGSizeMake(w, 50);
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
    if (iPad)
        w2 = 728;
    else
        w2 = 320;
    
    int h2 = 90;
    if(!iPad)
        h2 = 50;
    
    if([self isPortrait])
        ad.frame = CGRectMake([self getCenterPos], 0, w2, h2);
    else
        ad.frame = CGRectMake([self getCenterPos], 0, w2, h2);
}


#pragma mark - Banner Request Notifications

// Sent when an ad request was successful
- (void)bannerDidReceiveAd:(IMBanner *)banner {
    
    // 화면에 광고를 보여줍니다.
    [self queryAd];
    [self gotAd];
}

// Sent when the ad request failed. Please check the error code and
// localizedDescription for more information on wy this occured
- (void)banner:(IMBanner *)banner didFailToReceiveAdWithError:(IMError *)error {
    
    //NSString *errorMessage = [NSString stringWithFormat:@"Loading ad failed. Error code: %d, message: %@", [error code], [error localizedDescription]];
    //NSLog(@"%@", errorMessage);
    
    // 광고 수신에 실패하였습니다.
    [self failed];
}

+ (void)loadInterstitail:(UIViewController*)viewController
{
    [InMobi initialize:INMOBI_INTERSTITIAL_ID];
    
    IMInterstitial *interstitial = [[IMInterstitial alloc] initWithAppId:INMOBI_INTERSTITIAL_ID];
    interstitial.delegate = self;
    [interstitial loadInterstitial];
}

+ (void)interstitialDidReceiveAd:(IMInterstitial *)ad
{
    // 전면광고 성공을 알린다.
    [self interstitialReceived:@"inmobi"];
    
    [ad presentInterstitialAnimated:YES];
}

+ (void)interstitial:(IMInterstitial *)ad didFailToReceiveAdWithError:(IMError *)error
{
    
    //NSString *errorMessage = [NSString stringWithFormat:@"Error code: %d, message: %@", [error code], [error localizedDescription]];
    //NSLog(@"%@", errorMessage);
    
    // 전면광고 실패를 알린다.
    [self interstitialFailed:@"inmobi"];
}

+ (void)interstitialDidDismissScreen:(IMInterstitial *)ad
{
    // 전면광고 닫힘을 알린다.
    [self interstitialClosed:@"inmobi"];
}

@end
