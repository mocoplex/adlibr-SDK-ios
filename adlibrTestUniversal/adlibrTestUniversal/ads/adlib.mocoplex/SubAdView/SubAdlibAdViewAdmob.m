/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with admob SDK 6.5.0
 */

// 실제 프로젝트 적용시 위 주소를 참고하여
// https://developers.google.com/mobile-ads-sdk/docs/ios/fundamentals
/*
 You now need to add -all_load to the Other Linker Flags of your application target's build setting:
 In XCode's project navigator, press the blue top-level project icon.
 Click on your target, then the Build Settings tab.
 Under Other Linker Flags, add -all_load to both Debug and Release. 
*/
// flag 를 추가해야합니다.
// https://developers.google.com/mobile-ads-sdk/images/linker-ios.png


#import "SubAdlibAdViewAdmob.h"

// ADMOB의 APP 아이디를 설정합니다.
#define ADMOB_ID @"ADMOB_ID"

@implementation SubAdlibAdViewAdmob

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
        w2 = 728;            
    }
    else
    {
        w2 = 320;            
    }
    
    return (w-w2)/2;
}

- (GADRequest*)createRequest
{
    GADRequest* req = [GADRequest request];
    req.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
    
    return req;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
 
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        iPad = NO;
    else
        iPad = YES;
    
    // Create a view of the standard size at the bottom of the screen.
    if(iPad)
        ad = [[GADBannerView alloc]
                   initWithFrame:CGRectMake([self getCenterPos],
                                            0,
                                            GAD_SIZE_728x90.width,
                                            GAD_SIZE_728x90.height)];
    else
        ad = [[GADBannerView alloc]
              initWithFrame:CGRectMake([self getCenterPos],
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

- (CGSize)size
{
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
    
    if(iPad)    
        return CGSizeMake(w, 90);
    else
        return CGSizeMake(w, 50);
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
    
    int w2;
    if (iPad) {
        w2 = 728;
    }
    else
    {
        w2 = 320;            
    }
    
    int h2 = 90;
    if(!iPad)
        h2 = 50;
    
    if([self isPortrait])
    {
        ad.frame = CGRectMake([self getCenterPos], 0, w2, h2);
    }
    else
    {
        ad.frame = CGRectMake([self getCenterPos], 0, w2, h2);        
    }    
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
