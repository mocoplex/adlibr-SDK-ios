/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with ShallWeAd SDK 2.4.7
 */

#import "SubAdlibAdViewShallWeAd.h"

// 여기 발급받은 key 를 입력하세요.
#define SHALLWEAD_ID @"SHALLWEAD_ID"    // for test Q6w5HkXHJqVzvcQZj1py_w

@implementation SubAdlibAdViewShallWeAd

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
        CGFloat originY = self.view.bounds.size.height - [self size].height;
        if (originY < 0) {
            originY = 0;
        }
        
        [G_SHALLWEAD Create_ShallWeAD:SHALLWEAD_ID // 홈페이지 발급 받은키
                           TypeBanner: @"HTMLBanner"            // 배너타입
                              GpsInfo: YES                      // GPS 정보 설정
                          BannerWidth:@"FIT"                    // FIT, FULL 배너 넓이 설정
                                 PoSX:[self getAdViewOriginX]   // X좌표
                                 PoSY:originY                   // Y좌표
                             SetAngle:degree0                   // 배너 이미지 각도
                             SetDebug:NO];                      // Debug Message
        G_SHALLWEAD.delegate=self;
        [self.view addSubview:G_SHALLWEAD.view];        
        
        bIninintedObject = YES;
    }
    
    [G_SHALLWEAD startBanner];
    
    //background request 를 지원하지 않는 플랫폼입니다.
    // 먼저 광고뷰를 화면에 보이고 수신여부를 확인합니다.
    [self queryAd];
}

- (void)clearAdView
{
    [super clearAdView];
    
    [G_SHALLWEAD stopBanner];
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    [G_SHALLWEAD setBannerPoSX:[self getAdViewOriginX] PoSY:0 SetAngle:0];
}

- (CGSize)size
{
    if(!iPad)
        return CGSizeMake(320, 48);
    else
        return CGSizeMake(422, 66);
}

- (CGFloat)getAdViewOriginX
{
    CGFloat w,w2=0;
    
    w = self.view.bounds.size.width;
    
    if(!iPad)
    {
        w2 = 320;
    }
    else
    {
        w2 = 422;
    }
    
    CGFloat res = (w-w2)/2;
    if (res < 0) {
        res = 0;
    }
    
    return res;
}

#pragma mark - delegate

/**
 광고 수신 실패 또는 광고가 없을때 호출되는 메소드
 */
- (void)loadingError
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
    [self gotAd];
}

@end
