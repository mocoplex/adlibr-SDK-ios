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
#define INMOBI_ID @"INMOBI - APP - ID"

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
        IMAdRequest *request = [IMAdRequest request];
        
        // 애드립 리워드 포인트 적립을 위해 필요한 코드입니다. -- 삭제하지 마세요.
        // do not modify this area -- implemented to get reward point
        request.paramsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"c_adlib", @"tp", nil];
        // do not modify this area -- implemented to get reward point
        // 애드립 리워드 포인트 적립을 위해 필요한 코드입니다. -- 삭제하지 마세요.
        
        ad = [[IMAdView alloc] initWithFrame:CGRectMake(0, 0, 320, 50) imAppId:INMOBI_ID imAdUnit:IM_UNIT_320x50 rootViewController:parent];    
        ad.delegate = self;
        ad.refreshInterval = 20;
        ad.rootViewController = parent;
        
        request.testMode = NO;
        ad.imAdRequest = request;    
        
        [self.view addSubview:ad];
        
        bIninintedObject = YES;
    }
    
    [ad loadIMAdRequest];
}

- (void)clearAdView
{
    ad.rootViewController = nil;
    
    [super clearAdView];
}

- (CGSize)size
{
    return CGSizeMake(320, 50);
}

#pragma mark InMobiAdDelegate methods

- (void)adViewDidFinishRequest:(IMAdView *)view {
    //NSLog(@"<<<<<ad request completed>>>>>");
    [self gotAd];
}

- (void)adView:(IMAdView *)view didFailRequestWithError:(IMAdError *)error {
    //NSLog(@"<<<< ad request failed.>>>, error=%@",[error localizedDescription]);
    //NSLog(@"error code=%d",[error code]);
    [self failed];
}

- (void)adViewDidDismissScreen:(IMAdView *)adView {
    //NSLog(@"adViewDidDismissScreen");
}

- (void)adViewWillDismissScreen:(IMAdView *)adView {
    //NSLog(@"adViewWillDismissScreen");
}

- (void)adViewWillPresentScreen:(IMAdView *)adView {
    //NSLog(@"adViewWillPresentScreen");
}

- (void)adViewWillLeaveApplication:(IMAdView *)adView {
    //NSLog(@"adViewWillLeaveApplication");
}


@end
