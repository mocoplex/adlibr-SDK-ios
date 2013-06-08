/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 3.6.5
 */

#import "SubAdlibAdViewInmobi.h"

// 여기에 인모비에서 발급받은 key 를 입력하세요.
#define INMOBI_ID @"INMOBI"

@implementation SubAdlibAdViewInmobi

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

- (void)releaseAdView
{
    if(ad != nil)
    {
        [ad removeFromSuperview];
        ad.delegate = nil;
        [ad release];
        ad = nil;
    }
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    nSyncQueryFlag = 0;
    
    self.view.autoresizesSubviews = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        iPad = NO;
    else
        iPad = YES;
    
    // only iPhone size
    iPad = NO;
    bShowed = false;
    
    if(iPad)
        ad = [[IMAdView alloc] initWithFrame:CGRectMake([self getCenterPos], 0, 728, 90) imAppId:INMOBI_ID imAdSize:IM_UNIT_728x90 rootViewController:parent];
    else
        ad = [[IMAdView alloc] initWithFrame:CGRectMake([self getCenterPos], 0, 320, 50) imAppId:INMOBI_ID imAdSize:IM_UNIT_320x50 rootViewController:parent];
    
    ad.delegate = self;
    ad.refreshInterval = 20;
    ad.rootViewController = parent;
    
    IMAdRequest *request = [IMAdRequest request];
    
    //
    //request.testMode = YES;
    
    request.paramsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"c_adlib", @"tp", nil];
    
    ad.imAdRequest = request;
    
    [self.view addSubview:ad];
    
    [ad loadIMAdRequest:request];
}

- (void)clearAdView
{
    [self releaseAdView];
    
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

#pragma mark InMobiAdDelegate methods

- (void)adViewDidFinishRequest:(IMAdView *)view {
    if(++nSyncQueryFlag == 1)
        [self gotAd];
    bShowed = true;
}

- (void)adView:(IMAdView *)view didFailRequestWithError:(IMAdError *)error {
    if(bShowed)
        return;
    
    if([error code] == kIMADNoFillError || [error code] == kIMADInvalidRequestError || [error code] == kIMADInternalError)
    {
        [self failed];
    }
}

- (void)adViewDidDismissScreen:(IMAdView *)adView {
}

- (void)adViewWillDismissScreen:(IMAdView *)adView {
}

- (void)adViewWillPresentScreen:(IMAdView *)adView {
}

- (void)adViewWillLeaveApplication:(IMAdView *)adView {
}

@end
