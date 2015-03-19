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

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    self.view.autoresizesSubviews = NO;
    
    // 광고뷰를 생성합니다.
    UplusAd *ad = [[UplusAd alloc] initWithFrame:CGRectMake([self getAdViewOriginX], 0, 320, 50)];
    self.adView = ad;
    
    [ad setSlotID:UPLUS_ID];
    [ad setParent:parent];
    
    [_adView removeFromSuperview];
    [self.view addSubview:_adView];
    
    [self queryAd];
}

- (void)clearAdView
{
    if(_adView != nil)
    {
        [_adView removeFromSuperview];
        self.adView = nil;
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
    
    _adView.frame = CGRectMake([self getAdViewOriginX], 0, 320, 50);
}

- (CGFloat)getAdViewOriginX
{
    CGFloat w,w2=0;
    w = self.view.bounds.size.width;
    w2 = 320;
    
    return (w-w2)/2;
}

// **주의 : U+AD 전면광고는 광고 수신 성공, 실패에 대한 delegate 메소드가 존재하지 않으므로 스케줄링이 정상적으로 동작하지 않을 수 있습니다.** //
- (void)subAdlibViewLoadInterstitial:(UIViewController*)viewController
{
    UplusAd* interstitial_ = [[[UplusAd alloc] initWithFrame:CGRectMake(0,0,10,10)] autorelease];
    [interstitial_ setSlotID:UPLUS_INTERSTITIAL_ID];
    [interstitial_ setFullScreen:YES];
    [interstitial_ setParent:viewController];
    interstitial_.delegate = self;
    [viewController.view addSubview:interstitial_];
}

- (void)didCloseUPlusAdView:(NSString*)slotID
{
    // 전면광고 닫힘을 알린다.
    [self subAdlibViewInterstitialClosed:@"uplus"];
}

- (void)isFreeUPlusAdView:(BOOL)bFree
{
    // 광고 과금 여부에 대한 정보
}

@end