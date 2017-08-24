//
//  ALAdapterMezzo.m
//  AdlibNativeADSample
//
//  Created by gskang on 2017. 3. 30..
//  Copyright © 2017년 gskang. All rights reserved.
//

#import "ALAdapterMezzo.h"
#import "ADBanner.h"

@interface ALAdapterMezzo () <ADBannerDelegate>

@property (nonatomic, strong) ADBanner *adView;

@end


@implementation ALAdapterMezzo

- (instancetype)init
{
    self = [super init];
    if (self) {
        //메조 SDK의 경우 현재 애드립 대시보드상에 띠배너 스케쥴로 정식 추가되지 않아
        //지원이 중단된 uplusAD 플랫폼 코드를 사용한다.
        self.mediationPlatform = ALMEDIATION_PLATFORM_UPLUSAD;
    }
    return self;
}

- (UIView *)adView
{
    if (_adView == nil) {
        
        _adView = [[ADBanner alloc] initWithFrame:CGRectMake(0,
                                                             0,
                                                             self.bannerContainerView.frame.size.width,
                                                             _adView.frame.size.height)];
        
        _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _adView.delegate = self;
        
        [_adView useGotoSafari:NO];
        [_adView useReachMedia:NO];
        
        NSDictionary *userInfo = [self.bannerContainerView getUserInfoForPlatform:self.mediationPlatform];
        if (userInfo) {
            NSString *pid = [userInfo objectForKey:@"pid"];
            NSString *mid = [userInfo objectForKey:@"mid"];
            NSString *sid = [userInfo objectForKey:@"sid"];
            
            //이 아래는 부가정보 세팅
            if (pid && mid && sid) {
                [_adView publisherID:pid mediaID:mid sectionID:sid];
            }
            NSString *userId = [userInfo objectForKey:@"userId"];
            if (userInfo) {
                [_adView setUserId:userId];
            }
            
            NSString *userEmail = [userInfo objectForKey:@"userEmail"];
            if (userEmail) {
                [_adView setUserEmail:userEmail];
            }
        }
    }
    
    return _adView;
}


/**
 *  띠배너 미디에이션 관련 구현 코드
 */

#pragma mark - mediation Banner protocol

- (void)removeBannerViewFromSuperview
{
    
}

- (BOOL)resizedAdViewWithBounds:(CGRect)adViewBounds
{
    //해당 광고뷰를 담는 부모뷰의 bounds내에서 프레임을 설정할 수 있다.
    //광고뷰의 프레임을 직접할경우 프레임 변경후 YES 리턴하도록 변경한다.
    //NO일 경우 애드립 SDK에서 프레임 조정
    return NO;
}

- (UIView *)platformAdView
{
    return self.adView;
}

- (UIView *)mediationBannerAdRequest:(UIViewController*)viewController withKey:(NSString *)key
{
    if (key == nil) {
        // 전면광고 실패를 알린다.
        [self mediationBannerAdFailedAd];
        return nil;
    }
    
    //보통은 뷰컨트롤러에서 세팅한 KEY 값하나로 처리되지만
    //메조의 경우 pid,mid,sid가 필요함으로 userInfo 딕셔너리에 해당 정보를 세팅하고
    //뷰 초기화 과정에서 설정합니다. 따라서 전달되는 key은 세팅은 필요하지만 사용하지는 않게됩니다.
    //key는 보통 애드몹 배너ID 처럼 광고 호출에 필요한 단일 문자열값을 의미합니다.
    
    [_adView startBannerAd];
    
    return _adView;
}

#pragma mark - Mezzo ADBannerDelegate

- (void)adBannerParsingEnd:(ADBanner*)adBanner {
    // 배너광고 파싱 완료
    NSLog(@"[ALAdapterMezzo] =============== adBannerParsingEnd");
}


- (void)didReceiveAd:(ADBanner*)adBanner chargedAdType:(BOOL)bChargedAdType {
    // 배너 광고의 수신 성공 및 유료/무료
    NSString *chargedAdType = nil;
    if (bChargedAdType) {
        chargedAdType = @"유료";
    } else {
        chargedAdType = @"무료";
    }
    NSLog(@"[ALAdapterMezzo] =========== didReceiveAd : %@", chargedAdType);
    
    // 화면에 광고를 보여줍니다.
    [self mediationBannerAdReceivedWithView:adBanner];
    
}

- (void)didFailReceiveAd:(ADBanner*)adBanner errorType:(NSInteger)errorType {
    
    // 배너 광고 수신 실패
    // errorTyped은 ManAdDefine.h 참조
    NSLog(@"[ALAdapterMezzo] =========== didFailReceiveAd : %ld", (long)errorType);
    
    // 다음 플랫폼으로 넘어가기 위해 광고 자동 요청 중단
    [adBanner stopBannerAd];
    
    // 광고 수신에 실패 처리를 요청합니다.
    [self mediationBannerAdFailedAd];
}


- (void)adBannerClick:(ADBanner*)adBanner {
    // 배너 광고 클릭
    NSLog(@"[ALAdapterMezzo] =============== adBannerClick");
}

- (void)didCloseRandingPage:(ADBanner*)adBanner {
    
    // 배너광고 클릭시 나타났던 랜딩 페이지 닫힐 경우
    NSLog(@"[ALAdapterMezzo] =========== didCloseRandingPage");
}

// 지정된 주기 이내에 광고리로드가 발생됨
- (void)didBlockReloadAd:(ADBanner*)adBanner {
    
    NSLog(@"[ALAdapterMezzo] =========== didBlockReloadAd");
}


/**
 *  전면배너 미디에이션 관련 구현 코드
 *
 *  애드립 미디에이션에서 메조미디어 플랫폼의 전면광고는 지원하지 않습니다.
 *  외부 코드에서 호출 시 실패를 바로 반환하여 다음 플랫폼 광고를 요청하도록합니다.
 */
#pragma mark - mediation Interstitial protocol

// 해당 플래폼 광고에 전면광고 요청을 처리합니다.
- (BOOL)mediationInterstitialAdReqeust:(UIViewController*)viewController withKey:(NSString *)key
{
    // 전면광고 실패를 알린다.
    [self mediationInterstitialAdFailedAd];
    
    return YES;
}

@end
