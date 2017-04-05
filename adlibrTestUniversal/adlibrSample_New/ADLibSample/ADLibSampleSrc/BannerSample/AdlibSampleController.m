//
//  AdlibSampleController.m
//  ADLibSample
//
//  Created by gskang on 2016. 8. 17..
//
//

#import "AdlibSampleController.h"
#import <Adlib/ADLibBanner.h>
#import "SampleKey.h"

@interface AdlibSampleController () <ALInterstitialAdDelegate, ALAdBannerViewDelegate>

@property (nonatomic) IBOutlet UIView *bannerContainerView;

@property (nonatomic) ALAdBannerView *bannerView;
@property (nonatomic, strong) ALInterstitialAd *interstitialAd;

@end


@implementation AdlibSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (_bannerView) {
        _bannerView.frame = _bannerContainerView.bounds;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadAdlibAdvert];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopAdlibAdvert];
}

- (void)loadAdlibAdvert
{
    if (_bannerView == nil){
        
        //배너뷰를 생성하고 초기화 설정을 합니다.
        _bannerView = [[ALAdBannerView alloc] initWithFrame:_bannerContainerView.bounds];
        
#warning - 광고 테스트 모드 설정값은 상용으로 배포시 반드시 확인합니다.
        //테스트 모드를 설정할 수 있습니다.
        _bannerView.isTestMode = YES;
        
        //광고 호출 완료 후 설정된 시간 이후 자동으로 다음 광고호출 갱신여부를 설정합니다.
        //화면 전환시 에만 최초 1회 광고를 호출하려면 NO를 설정합니다.
        //YES로 설정된 경우 화면에서 유지될 경우 일정 시간 이후 다음 광고를 자동으로 내부에서 호출하여 갱신합니다.
        _bannerView.repeatLoop = NO;
        
        //광고가 없는 경우 노출할 백필 광고 뷰지정 (Optional)
        //_bannerView.backFillView = [self al_backFillView];
    }
    
    if (_bannerView.superview == nil) {
        [_bannerContainerView addSubview:_bannerView];
    }
    
    /**
     *  배너 광고를 요청한다.
     *  요청한 애드립 키값에 해당하는 띠배너 광고 플랫폼들에 대해서 순차적으로 광고를 요청하고 성공/실패 시 콜백을 호출한다.
     *
     *  @param key : 애드립 앱키
     *  @param rootViewController : 광고를 호출하는 뷰컨트롤러
     *  @param delegate : 광고 요청 및 수신 상태에 대한 델리게이트
     */
    
    //앱 업데이트시에는 발급받으신 키로 교체하세요.
    NSString *appKey = kTEST_KEY_ADLIBHOUSE;
    
    [_bannerView startAdViewWithKey:appKey
                 rootViewController:self
                         adDelegate:self];
    
}

- (void)stopAdlibAdvert
{
    [_bannerView stopAdView];
}

- (IBAction)requestIntersAd:(id)sender
{
    ALInterstitialAd *interstitialAd = [[ALInterstitialAd alloc] initWithRootViewController:self];
    self.interstitialAd = interstitialAd;
    
    interstitialAd.isTestMode = YES;
    
    //앱 업데이트시에는 발급받으신 키로 교체하세요.
    NSString *appKey = kTEST_KEY_ADLIBHOUSE;
    
    [_interstitialAd requestAdWithKey:appKey adDelegate:self];
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
- (void)alAdBannerView:(ALAdBannerView *)bannerView didChangeState:(ALMEDIATION_STATE)state withExtraInfo:(id)info
{
    NSLog(@"bannerView state : %@, info = %@", [ALMediationDefine descriptionOfState:state], info);
    //로그성 코드 처리 부분입니다.
}

/**
 *  플랫폼에 요청한 띠배너 광고의 성공 상태를 반환합니다.
 */
- (void)alAdBannerView:(ALAdBannerView *)bannerView didReceivedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"bannerView receivedAd : %@", [ALMediationDefine nameOfPlatform:platform]);
    //로그성 코드 처리 부분입니다.
}

/**
 *  플랫폼에 요청한 띠배너 광고의 실패 상태를 반환합니다.
 */
- (void)alAdBannerView:(ALAdBannerView *)bannerView didFailedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"bannerView failedAd : %@", [ALMediationDefine nameOfPlatform:platform]);
    //로그성 코드 처리 부분입니다.
    
}

/**
 *  플랫폼에 요청한 띠배너 광고의 실패 상태를 반환합니다.
 *  반환값 BackFill 뷰 사용여부, 모든 플랫폼 광고요청이 실패한 경우 노출할 뷰를 지정하여 사용할 수 있습니다.
 */
- (BOOL)alAdBannerViewDidFailedAtAllPlatform:(ALAdBannerView *)bannerView
{
    NSLog(@"bannerView failed all-platform");
    
    //해당 델리게이트에서 애드립 플랫폼에 등록된 광고의 모두 실패 상태를 처리할 수 있습니다.
    //등록된 플랫폼 스케쥴이 (애드립, 애드몹, 애드핏)인 경우 각 각 요청 후 모두 실패한 케이스의 상황
    //해당 상황에 특별한 처리를 하지 않으면 광고 영역이 공백으로 노출될 수 있으며 뷰의 repeatLoop의 값에 따라
    //일정 시간 (초)대기후 첫 플랫폼 부터 재호출 되거나 요청이 더이상 발생하지 않는 상태로 남아있다.

    return YES;
}

#pragma mark - Optional Methods.

- (UIView *)al_backFillView
{
    //애드립에서 제공하는 백필뷰 탬플릿으로 해당 뷰이외에 매체사에서 제작한 뷰를 넘겨주는 것도 가능하다.
    //애드립 백필의 경우 최하단에 배경 이미지 뷰 그 상단에 웹뷰로 구성되며 아래 세터 함수를 호출하지 않을 경우 기본 hidden상태이다.
    ALAdBackFillView *backFillView = [[ALAdBackFillView alloc] initWithFrame:_bannerContainerView.bounds];
    
    //배경 이미지 지정
    UIImage *bgimg = nil;
    [backFillView setBackgroundImage:bgimg];
    
    //띠배너 영역에 표시할 웹페이지 주소
    //개발사에서 해당 페이지의 html소스 내용을 유동적으로 바꾸어 관리할수 있다.
    NSURL *url = [NSURL URLWithString:@"http://----"];
    [backFillView loadBackFillUrl:url];
    
    return backFillView;
}

@end
