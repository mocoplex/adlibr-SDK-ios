//
//  CS003.m
//  ADLibSample
//
//  Created by gskang on 2017. 3. 31..
//
//

#import "CS003.h"
#import "SampleKey.h"

#import <Adlib/ADLibBanner.h>

//#import "ALAdapterMezzo.h"

@interface CS003 () <ALAdBannerViewDelegate>

@property (nonatomic, strong) IBOutlet ALAdBannerView *bannerView;

@end

@implementation CS003

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    //메조미디어 띠배너를 위한 미디에이션 설정 코드
    //애드립 대시보드 띠배너 플랫폼중 메조를 공식적으로 지원하지 않기때문에
    //현재 지원 중단된 uplusAd 슬롯을 사용한다.
    

#warning TODO -
    //프로젝트에 ALAdAapterMezzor.h 파일을 추가후 아래 주석을 제거해주세요. - ADLibAdapter폴더 밑에 존재
    //[ALMediation registerPlatform:ALMEDIATION_PLATFORM_UPLUSAD withClass:[ALAdapterMezzo class]];
    
    //메조미디어에서 발급받은  pid, mid, sid 등을 세팅
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:@"100" forKey:@"pid"];
    [userInfo setValue:@"200" forKey:@"mid"];
    [userInfo setValue:@"300" forKey:@"sid"];
    [userInfo setValue:@"mezzo_user" forKey:@"userId"];
    [userInfo setValue:@"mezzo_user" forKey:@"userEmail"];
    
    //미디에이션 플랫폼 띠배너 키설정
    //키값은 위 userInfo값을 사용하여 세팅하으로 nil값만 아닌 문자열을 넘겨주기만하면된다.
    [_bannerView setKey:@"100/200/300" forPlatform:ALMEDIATION_PLATFORM_UPLUSAD];
    [_bannerView setUserInfo:userInfo forPlatform:ALMEDIATION_PLATFORM_UPLUSAD];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadBannerView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopBannerView];
}

#pragma mark -  ALAdBannerView Code

- (void)loadBannerView
{
    _bannerView.isTestMode = YES;
    _bannerView.repeatLoop = YES;
    
    //스케쥴에 포함된 모든 플랫폼 띠배너 광고 수신에 실패한 경우 다음 요청까지의 대기시간
    _bannerView.repeatLoopWaitTime = 3;
    
    [_bannerView startAdViewWithKey:kADLIB_TEST_MEZZO
                 rootViewController:self
                         adDelegate:self];
}

- (void)stopBannerView
{
    [_bannerView stopAdView];
}

#pragma mark - Band

//ALAdBannerView 광고요청 재개 상태에서 내부적인 상태 변화를 통지합니다.
- (void)alAdBannerView:(ALAdBannerView *)bannerView didChangeState:(ALMEDIATION_STATE)state withExtraInfo:(id)info
{
    NSLog(@"bannerView state : %@, info = %@", [ALMediationDefine descriptionOfState:state], info);
}

//플랫폼에 요청한 광고의 성공 상태를 반환합니다.
- (void)alAdBannerView:(ALAdBannerView *)bannerView didReceivedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"bannerView receivedAd : %@", [ALMediationDefine nameOfPlatform:platform]);
}

//플랫폼에 요청한 광고의 실패 상태를 반환합니다.
- (void)alAdBannerView:(ALAdBannerView *)bannerView didFailedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"bannerView failedAd : %@", [ALMediationDefine nameOfPlatform:platform]);
}

- (BOOL)alAdBannerViewDidFailedAtAllPlatform:(ALAdBannerView *)bannerView
{
    NSLog(@"bannerView failed All Platform");
    
    return YES;
}

@end
