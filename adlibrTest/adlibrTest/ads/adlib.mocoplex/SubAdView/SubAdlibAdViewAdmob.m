/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with admob SDK 6.0.1 (2012.04.233)
 */

#import "SubAdlibAdViewAdmob.h"

// ADMOB의 APP 아이디를 설정합니다.
#define ADMOB_ID @"ADMOB-ID"

@implementation SubAdlibAdViewAdmob

- (GADRequest*)createRequest
{    
    GADRequest* req = [GADRequest request];
    req.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
    
    return req;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
        
    // Create a view of the standard size at the bottom of the screen.
    ad = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            0,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    ad.adUnitID = ADMOB_ID;    
    ad.delegate = self;

    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    ad.rootViewController = parent;
    [self.view addSubview:ad];
    
    // Initiate a generic request to load it with an ad.
    [ad loadRequest:[self createRequest]];
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

- (CGSize)size
{
    return CGSizeMake(self.view.bounds.size.width, 50);
}

-(void)adViewDidReceiveAd:(GADBannerView *)view
{
    // 화면에 광고를 보여줍니다.
    [self gotAd];
}

-(void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    // 광고 수신에 실패하였습니다.    
    [self failed];    
}

@end
