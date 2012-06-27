/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with t-ad SDK 2.4.5.5
 */

#import "SubAdlibAdViewTAD.h"

// TAD의 APP 아이디를 설정합니다.
#define TAD_ID @"T-AD ID"

@implementation SubAdlibAdViewTAD

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    {
        [TadViewController initialize:TAD_ID bannerPosition:BANNER_POSITION_TOP_LEFT applicationTitle:@"APP TITLE" view:self.view];
        
        [TadViewController setAdDelegate:self];
        [TadViewController enableAutoRotation:YES];            
    }    
}

- (void)clearAdView
{
    [super clearAdView];
    [TadViewController deinitialize];
}

- (void)TadNoMoreAdItem
{
    // 광고가 없다.
    [TadViewController deinitialize];

    // 실패했다. 바로 다음 스케줄 광고를 보인다.
    [self failed];
}

- (void)TadRecvAd
{
    // 광고 수신
    [self gotAd];
}

- (CGSize)size
{
    return CGSizeMake(self.view.bounds.size.width, 48);
}

@end
