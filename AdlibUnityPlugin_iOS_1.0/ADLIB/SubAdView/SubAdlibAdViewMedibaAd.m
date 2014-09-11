/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with mediba ad SDK 2.0.3
 */

#import "SubAdlibAdViewMedibaAd.h"

// MEDIBA AD의 APP 아이디를 설정합니다.
#define MEDIBA_AD_ID @"MEDIBA_AD_ID"

@implementation SubAdlibAdViewMedibaAd

@synthesize mas = mas_;

// 객체를 전역적으로 하나만 생성합니다.
+ (BOOL)isStaticObject
{
    return YES;
}

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
    
    static BOOL bIninintedObject = NO;
    
    if(!bIninintedObject)
    {
        CGRect rt;
        rt = CGRectMake(0, 0, self.view.bounds.size.width, 50);
        self.view.frame = rt;
        
        MasManagerViewController *m = [[MasManagerViewController alloc] init];
        self.mas = m;
        self.mas.delegate = self;
        
        self.mas.view.frame = CGRectMake([self getCenterPos], 0, 320, 50);
        [self.view addSubview:self.mas.view];
        [m release];
        
        self.mas.sID = MEDIBA_AD_ID;
        
        bIninintedObject = YES;
    }
    
    [self.mas setPosition:kMasMVPosition_top];
    [self.mas loadRequest];
    
}

- (void)clearAdView
{
    if(self.mas)
    {
        [self.mas pauseRefresh];
    }
    [super clearAdView];
}

#pragma mark - MasManagerViewControllerDelegate

// 광고 수신에 성공한 경우 호출되는 메소드
- (void)masManagerViewControllerReceiveAd:(MasManagerViewController *) masManagerViewController
{
    [self gotAd];
}

// 광고 수신에 실패한 경우 호출되는 메소드
-(void)masManagerViewControllerFailedToReceiveAd:(MasManagerViewController *) masManagerViewController
{
    [self failed];
}

- (CGSize)size
{
    return CGSizeMake(320, 50);
}

- (void)orientationChanged
{
    self.mas.view.frame = CGRectMake([self getCenterPos], 0, 320, 50);
    
    [super orientationChanged];
}

@end