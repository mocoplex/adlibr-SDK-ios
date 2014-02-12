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
    
    self.view.autoresizesSubviews = NO;
    
    static BOOL bIninintedObject = NO;
    if(!bIninintedObject)
    {
        // 광고뷰를 생성합니다.
        ad = [MobileAdView sharedMobileAdView];
        
        CGRect rt = CGRectMake(0, 0, 320, 50);
        ad.frame = rt;
        
        [ad setSuperViewController:parent];
        [ad setChannelId:NAVER_ID];
        // 테스트 모드를 사용하려면 아래 주석을 제거하세요.
        //[ad setIsTest:YES];
        [ad setDelegate:self];
        
        [self.view addSubview:ad];
    }
    
    // NaverADPost SDK 1.2 이후로 background request 를 지원하지 않습니다. 
    [ad start];
    
    // 먼저 광고뷰를 화면에 보이고 수신여부를 확인합니다.
    [self gotAd];
}

- (void)clearAdView
{
    if(ad != nil)
    {
        [ad stop];
        [ad setSuperViewController:nil];
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

#pragma MobileAdViewDelegate

- (void)adDidReceived:(MobileAdErrorType)err
{
    // 광고를 받아온 경우나, 승인을 기다리는 경우만 화면에 보이게합니다.
    if(err == ERROR_SUCCESS || err == ERROR_WAIT_FOR_APPROVAL || err == ERROR_INTERNAL || err == ERROR_INVALID_REQUEST || err == ERROR_INVALID_CHANNEL)
    {
        bGotAd = YES;
    }
    else {
        if(!bGotAd)
            [self failed];
    }
}

@end
