/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with adcube SDK 1.9
 */

#import "SubAdlibAdViewAdcube.h"

@interface SubAdlibAdViewCore()

- (void)resizeAdView;

@end

// ADCUBE의 APP 아이디를 설정합니다.
#define ADCUBE_ID @""

@implementation SubAdlibAdViewAdcube

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    int hPadding = 20;
    
    ad = [[zcView alloc] init];
    [ad setRolling:YES];
    [ad setDelegate:self];
    
    [ad showAdsWithAppid:ADCUBE_ID withViewController:parent withView:self.view x:0 y:hPadding];
    
    // 상황에 따라 원하는 넓이로 차등 적용
    int w = self.view.bounds.size.width;    
    
    NSArray* arr = self.view.subviews;
    
    CGRect rt = CGRectMake(0, 0, w, 48);
    
    int cnt = [arr count];
    for (int i=0; i<cnt; i++) {
        UIView* v = [arr objectAtIndex:i];
        v.frame = rt;
    }
}

- (void)resizeAdView
{
    [super resizeAdView];
    
    CGSize sz = [self size];    
    [ad setWidth:sz.width];
}

- (void)dealloc
{
    [super dealloc]; 
}

- (void)clearAdView
{    
    if(ad != nil)
    {
        ad.delegate = nil;
        [ad release];
        ad = nil;        
    }
    
    [super clearAdView];
}

- (void)zcViewDidFinishLoad
{
    // 화면에 광고를 보여줍니다.
    [self gotAd];    
}

- (void)zcViewDidFailLoadWithError:(NSError *)error
{
    // 광고 수신에 실패하였습니다.
    [self failed];
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

    NSArray* arr = self.view.subviews;
    
    CGRect rt = CGRectMake(0, 0, w, 48);
    
    int cnt = [arr count];
    for (int i=0; i<cnt; i++) {
        UIView* v = [arr objectAtIndex:i];
        v.frame = rt;
    }
}

@end