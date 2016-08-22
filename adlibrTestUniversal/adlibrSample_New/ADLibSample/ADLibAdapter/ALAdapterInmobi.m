//
//  ALAdapterInmobi.m
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 8. 18..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import "ALAdapterInmobi.h"
#import "IMSdk.h"
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import "IMInterstitial.h"
#import "IMInterstitialDelegate.h"
#import "IMCommonConstants.h"

#define kBannerSizePhone CGSizeMake(320, 50)
#define kBannerSizePad   CGSizeMake(728, 90)


/*
 * confirmed compatible with Inmobi SDK 5.1.0
 */

@interface ALAdapterInmobi () <IMBannerDelegate, IMInterstitialDelegate>

@property (nonatomic, strong) IMBanner *adView;
@property (nonatomic, strong) IMInterstitial *interstitial;

@end


@implementation ALAdapterInmobi

+ (void)initializeInmobiSDK:(NSString *)initKey
{
    [IMSdk initWithAccountID:initKey];
    [IMSdk setLogLevel:kIMSDKLogLevelNone];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.mediationPlatform = ALMEDIATION_PLATFORM_INMOBI;
    }
    return self;
}

/**
 *  띠배너 미디에이션 관련 구현 코드
 */

#pragma mark - mediation Banner protocol

- (BOOL)resizedAdViewWithBounds:(CGRect)adViewBounds
{
    //해당 광고뷰를 담는 부모뷰의 bounds내에서 프레임을 설정할 수 있다.
    //광고뷰의 프레임을 직접할경우 프레임 변경후 YES 리턴하도록 변경한다.
    //NO일 경우 애드립 SDK에서 프레임 조정
    return NO;
}

- (UIView *)platformAdView
{
    //광고뷰 생성시 배너키 값이 필요해서 미리 생성해두고 사용할 수 없다.
    //광고 수신 완료 후의 배너뷰를 애드립 미디에이션으로 전달하여 사용한다.
    //따라서 수신 요청 단계에서 SDK 내부에서 미리 뷰를 추가해 둘 수는 없다.
    //_adView == nil 인 경우에 해당
    
    return _adView;
}

- (UIView *)mediationBannerAdRequest:(UIViewController*)viewController withKey:(NSString *)key
{
    if (key == nil) {
        // 전면광고 실패를 알린다.
        [self mediationBannerAdFailedAd];
        return nil;
    }
    
    if (_adView == nil) {
        
        long long inmobiBannerId = [key longLongValue];
        
        UIView *containerView = self.bannerContainerView;
        IMBanner *bannerView = [[IMBanner alloc] initWithFrame:containerView.bounds
                                                   placementId:inmobiBannerId
                                                      delegate:self];
        
        [bannerView shouldAutoRefresh:NO];
        self.adView = bannerView;
    }
    
    _adView.delegate = self;
    [_adView load];

    return _adView;
}

/**
 *  전면배너 미디에이션 관련 구현 코드
 */

#pragma mark - mediation Interstitial protocol

// 해당 플래폼 광고에 전면광고 요청을 처리합니다.
- (BOOL)mediationInterstitialAdReqeust:(UIViewController*)viewController withKey:(NSString *)key
{
    if (key == nil) {
        // 전면광고 실패를 알린다.
        [self mediationInterstitialAdFailedAd];
        return YES;
    }
    
    long long intersitialId = [key longLongValue];
    IMInterstitial *interstitial = [[IMInterstitial alloc] initWithPlacementId:intersitialId
                                                                      delegate:self];
    self.interstitial = interstitial;
    
    interstitial.delegate = self;
    [interstitial load];
    
    return YES;
}

#pragma mark - Inmobi Banner Request Notifications

// Sent when an ad request was successful
-(void)bannerDidFinishLoading:(IMBanner*)banner {
    
    NSLog(@"banner receiveAd inmobi");
    
    // 화면에 광고를 보여줍니다.
    [self mediationBannerAdReceivedWithView:_adView];
}

/**
 * The banner has failed to load with some error.
 */
- (void)banner:(IMBanner*)banner didFailToLoadWithError:(IMRequestStatus*)error {
    
    NSString *errorMessage = [NSString stringWithFormat:@"Loading ad failed. Error code: %zd, message: %@", [error code], [error localizedDescription]];
    NSLog(@"%@", errorMessage);
    
    // 광고 수신에 실패 처리를 요청합니다.
    [self mediationBannerAdFailedAd];
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
    [self mediationInterstitialAdReceived];
    
    [interstitial showFromViewController:self.rootViewController
                           withAnimation:kIMInterstitialAnimationTypeCoverVertical];
}

/**
 * The interstitial has failed to load with some error.
 */
- (void)interstitial:(IMInterstitial*)interstitial didFailToLoadWithError:(IMRequestStatus*)error {
    
    // 전면광고 실패를 알린다.
    [self mediationInterstitialAdFailedAd];
    
    self.interstitial = nil;
}

- (void)interstitialDidDismissScreen:(IMInterstitial *)ad
{
    // 전면광고 닫힘을 알린다.
    [self mediationInterstitialAdViewClosed];
    
    self.interstitial = nil;
}

- (void)interstitialWillLeaveApplication:(IMInterstitial *)ad
{
    // 전면 광고 클릭 리포팅
    [self mediationInterstitialAdReportClickEvent];
    
    self.interstitial = nil;
}

@end
