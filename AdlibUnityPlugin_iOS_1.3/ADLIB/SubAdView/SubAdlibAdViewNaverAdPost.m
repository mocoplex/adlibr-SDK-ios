/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with NaverAdPost SDK 1.3.0
 */

#import "SubAdlibAdViewNaverAdPost.h"

// NAVER의 APP 아이디를 설정합니다.
#define NAVER_ID @"ADPOST_ID"

@implementation SubAdlibAdViewNaverAdPost

+ (BOOL)isStaticObject
{
    return YES;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    self.view.autoresizesSubviews = NO;
    
    if(_adView == nil)
    {
        // 광고뷰를 생성합니다.
        self.adView = [MobileAdView sharedMobileAdView];
        
        CGRect rt = CGRectMake(0, 0, self.view.bounds.size.width, 50);
        _adView.frame = rt;
        [_adView setSuperViewController:parent];
        [_adView setChannelId:NAVER_ID];
        [_adView setDelegate:self];
        
        // 테스트를 위한 플래그 설정.
        _adView.isTest = YES;
    }
    
    [self.view addSubview:_adView];
    
    // NaverADPost SDK 1.2 이후로 background request 를 지원하지 않습니다. 
    [_adView start];
    
    // 먼저 광고뷰를 화면에 보이고 수신여부를 확인합니다.
    [self queryAd];
}

- (void)clearAdView
{
    if(_adView != nil)
    {
        [_adView stop];
        [_adView setSuperViewController:nil];
        [_adView removeFromSuperview];
    }
    
    [super clearAdView];
}

- (CGSize)size
{
    return [super size];
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    _adView.frame = CGRectMake(0,
                               0,
                               self.view.bounds.size.width,
                               50);
}

#pragma MobileAdViewDelegate

- (void)adDidReceived:(MobileAdErrorType)err
{
    // 광고를 받아온 경우나, 승인을 기다리는 경우만 화면에 보이게합니다.
    if(err == ERROR_SUCCESS)
    {
        bGotAd = YES;
        [self gotAd];
    }
    else {
        bGotAd = NO;
        [self failed];
    }
}

@end
