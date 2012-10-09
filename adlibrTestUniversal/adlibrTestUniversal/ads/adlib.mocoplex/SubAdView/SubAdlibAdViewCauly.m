/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with cauly SDK 2.5.0
 */

#import "SubAdlibAdViewCauly.h"
#import "AdlibManager.h"

// CAULY의 APP 아이디를 설정합니다.
#define CAULY_ID @"CAULY ID";

@implementation SubAdlibAdViewCauly

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
    
    if (iPad) {
        w2 = 768;            
    }
    else
    {
        w2 = 320;            
    }
    
    return (w-w2)/2;
}

+ (BOOL)isStaticObject
{
    return YES;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        iPad = NO;
    else
        iPad = YES;
    
    static BOOL bIninintedObject = NO;
    
    if(!bIninintedObject)
    {
        [CaulyViewController initCauly:self];
        bIninintedObject = YES;
        if (iPad) {
            [CaulyViewController requestBannerADWithViewController:parent xPos:[self getCenterPos] yPos:0 adType:BT_IPAD_LARGE];                    
        }
        else
        {
            [CaulyViewController requestBannerADWithViewController:parent xPos:[self getCenterPos] yPos:0 adType:BT_IPHONE];
        }
    }

    [CaulyViewController hideBannerAD:NO];
    
    [CaulyViewController moveBannerAD:parent caulyParentview:nil xPos:[self getCenterPos] yPos:self.view.frame.origin.y];
    [CaulyViewController bringCaulyBannerADToFront];
    [CaulyViewController startLoading];
    
    if(bGotAd)
        [self gotAd];
}

-(void)gotAd
{
    bGotAd = YES;
    [super gotAd];
    
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
    
    if (iPad) {
        w2 = 768;            
    }
    else
    {
        w2 = 320;            
    }
    
    [CaulyViewController moveBannerAD:self.parentController caulyParentview:nil xPos:[self getCenterPos] yPos:self.view.frame.origin.y];
    [CaulyViewController bringCaulyBannerADToFront];
}

- (void)clearAdView
{
    [CaulyViewController stopLoading];
    [CaulyViewController hideBannerAD:YES];
    
    [super clearAdView];    
}

- (void)orientationChanged
{
    [super orientationChanged];    
    
    
    // 320 768
    [CaulyViewController moveBannerAD:self.parentController caulyParentview:nil xPos:[self getCenterPos] yPos:self.view.frame.origin.y];
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
    if(iPad)
        return CGSizeMake(self.view.bounds.size.width, 90);
    else
        return CGSizeMake(self.view.bounds.size.width, 48);
    
}

@end
