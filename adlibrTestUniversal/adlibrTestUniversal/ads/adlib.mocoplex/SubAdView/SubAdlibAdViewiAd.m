/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with iAD
 */

#import "SubAdlibAdViewiAd.h"
#import "AdlibManager.h"

@implementation SubAdlibAdViewiAd

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    NSString *deviceType = [UIDevice currentDevice].model;
    NSRange range = [deviceType rangeOfString:@"iPad"];
    if(range.location == NSNotFound)
        iPad = NO;
    else
        iPad = YES;    
    
    self.view.autoresizesSubviews = NO;
    ad = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
    // 현재 단말기 상태에 맞게 화면에 표시한다.
    if([self isPortrait])
    {
        ad.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
        ad.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        
        if(iPad)
            ad.frame = CGRectMake(0, 0, self.view.bounds.size.width, 66);
        else
            ad.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    }
    else
    {
        ad.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierLandscape];
        ad.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;        
        
        if(iPad)
            ad.frame = CGRectMake(0, 0, self.view.bounds.size.width, 66);
        else
            ad.frame = CGRectMake(0, 0, self.view.bounds.size.width, 32);
    }
    ad.delegate = self;
        
    [self.view addSubview:ad];
}

- (void)clearAdView
{
    [super clearAdView];
    
    if(ad != nil)
    {
        [ad removeFromSuperview];

        ad.delegate = nil;
        [ad release];
        ad = nil;
    }
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
    
    if([self isPortrait])
    {
        // 세로모드로 변경되었다.
        ad.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
        ad.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        
        if(iPad)        
            ad.frame = CGRectMake(0, 0, w, 66);
        else
            ad.frame = CGRectMake(0, 0, w, 50);
    }
    else
    {
        // 가로모드로 변경되었다.    
        ad.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierLandscape];
        ad.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;    

        if(iPad)        
            ad.frame = CGRectMake(0, 0, w, 66);
        else
            ad.frame = CGRectMake(0, 0, w, 32);
    }
    
    [super orientationChanged];
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    // 배너 사이즈의 변경을 알린다.
    [self adsizeChanged];
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
        if(iPad)        
            return CGSizeMake(w, 66);
        else
            return CGSizeMake(w, 50);
    }
    else
    {
        w = screenHeight;
        if(iPad)        
            return CGSizeMake(w, 66);
        else        
            return CGSizeMake(w, 32);
    }
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if(ad.bannerLoaded) // 광고를 가져왔으면 화면에 보인다.   
    {
        [self gotAd];
    }
    else            // 광고를 가져오지 못했다. 다음광고를 로드한다.
        [self failed];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self failed];    
}

@end
