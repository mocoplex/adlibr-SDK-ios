/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with ShallWeAd SDK 2.4.6
 */

#import "SubAdlibAdViewShallWeAd.h"

// 여기 발급받은 key 를 입력하세요.
#define SHALLWEAD_ID @"SHALLWEAD_ID"    // for test Q6w5HkXHJqVzvcQZj1py_w

@implementation SubAdlibAdViewShallWeAd

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

    if(!iPad)
    {
        w2 = 320;
    }
    else
    {
        w2 = 422;
    }
    
    return (w-w2)/2;
}

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
    
    self.view.autoresizesSubviews = NO;
    static BOOL bIninintedObject = NO;
        
    if(!bIninintedObject)
    {
        [G_SHALLWEAD Create_ShallWeAD:SHALLWEAD_ID // 홈페이지 발급 받은키
                           TypeBanner: @"HTMLBanner"            // 배너타입
                              GpsInfo: YES                      // GPS 정보 설정
                          BannerWidth:@"FIT"                    // FIT, FULL 배너 넓이 설정
                                 PoSX:[self getCenterPos]                       // X좌표
                                 PoSY:0.f                       // Y좌표
                             SetAngle:degree0                  // 배너 이미지 각도
                             SetDebug:NO];                     // Debug Message
        G_SHALLWEAD.delegate=self;
        [self.view addSubview:G_SHALLWEAD.view];        
        
        bIninintedObject = YES;
    }
    
    [G_SHALLWEAD startBanner];
    
    //background request 를 지원하지 않는 플랫폼입니다.
    // 먼저 광고뷰를 화면에 보이고 수신여부를 확인합니다.
    [self gotAd];
}


/**
 광고 수신 실패 또는 광고가 없을때 호출되는 메소드
 */
-(void) loadingError
{
    if(!bGotAd)
        [self failed];    
}

/**
 광고 수신 성공시 호출되는 메소드
 */
-(void) loadingSuccess
{
    bGotAd = YES;
}

- (void)clearAdView
{
    [super clearAdView];
    
    [G_SHALLWEAD stopBanner];
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    [G_SHALLWEAD setBannerPoSX:[self getCenterPos] PoSY:0 SetAngle:0];
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
    
    if(!iPad)
        return CGSizeMake(w, 48);
    else
        return CGSizeMake(w, 66);
}

@end
