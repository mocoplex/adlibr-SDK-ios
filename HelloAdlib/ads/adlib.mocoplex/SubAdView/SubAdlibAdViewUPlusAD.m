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

@end