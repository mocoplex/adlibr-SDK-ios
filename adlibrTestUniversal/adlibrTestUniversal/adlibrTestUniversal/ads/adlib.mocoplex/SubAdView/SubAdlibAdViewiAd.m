/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with iAD
 */

#import "SubAdlibAdViewiAd.h"

#define iAd_iPhone_LandscapeHeight 32
#define iAd_iPhone_PortraitHeight  50
#define iAd_iPad_Height  50

@implementation SubAdlibAdViewiAd

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        iPad = NO;
    else
        iPad = YES;
    
    self.view.autoresizesSubviews = NO;
    
    ADBannerView *iAdBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    self.iAdBannerView = iAdBannerView;
    
    // 현재 단말기 상태에 맞게 화면에 표시한다.
    CGSize adViewSize = self.view.bounds.size;
    CGFloat adViewWidth = adViewSize.width;
    CGFloat iAdViewHeight = [self iAdViewHeight];
    
    _iAdBannerView.frame = CGRectMake(0, 0, adViewWidth, iAdViewHeight);
    _iAdBannerView.delegate = self;
        
    [self.view addSubview:_iAdBannerView];
    
    [self queryAd];
}

- (void)clearAdView
{
    [super clearAdView];
    
    if(_iAdBannerView != nil)
    {
        [_iAdBannerView removeFromSuperview];
        _iAdBannerView.delegate = nil;
        self.iAdBannerView = nil;
    }
}

- (void)orientationChanged
{
    [super orientationChanged];    
    
    CGSize adViewSize = self.view.bounds.size;
    CGFloat adViewWidth = adViewSize.width;
    CGFloat iAdViewHeight = [self iAdViewHeight];
    
    _iAdBannerView.frame = CGRectMake(0, 0, adViewWidth, iAdViewHeight);
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    // 배너 사이즈의 변경을 알린다.
    [self adsizeChanged];
}

- (CGSize)size
{
    CGFloat iAdViewHeight = [self iAdViewHeight];
    return CGSizeMake(self.view.bounds.size.width, iAdViewHeight);
}

- (CGFloat)iAdViewHeight
{
    CGFloat iAdViewHeight = 0;
    
    if([self isPortrait])
    {
        if(iPad)
            iAdViewHeight = iAd_iPad_Height;
        else
            iAdViewHeight = iAd_iPhone_PortraitHeight;
    }
    else
    {
        if(iPad)
            iAdViewHeight = iAd_iPad_Height;
        else
            iAdViewHeight = iAd_iPhone_LandscapeHeight;
    }
    
    return iAdViewHeight;
}

#pragma mark - ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if(_iAdBannerView.bannerLoaded)
    {
        // 광고를 가져왔으면 화면에 보인다.
        [self queryAd];
        [self gotAd];
    }
    else {
        // 광고를 가져오지 못했다. 다음광고를 로드한다.
        [self failed];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    // 광고 수신 실패
    [self failed];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    // 배너 클릭 이벤트 리포팅
    [self reportBannerClickEvent];
    
    return YES;
}

@end
