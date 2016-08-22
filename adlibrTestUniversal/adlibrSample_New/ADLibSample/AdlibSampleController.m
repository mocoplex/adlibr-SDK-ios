//
//  AdlibSampleController.m
//  ADLibSample
//
//  Created by gskang on 2016. 8. 17..
//
//

#import "AdlibSampleController.h"
#import <Adlib/ADLibBanner.h>

#define ADLIB_APP_KEY @"550787410cf2833915d71f3b" //adlib, adlib-house


@interface AdlibSampleController () <ALInterstitialAdDelegate, ALAdBannerViewDelegate>

@property (nonatomic) IBOutlet ALAdBannerView *bannerView;
@property (nonatomic, strong) ALInterstitialAd *interstitialAd;

@end


@implementation AdlibSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //테스트 모드를 설정할 수 있습니다.
    _bannerView.isTestMode = YES;
    
    //광고 호출 완료 후 설정된 시간 이후 자동 갱신 요청 여부를 설정합니다.
    _bannerView.repeatLoop = NO;
    
    /**
     *  배너 광고를 요청한다.
     *  요청한 애드립 키값에 해당하는 띠배너 광고 플랫폼들에 대해서 순차적으로 광고를 요청하고 성공/실패 시 콜백을 호출한다.
     *
     *  @param key : 애드립 앱키
     *  @param rootViewController : 광고를 호출하는 뷰컨트롤러
     *  @param delegate : 광고 요청 및 수신 상태에 대한 델리게이트
     */
    [_bannerView startAdViewWithKey:ADLIB_APP_KEY
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
    
    interstitialAd.isTestMode = YES;
    
    [_interstitialAd requestAdWithKey:ADLIB_APP_KEY adDelegate:self];
}

- (void)cancelInterstitialAdRequest
{
    if (_interstitialAd) {
        [_interstitialAd stopAdReqeust];
    }
}

#pragma mark -
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

#pragma mark - Band

/**
 *  띠 배너 광고요청 재개 상태에서 내부적인 상태 변화를 통지합니다.
 */
- (void)alAdBannerView:(ALAdBannerView *)bannerView didChangeState:(ALMEDIAION_STATE)state withExtraInfo:(id)info
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

@end
