/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with t-ad SDK 2.4.6.6
 */

#import "SubAdlibAdViewTAD.h"

// 인모비와 중첩사용의 경우 문제발생이 보고되고 있습니다.

// TAD의 APP 아이디를 설정합니다.
#define TAD_ID @"T-AD"

@implementation SubAdlibAdViewTAD

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
    
    static BOOL bIninintedObject = NO;
    
    if(!bIninintedObject)    
    {
        [TadViewController initialize:TAD_ID bannerPosition:BANNER_POSITION_TOP_CENTER applicationTitle:@"APP TITLE" view:self.view];
        
        [TadViewController setAdDelegate:self];
        [TadViewController enableAutoRotation:YES];        
    }    
    
    // 응답을 받기위해 화면에 보인다.
    [self gotAd];    
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
    
    NSString *deviceType = [UIDevice currentDevice].model;
    if(!iPad)
        return CGSizeMake(w, 48);
    else
        return CGSizeMake(w, 115);
}

@end
