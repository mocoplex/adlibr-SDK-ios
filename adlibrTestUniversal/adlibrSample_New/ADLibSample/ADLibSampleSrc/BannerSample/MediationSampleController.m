//
//  MediationSampleController.m
//  ADLibSample
//
//  Created by gskang on 2016. 8. 17..
//
//

#import "MediationSampleController.h"

#import <Adlib/ADLibBanner.h>
#import "SampleKey.h"

//#import "ALAdapterAdmob.h"
//#import "ALAdapterCauly.h"


// ADMOB의 APP 아이디를 설정합니다.
#define ADMOB_ID @"애드몹 띠배너 아이디 설정"
#define ADMOB_INTERSTITIAL_ID @"애드몹 전면배너 아이디 설정"

// CAULY의 키값을 설정합니다.
#define CAULY_ID        @"CAULY"


@interface MediationSampleController () <ALInterstitialAdDelegate, ALAdBannerViewDelegate>

@property (nonatomic) IBOutlet ALAdBannerView *bannerView;
@property (nonatomic, strong) ALInterstitialAd *interstitialAd;

@end

@implementation MediationSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    // 미디에이션 플랫폼 등록
    //[ALMediation registerPlatform:ALMEDIATION_PLATFORM_ADMOB withClass:[ALAdapterAdmob class]];
    //[ALMediation registerPlatform:ALMEDIATION_PLATFORM_CAULY withClass:[ALAdapterCauly class]];
    //[ALMediation registerPlatform:ALMEDIATION_PLATFORM_ADAM withClass:[ALAdapterAdfit class]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 미디에이션 플랫폼 띠배너 키설정
    //[_bannerView setKey:ADMOB_ID forPlatform:ALMEDIATION_PLATFORM_ADMOB];
    //[_bannerView setKey:CAULY_ID forPlatform:ALMEDIATION_PLATFORM_CAULY];
    
    _bannerView.isTestMode = YES;
    _bannerView.repeatLoop = YES;
    
    //앱 업데이트시에는 발급받으신 키로 교체하세요.
    NSString *appKey = kADLIB_TEST_ADMOB;
    
    [_bannerView startAdViewWithKey:appKey
                 rootViewController:self
                         adDelegate:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_bannerView stopAdView];
}

- (IBAction)requestIntersAd:(id)sender
{
    ALInterstitialAd *interstitialAd = [[ALInterstitialAd alloc] initWithRootViewController:self];
    self.interstitialAd = interstitialAd;
    
    //미디에이션 플랫폼 전면배너 키설정
    //[_interstitialAd setKey:ADMOB_INTERSTITIAL_ID forPlatform:ALMEDIATION_PLATFORM_ADMOB];
    //[_interstitialAd setKey:CAULY_ID forPlatform:ALMEDIATION_PLATFORM_CAULY];
    
    interstitialAd.isTestMode = YES;
    
    //앱 업데이트시에는 발급받으신 키로 교체하세요.
    NSString *appKey = kADLIB_TEST_ADMOB;
    
    [_interstitialAd requestAdWithKey:appKey adDelegate:self];
}

#pragma mark - ALInterstitialAd delegate
/**
 *  전면광고 요청이 성공에 대한 알림
 */
- (void)alInterstitialAd:(ALInterstitialAd *)interstitialAd didReceivedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"didReceivedAdAtPlatform : %zd", platform);
}

/**
 * *  전면광고 요청 실패에 대한 알림
 */
- (void)alInterstitialAd:(ALInterstitialAd *)interstitialAd didFailedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"didFailedAdAtPlatform : %zd", platform);
}

/**
 *  모든 전면광고 요청 실패에 대한 알림
 */
- (void)alInterstitialAdDidFailedAd:(ALInterstitialAd *)interstitialAd
{
    NSLog(@"alInterstitialAdDidFailedAd");
}

#pragma mark - ALAdBannerView delegate

/**
 *  띠 배너 광고요청 재개 상태에서 내부적인 상태 변화를 통지합니다.
 */
- (void)alAdBannerView:(ALAdBannerView *)bannerView didChangeState:(ALMEDIATION_STATE)state withExtraInfo:(id)info
{
    NSLog(@"bannerView state : %@, info = %@", [ALMediationDefine descriptionOfState:state], info);
}

/**
 *  플랫폼에 요청한 띠배너 광고의 성공 상태를 반환합니다.
 */
- (void)alAdBannerView:(ALAdBannerView *)bannerView didReceivedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"bannerView receivedAd : %@", [ALMediationDefine nameOfPlatform:platform]);
}

/**
 *  플랫폼에 요청한 띠배너 광고의 실패 상태를 반환합니다.
 */
- (void)alAdBannerView:(ALAdBannerView *)bannerView didFailedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"bannerView failedAd : %@", [ALMediationDefine nameOfPlatform:platform]);
    
}


//등록된 모든 플랫폼 광고의 실패 상태를 반환합니다.
- (BOOL)alAdBannerViewDidFailedAtAllPlatform:(ALAdBannerView *)bannerView
{
    return YES;
}

@end
