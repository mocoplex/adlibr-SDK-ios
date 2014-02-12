/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 4.1.0
 */

#import "SubAdlibAdViewInmobi.h"

// 여기에 인모비에서 발급받은 key 를 입력하세요.
#define INMOBI_ID @"INMOBI"

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
    
    w2 = 320;
    
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
        
        ad = [[IMBanner alloc] initWithFrame:CGRectMake([self getCenterPos], 0, 320, 50) appId:INMOBI_ID adSize:IM_UNIT_320x50];
    
        ad.delegate = self;
        ad.refreshInterval = 20;
    
        [self.view addSubview:ad];
        
        bIninintedObject = YES;
    }
    
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
    return CGSizeMake(320, 50);
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    ad.frame = CGRectMake([self getCenterPos], 0, 320, 50);
}


#pragma mark - Banner Request Notifications

// Sent when an ad request was successful
- (void)bannerDidReceiveAd:(IMBanner *)banner {
    
    // 화면에 광고를 보여줍니다.
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

@end
