/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with admob SDK 6.12.0
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
    
    w2 = ad.frame.size.width;
    
    return (w-w2)/2;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    // Create a view of the standard size at the bottom of the screen.
    ad = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    ad.frame = CGRectMake([self getCenterPos], 0, ad.frame.size.width, ad.frame.size.height);
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    ad.adUnitID = ADMOB_ID;    
    ad.delegate = self;

    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    ad.rootViewController = parent;
    [self.view addSubview:ad];
    
    [self queryAd];
    
    GADRequest *request = [GADRequest request];
    
    // 테스트 광고를 요청합니다. 테스트 광고를 수신하려는
    // 시뮬레이터 및 모든 기기에 대한 식별자를 삽입합니다.
    //    request.testDevices = [NSArray arrayWithObjects:
    //                           @"YOUR_SIMULATOR_IDENTIFIER",
    //                           @"YOUR_DEVICE_IDENTIFIER",
    //                           nil];
    
    // Initiate a generic request to load it with an ad.
    [ad loadRequest:request];
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
    
    return CGSizeMake(w, ad.frame.size.height);
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    ad.frame = CGRectMake([self getCenterPos], 0, ad.frame.size.width, ad.frame.size.height);
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


static UIViewController* vc;
+ (void)loadInterstitail:(UIViewController*)viewController
{
    GADInterstitial* interstitial_ = [[GADInterstitial alloc] init];
    interstitial_.adUnitID = ADMOB_ID;
    interstitial_.delegate = self;
    vc = viewController;
    [interstitial_ loadRequest:[GADRequest request]];
}

+ (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial
{
    [interstitial presentFromRootViewController:vc];
    // 전면광고 성공을 알린다.
    [self interstitialReceived:@"admob"];
}

+ (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error
{
    // 전면광고 실패를 알린다.
    [self interstitialFailed:@"admob"];
}

+ (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    // 전면광고 닫힘을 알린다.
    [self interstitialClosed:@"admob"];
}

@end