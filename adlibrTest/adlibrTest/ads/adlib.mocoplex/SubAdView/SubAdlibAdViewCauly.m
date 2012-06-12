/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with cauly SDK 2.4.6
 */

#import "SubAdlibAdViewCauly.h"
#import "AdlibManager.h"

// CAULY의 APP 아이디를 설정합니다.
#define CAULY_ID @"CAULY";

@implementation SubAdlibAdViewCauly

+ (BOOL)isStaticObject
{
    return YES;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    static BOOL bIninintedObject = NO;
    
    if(!bIninintedObject)
    {
        [CaulyViewController initCauly:self];
        bIninintedObject = YES;        
        [CaulyViewController requestBannerADWithViewController:parent xPos:0 yPos:0 adType:BT_IPHONE];        
    }

    [CaulyViewController hideBannerAD:NO];
    
    [CaulyViewController moveBannerAD:parent caulyParentview:nil xPos:0 yPos:self.view.frame.origin.y];
    [CaulyViewController bringCaulyBannerADToFront];
  
    [self gotAd];
}

-(void)gotAd
{
    [super gotAd];
    
    [CaulyViewController moveBannerAD:self.parentController caulyParentview:nil xPos:0 yPos:self.view.frame.origin.y];
    [CaulyViewController bringCaulyBannerADToFront];
}

- (void)clearAdView
{
    [CaulyViewController hideBannerAD:YES];
    
    [super clearAdView];    
}

- (void)orientationChanged
{
    [super orientationChanged];    
    
    [CaulyViewController moveBannerAD:self.parentController caulyParentview:nil xPos:0 yPos:self.view.frame.origin.y];
}


- (NSString*)devKey
{
    return CAULY_ID;
}
- (NSString*)age
{
    return [[AdlibManager sharedSingletonClass] getAgeCauly];
}
- (NSString*)gender
{
    return [[AdlibManager sharedSingletonClass] getGenderCauly];
}
- (BOOL)getGPSInfo
{
    return NO;
}
-(REFRESH_PERIOD)rollingPeriod
{
    return SEC_30;
}
-(ANIMATION_TYPE)animationType
{
    return FADEOUT;
}
-(void)AdReceiveFailed
{
    [self failed];
    return;    
}
-(void)AdReceiveCompleted
{
    if(![CaulyViewController IsChargeableAd])
    {
        // 광고 수신에 실패하였습니다. 바로 다음 스케줄 광고를 로드합니다.
        [self failed];
        return;
    }
    
    // 광고를 수신하였습니다.    
    [self gotAd];    
}

- (CGSize)size
{
    return CGSizeMake(self.view.bounds.size.width, 48);
}

@end
