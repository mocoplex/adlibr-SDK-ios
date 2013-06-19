/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with ad@m SDK 2.2.0
 */

// iOS / ad@m 플랫폼은 백그라운드 리퀘스트 기능을 지원하지 않습니다.
// 화면에 광고뷰가 노출된 상태에서만 응답을 받을 수 있으며
// 응답을 받기까지 빈화면으로 표시될 수 있습니다.

#import "SubAdlibAdViewAdam.h"

// ADAM의 APP 아이디를 설정합니다.
#define ADAM_ID @"ADAM_ID";

@implementation SubAdlibAdViewAdam

// 객체를 전역적으로 하나만 생성합니다.
+ (BOOL)isStaticObject
{
    return YES;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];    

    self.view.autoresizesSubviews = NO;
    static BOOL bIninintedObject = NO;
    
    if(!bIninintedObject)
    {
        // 다음 광고뷰를 생성합니다.
        ad = [AdamAdView sharedAdView];
        
        CGRect rt;        
        rt = CGRectMake(0, 0, self.view.bounds.size.width, 48);        
        
        ad.frame = rt;
        
        self.view.frame = rt;
        
        ad.clientId = ADAM_ID;
        ad.delegate = self;
        ad.superViewController = parent;

        [self.view addSubview:ad];
        
        bIninintedObject = YES;
    }

    // iOS / ad@m 플랫폼은 백그라운드 리퀘스트 기능을 지원하지 않습니다. ( SDK 2.1.0.1 )
    // 화면에 광고뷰가 노출된 상태에서만 응답을 받을 수 있으며
    // 응답을 받기까지 빈화면으로 표시될 수 있습니다.
    [self gotAd];
    // 응답을 받기 위해 무조건 광고뷰를 화면에 보이게 합니다.

    [ad startAutoRequestAd:30];    
}

- (void)clearAdView
{
    [super clearAdView];
}


#pragma mark - MobileAdViewDelegate

/**
 광고 수신 성공시 호출되는 메소드.
 @param adView 광고 수신 성공 이벤트가 발생한 AdamAdView 객체.
 */
- (void)didReceiveAd:(AdamAdView *)adView
{
    bGotAd = YES;
    [self gotAd];
}

/**
 광고 수신 실패시 호출되는 메소드.
 광고 수신에 실패한 원인을 알고자 하는 경우, error.localizedDescription 값을 출력해보면 된다.
 @param adView 광고 수신 실패 이벤트가 발생한 AdamAdView 객체.
 @param error 광고 수신에 실패한 원인이 되는 error 객체.
 */
- (void)didFailToReceiveAd:(AdamAdView *)adView error:(NSError *)error
{
    [self failed];
}

/**
 전체화면 광고가 보여질 때 호출되는 메소드.
 배너 광고를 터치하여 광고 페이지가 전체화면에 보여질 때 호출된다.
 @param adView 광고 페이지 열림 이벤트가 발생한 AdamAdView 객체.
 */
- (void)willOpenFullScreenAd:(AdamAdView *)adView
{
}

/**
 전체화면 광고가 닫힐 때 호출되는 메소드.
 전체화면으로 보여지고 있는 광고 페이지가 닫힐 때 호출된다.
 @param adView 광고 페이지 닫힘 이벤트가 발생한 AdamAdView 객체.
 */
- (void)willCloseFullScreenAd:(AdamAdView *)adView
{
}

/**
 광고 터치로 인해 애플리케이션이 종료될 때 호출되는 메소드.
 배너 광고를 터치하여 전화 걸기 또는 앱스토어로 이동하는 경우, 애플리케이션이 백그라운드로 들어가게 될 때 호출된다.
 @param adView 백그라운드로 전환 이벤트를 발생시킨 AdamAdView 객체.
 */
- (void)willResignByAd:(AdamAdView *)adView
{
}

- (CGSize)size
{
    int w;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    if([self isPortrait])
    {
        w = screenWidth;
    }
    else
    {
        w = screenHeight;
    }
    
    return CGSizeMake(w, 48);    
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
    
    ad.frame = CGRectMake(0, 0, w, 48);    
}

@end
