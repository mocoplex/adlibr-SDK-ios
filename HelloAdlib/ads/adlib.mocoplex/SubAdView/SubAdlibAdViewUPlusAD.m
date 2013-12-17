/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with U+AD SDK 3.0.4
 */

#import "SubAdlibAdViewUPlusAD.h"

// UPLUS의 APP 아이디를 설정합니다.
#define UPLUS_ID @"UPLUS_ID"
#define UPLUS_INTERSTITIAL_ID @"UPLUS_INTERSTITIAL_ID"

@implementation SubAdlibAdViewUPlusAD

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
    
    // 광고뷰를 생성합니다.
    ad = [[UplusAd alloc] initWithFrame:CGRectMake([self getCenterPos], 0, 320, 50)];
    [ad setSlotID:UPLUS_ID];
    [ad setParent:parent];
    
    [self.view addSubview:ad];
    
    [self gotAd];
}

- (void)clearAdView
{
    if(ad != nil)
    {
        [ad release];
        ad = nil;
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

// **주의 : U+AD 전면광고는 광고 수신 성공, 실패에 대한 delegate 메소드가 존재하지 않으므로 스케줄링이 정상적으로 동작하지 않을 수 있습니다.** //
+ (void)loadInterstitail:(UIViewController*)viewController
{
    UplusAd* interstitial_ = [[[UplusAd alloc] initWithFrame:CGRectMake(0,0,10,10)] autorelease];
    [interstitial_ setSlotID:UPLUS_INTERSTITIAL_ID];
    [interstitial_ setFullScreen:YES];
    [interstitial_ setParent:viewController];
    interstitial_.delegate = self;
    [viewController.self.view addSubview:interstitial_];
}

+ (void)didCloseUPlusAdView:(NSString*)slotID
{
    // 전면광고 닫힘을 알린다.
    [self interstitialClosed:@"uplus"];
}

+ (void)isFreeUPlusAdView:(BOOL)bFree
{
    // 광고 과금 여부에 대한 정보
}

@end