/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 350
 */

#import "SubAdlibAdViewInmobi.h"

// INMOBI의 APP 아이디를 설정합니다.
#define INMOBI_ID @"INMOBI APP ID"

@implementation SubAdlibAdViewInmobi

- (void)query:(UIViewController*)parent
{
    [super query:parent];    

    ad = [[IMAdView alloc] initWithFrame:CGRectMake(0, 0, 320, 50) imAppId:INMOBI_ID imAdUnit:IM_UNIT_320x50 rootViewController:parent];    
    ad.delegate = self;
    
    IMAdRequest *request = [IMAdRequest request];
    //request.testMode = YES;
    ad.imAdRequest = request;
    
    [self.view addSubview:ad];
}

- (void)clearAdView
{
    [ad setDelegate:nil];
    [ad release];
    ad = nil;
        
    [super clearAdView];
}

- (CGSize)size
{
    return CGSizeMake(320, 50);
}

#pragma mark InMobiAdDelegate methods

- (void)adViewDidFinishRequest:(IMAdView *)view {
    NSLog(@"<<<<<ad request completed>>>>>");
    [self gotAd];
}

- (void)adView:(IMAdView *)view didFailRequestWithError:(IMAdError *)error {
    NSLog(@"<<<< ad request failed.>>>, error=%@",[error localizedDescription]);
    NSLog(@"error code=%d",[error code]);
    [self failed];
}

- (void)adViewDidDismissScreen:(IMAdView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

- (void)adViewWillDismissScreen:(IMAdView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

- (void)adViewWillPresentScreen:(IMAdView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

- (void)adViewWillLeaveApplication:(IMAdView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}


@end
