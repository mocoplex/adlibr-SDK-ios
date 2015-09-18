/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with admob SDK 7.4.1
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
// https://developers.google.com/mobile-ads-sdk/images/linXker-ios.png

#import "SubAdlibAdViewAdmob.h"

// ADMOB의 APP 아이디를 설정합니다.
#define ADMOB_ID @"ADMOB_ID"
#define ADMOB_INTERSTITIAL_ID @"ADMOB_INTERSTITIAL_ID"
#define ADMOB_TEST_DEVICE_ID @"ADMOB_TEST_DEVICE_ID"

@interface SubAdlibAdViewAdmob ()  <GADBannerViewDelegate, GADInterstitialDelegate>

@property (nonatomic, strong) GADInterstitial* interstitial;
@property (nonatomic, weak) UIViewController *parentViewController;
@property (nonatomic) BOOL useGADSmartBannerMode;

@end


@implementation SubAdlibAdViewAdmob

// 객체를 전역적으로 하나만 생성합니다.
+ (BOOL)isStaticObject
{
    return YES;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _iPad = NO;
        else
            _iPad = YES;
        
        _useGADSmartBannerMode = NO;
    }
    return self;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    // Create a view of the standard size at the bottom of the screen.
    if (_adView) {
        [_adView removeFromSuperview];
        self.adView = nil;
    }
    
    GADAdSize gadSize = kGADAdSizeBanner;
    
    if (_useGADSmartBannerMode) {
        if ([self isPortrait]) {
            gadSize = kGADAdSizeSmartBannerPortrait;
        } else {
            gadSize = kGADAdSizeSmartBannerLandscape;
        }
    } else {
        if (_iPad) {
            gadSize = kGADAdSizeLargeBanner;
        } else {
            gadSize = kGADAdSizeBanner;
        }
        
    }
    
    GADBannerView *adView = [[GADBannerView alloc] initWithAdSize:gadSize];
    self.adView = adView;
    _adView.frame = CGRectMake(0,
                               0,
                               self.view.frame.size.width,
                               _adView.frame.size.height);
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    _adView.adUnitID = ADMOB_ID;
    _adView.delegate = self;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    _adView.rootViewController = parent;
    [self.view addSubview:_adView];
    
    [self queryAd];
    
    GADRequest *request = [GADRequest request];
    
    //  테스트 광고를 요청합니다. 테스트 광고를 수신하려는 시뮬레이터 및 모든 기기에 대한 식별자를 삽입합니다.
    request.testDevices = @[ ADMOB_TEST_DEVICE_ID ];
    
    // Initiate a generic request to load it with an ad.
    [_adView loadRequest:request];
}

// 플랫폼 광고 뷰가 미디에이션 광고 컨테이너뷰에서 사라질 때의 처리를 구현합니다.
- (void)clearAdView
{
    [super clearAdView];
    
    if(_adView != nil)
    {
        [_adView removeFromSuperview];
        _adView.delegate = nil;
        _adView.rootViewController = nil;
        self.adView = nil;
    }
}

// 플랫폼 광고 뷰의 크기를 반환합니다. (Admob GADBannerView)
// 기본 가로 320, 세로 50
// admob ipad 광고 버전을 사용할 경우 광고 뷰의 높이를
// admob ipad 광고 높이 크기 100으로 반환하여 사용합니다.
- (CGSize)size
{
    if (_useGADSmartBannerMode) {
        CGFloat viewHeight = 0;
        CGSize  gadSize = _adView.frame.size;
        
        if (CGSizeEqualToSize(gadSize, CGSizeZero)) {
            if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) {
                viewHeight = kGADAdSizeLargeBanner.size.height;
            } else {
                viewHeight = kGADAdSizeBanner.size.height;
            }
            return CGSizeMake(self.view.frame.size.width, viewHeight);
        } else {
            viewHeight = gadSize.height;
            return CGSizeMake(self.view.frame.size.width, viewHeight);
        }
    }
    
    CGSize gadSize = CGSizeZero;
    if (_iPad) {
        gadSize = kGADAdSizeLargeBanner.size;
    } else {
        gadSize = kGADAdSizeBanner.size;
    }
    
    return CGSizeMake(self.view.frame.size.width, gadSize.height);
    
}

// 플랫폼 광고뷰의 회전에 대한 처리를 수행합니다.
// 미디에이션 광고 컨테이너 뷰의 크기 변경 시 플랫폼 광고뷰의 frame을 변경합니다.
- (void)orientationChanged
{
    [super orientationChanged];
    
    CGFloat originY = self.view.bounds.size.height - _adView.frame.size.height;
    if (originY < 0) {
        originY = 0;
    }
    _adView.frame = CGRectMake(0,
                               originY,
                               self.view.frame.size.width,
                               _adView.frame.size.height);
}

// 해당 플래폼 광고에 전면광고 요청을 처리합니다.
- (void)subAdlibViewLoadInterstitial:(UIViewController*)viewController
{
    GADInterstitial* interstitial_ = [[GADInterstitial alloc] initWithAdUnitID:ADMOB_INTERSTITIAL_ID];
    self.interstitial = interstitial_;
    
    interstitial_.delegate = self;
    self.parentController = viewController;
    [interstitial_ loadRequest:[GADRequest request]];
}

#pragma mark - GADBannerViewDelegate

- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"\n\n admob receive Ad");
    // 화면에 광고를 보여줍니다.
    [self gotAd];
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"\n\n admob receive fail Ad : %@", error);
    // 광고 수신에 실패 처리를 요청합니다.
    [self failed];
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    // 띠 배너 광고 클릭 리포팅
    [self reportBannerClickEvent];
}

/// Called just before dismissing a full screen view.
- (void)adViewWillDismissScreen:(GADBannerView *)adView
{
    
}

/// Called just after dismissing a full screen view. Use this opportunity to restart anything you
/// may have stopped as part of adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)adView
{
    
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store). The normal
/// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
/// before this.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView
{
    // 띠 배너 광고 클릭 리포팅
    [self reportBannerClickEvent];
}

#pragma mark - GADInterstitialDelegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial
{
    if (self.parentController) {
        
        //전면광고를 화면에 표시합니다.
        [interstitial presentFromRootViewController:self.parentController];
        
        // 전면광고 성공을 알린다.
        [self subAdlibViewInterstitialReceived:@"admob"];
    } else {
        // 전면광고 실패를 알린다.
        [self subAdlibViewInterstitialFailed:@"admob"];
    }
}

- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"\n\n admob interstitial receive fail Ad : %@", error);
    
    // 전면광고 실패를 알린다.
    [self subAdlibViewInterstitialFailed:@"admob"];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    // 전면광고 닫힘을 알린다.
    [self subAdlibViewInterstitialClosed:@"admob"];
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad
{
    // 전면광고 클릭 리포팅
    [self reportInterstitialClickEvent];
    
    // 전면광고 닫힘을 알린다.
    [self subAdlibViewInterstitialClosed:@"admob"];
}

@end
