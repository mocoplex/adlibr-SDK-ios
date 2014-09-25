/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with domob SDK 4.3.3
 */


#import "SubAdlibAdViewDomob.h"

// DOMOB의 APP 아이디를 설정합니다.
#define DOMOB_PUBLISHER_ID @"DOMOB_PUBLISHER_ID"
#define DOMOB_PLACEMENT_ID @"DOMOB_PLACEMENT_ID"

@implementation SubAdlibAdViewDomob

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
    
    ad = [[DMAdView alloc] initWithPublisherId:DOMOB_PUBLISHER_ID
                                   placementId:DOMOB_PLACEMENT_ID];
    ad.frame = CGRectMake(0, 0, DOMOB_AD_SIZE_320x50.width, DOMOB_AD_SIZE_320x50.height);
    
    ad.delegate = self;
    ad.rootViewController = parent;
    [self.view addSubview:ad];
    
    [self queryAd];
    
    // Initiate a generic request to load it with an ad.
    [ad loadAd];
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

- (void)clearAdView
{
    [super clearAdView];
    
    if(ad != nil)
    {
        ad.delegate = nil;
        ad.rootViewController = nil;
        [ad release];
        ad = nil;
    }
}

-(void)dmAdViewSuccessToLoadAd:(DMAdView *)adView
{
    // 화면에 광고를 보여줍니다.
    [self gotAd];
}

-(void)dmAdViewFailToLoadAd:(DMAdView *)adView withError:(NSError *)error
{
    // 광고 수신에 실패하였습니다.
    [self failed];
}

@end
