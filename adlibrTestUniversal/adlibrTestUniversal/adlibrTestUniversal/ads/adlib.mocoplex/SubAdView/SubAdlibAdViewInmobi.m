/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 5.1.0
 */

#import "SubAdlibAdViewInmobi.h"

#import "IMSdk.h"
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import "IMInterstitial.h"
#import "IMInterstitialDelegate.h"
#import "IMCommonConstants.h"

// 여기에 인모비에서 발급받은 key 를 입력하세요.
#define INMOBI_INITIALIZE   @"4028cb8b2c3a0b45012c406824e800ba"
#define INMOBI_BANNER           1447912324502
#define INMOBI_INTERSTITIAL     1446377525790

#define kBannerSizePhone CGSizeMake(320, 50)
#define kBannerSizePad   CGSizeMake(728, 90)

static BOOL bInmobiInitialized = NO;

@interface SubAdlibAdViewInmobi () <IMBannerDelegate, IMInterstitialDelegate>

@property (nonatomic, strong) IMBanner *adView;
@property (nonatomic, strong) IMInterstitial *interstitial;

@end


@implementation SubAdlibAdViewInmobi

// 객체를 전역적으로 하나만 생성합니다.
+ (BOOL)isStaticObject
{
    if(!bInmobiInitialized)
    {
        // Inmobi Initialize
        [IMSdk initWithAccountID:INMOBI_INITIALIZE];
        [IMSdk setLogLevel:kIMSDKLogLevelDebug];
        bInmobiInitialized = YES;
    }
    
    return YES;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    if (_adView == nil) {
        
        self.view.autoresizesSubviews = NO;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            iPad = NO;
        else
            iPad = YES;
        
        // only iPhone size
        iPad = NO;
        
        IMBanner *bannerView = nil;
        CGPoint origin = [self getInmobiViewOrigin];
        
        if(iPad) {
            bannerView = [[IMBanner alloc] initWithFrame:CGRectMake(origin.x, origin.y, kBannerSizePad.width, kBannerSizePad.height)
                                             placementId:INMOBI_BANNER
                                                delegate:self];
            
        } else {
            
            bannerView = [[IMBanner alloc] initWithFrame:CGRectMake(origin.x, origin.y, kBannerSizePhone.width, kBannerSizePhone.height)
                                             placementId:INMOBI_BANNER
                                                delegate:self];
        }
        self.adView = bannerView;
        [self.view addSubview:_adView];
    }
    
    _adView.delegate = self;
    //_adView.refreshInterval = 10.;
    
    [self queryAd];
    
    [_adView load];
}

- (void)clearAdView
{
    if(_adView != nil)
    {
        _adView.delegate = nil;
        self.adView = nil;
    }
    
    [super clearAdView];
}

- (CGSize)size
{
    if(iPad)
        return kBannerSizePad;
    else
        return kBannerSizePhone;
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    CGFloat width  = kBannerSizePad.width;
    CGFloat height = kBannerSizePad.height;
    
    if (!iPad) {
        width = kBannerSizePhone.width;
        height = kBannerSizePhone.height;
    }
    
    CGPoint origin = [self getInmobiViewOrigin];
    CGFloat ptX = origin.x;
    
    if(iPad)
        _adView.frame = CGRectMake(ptX, 0, width, height);
    else
        _adView.frame = CGRectMake(ptX, 0, width, height);
}

- (CGPoint)getInmobiViewOrigin
{
    CGFloat containerViewWidth, adViewWidth = 0;
    
    containerViewWidth = self.view.bounds.size.width;
    
    if (iPad) {
        adViewWidth = kBannerSizePad.width;
    }
    else
    {
        adViewWidth = kBannerSizePhone.width;
    }
    
    CGFloat originX = (containerViewWidth-adViewWidth)/2;
    if (originX < 0) {
        originX = 0;
    }
    
    CGFloat containerViewHeight, adViewHeight = 0;
    
    containerViewHeight = self.view.bounds.size.height;
    
    if (iPad) {
        adViewHeight = kBannerSizePad.height;
    }
    else
    {
        adViewHeight = kBannerSizePhone.height;
    }
    
    CGFloat originY = (containerViewHeight-adViewHeight)/2;
    if (originY < 0) {
        originY = 0;
    }
    
    return CGPointMake(originX, originY);
}

