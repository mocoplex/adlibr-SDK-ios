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

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        iPad = NO;
    else
        iPad = YES;
    
    DMAdView *dmaView = [[DMAdView alloc] initWithPublisherId:DOMOB_PUBLISHER_ID
                                                  placementId:DOMOB_PLACEMENT_ID];
    self.ad = dmaView;
    ad.frame = [self getAdViewFrame];
    
    ad.delegate = self;
    ad.rootViewController = parent;
    [self.view addSubview:ad];
    
    [self queryAd];
    
    // Initiate a generic request to load it with an ad.
    [ad loadAd];
}

- (CGSize)size
{
    CGSize adViewSize = CGSizeZero;
    if(iPad)
    {
        adViewSize = DOMOB_AD_SIZE_728x90;
    }
    else
    {
        adViewSize = DOMOB_AD_SIZE_320x50;
    }
    
    return adViewSize;
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    ad.frame = [self getAdViewFrame];
}

- (void)clearAdView
{
    [super clearAdView];
    
    if(ad != nil)
    {
        [ad removeFromSuperview];
        ad.delegate = nil;
        ad.rootViewController = nil;
        ad = nil;
    }
}

- (CGRect)getAdViewFrame
{
    CGRect frame = CGRectZero;
    CGSize adViewSize = [self size];

    CGFloat originX = (self.view.bounds.size.width - adViewSize.width)/2;
    CGFloat originY = (self.view.bounds.size.height - adViewSize.height);
    
    if (originX < 0) {
        originX = 0;
    }
    
    if (originY < 0) {
        originY = 0;
    }
    
    frame = CGRectMake(originX, originY, adViewSize.width, adViewSize.height);
    
    return frame;
}

#pragma mark -

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