- (void)subAdlibViewLoadInterstitial:(UIViewController*)viewController
{
    if(!bInmobiInitialized)
    {
        // Inmobi Initialize
        [IMSdk initWithAccountID:INMOBI_INITIALIZE];
        [IMSdk setLogLevel:kIMSDKLogLevelDebug];
        bInmobiInitialized = YES;
    }
    
    IMInterstitial *interstitial = [[IMInterstitial alloc] initWithPlacementId:INMOBI_INTERSTITIAL
                                                                      delegate:self];
    self.interstitial = interstitial;
    
    interstitial.delegate = self;
    [interstitial load];
}

#pragma mark - Banner Request Notifications

// Sent when an ad request was successful
-(void)bannerDidFinishLoading:(IMBanner*)banner {
    
    NSLog(@"banner receiveAd inmobi");
    
    // 화면에 광고를 보여줍니다.
    [self queryAd];
    [self gotAd];
}

/**
 * The banner has failed to load with some error.
 */
-(void)banner:(IMBanner*)banner didFailToLoadWithError:(IMRequestStatus*)error {
    
    NSString *errorMessage = [NSString stringWithFormat:@"Loading ad failed. Error code: %zd, message: %@", [error code], [error localizedDescription]];
    NSLog(@"%@", errorMessage);
    
    // 광고 수신에 실패하였습니다.
    [self failed];
}

/**
 * The banner was interacted with.
 */
-(void)banner:(IMBanner*)banner didInteractWithParams:(NSDictionary*)params {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"params : %@", params);
}

/**
 * The user would be taken out of the application context.
 */
-(void)userWillLeaveApplicationFromBanner:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

/**
 * The banner would be presenting a full screen content.
 */
-(void)bannerWillPresentScreen:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

/**
 * The banner has finished presenting screen.
 */
-(void)bannerDidPresentScreen:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

/**
 * The banner will start dismissing the presented screen.
 */
-(void)bannerWillDismissScreen:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

/**
 * The banner has dismissed the presented screen.
 */
-(void)bannerDidDismissScreen:(IMBanner*)banner {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

/**
 * The user has completed the action to be incentivised with.
 */
-(void)banner:(IMBanner*)banner rewardActionCompletedWithRewards:(NSDictionary*)rewards {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"rewards : %@", rewards);
}

#pragma mark Interstitial Interaction Notifications

/**
 * The interstitial has finished loading
 */
- (void)interstitialDidFinishLoading:(IMInterstitial*)interstitial {
    
    // 전면광고 성공을 알린다.
    [self subAdlibViewInterstitialReceived:@"inmobi"];
    
    [interstitial showFromViewController:self.parentController
                           withAnimation:kIMInterstitialAnimationTypeCoverVertical];
}

/**
 * The interstitial has failed to load with some error.
 */
- (void)interstitial:(IMInterstitial*)interstitial didFailToLoadWithError:(IMRequestStatus*)error {
    
    // 전면광고 실패를 알린다.
    [self subAdlibViewInterstitialFailed:@"inmobi"];
    self.interstitial = nil;
}

- (void)interstitialDidDismissScreen:(IMInterstitial *)ad
{
    // 전면광고 닫힘을 알린다.
    [self subAdlibViewInterstitialClosed:@"inmobi"];
    self.interstitial = nil;
}

- (void)interstitialWillLeaveApplication:(IMInterstitial *)ad
{
    // 전면 광고 클릭 리포팅
    [self reportInterstitialClickEvent];
}

@end
