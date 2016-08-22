//
//  ALAdapterCauly.m
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 8. 17..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import "ALAdapterCauly.h"
#import "Cauly.h"
#import "CaulyAdView.h"
#import "CaulyInterstitialAd.h"


/*
 * confirmed compatible with Caluy SDK 3.1
 */

@interface ALAdapterCauly () <CaulyAdViewDelegate, CaulyInterstitialAdDelegate>

@property (strong, nonatomic) CaulyAdView *adView;
@property (strong) CaulyInterstitialAd * caulyInterstitialAd;

@end


@implementation ALAdapterCauly

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.mediationPlatform = ALMEDIATION_PLATFORM_CAULY;
        
        CaulyAdSetting * adSetting = [CaulyAdSetting globalSetting];
        [CaulyAdSetting setLogLevel:CaulyLogLevelAll];              //  Cauly Log 레벨
    
        adSetting.animType              = CaulyAnimNone;            //  화면 전환 효과
        adSetting.useGPSInfo            = NO;                       //  GPS 수집 허용여부
        adSetting.adSize                = CaulyAdSize_IPhone;       //  광고 크기 (320, 50)
        adSetting.gender                = CaulyGender_All;          //  성별 설정
        adSetting.age                   = CaulyAge_All;             //  나이 설정
        adSetting.reloadTime            = CaulyReloadTime_120;      //  광고 갱신 시간
        adSetting.useDynamicReloadTime  = NO;                       //  동적 광고 갱신 허용 여부
        adSetting.closeOnLanding        = YES;                      // Landing 이동시 webview control lose 여부
    }
    return self;
}

- (CaulyAdView *)adView
{
    if (_adView == nil) {
        _adView = [[CaulyAdView alloc] initWithParentViewController:self.rootViewController];
    }
    
    return _adView;
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
    return self.adView;
}

- (UIView *)mediationBannerAdRequest:(UIViewController*)viewController withKey:(NSString *)key
{
    if (key == nil) {
        // 전면광고 실패를 알린다.
        [self mediationBannerAdFailedAd];
        return nil;
    }
    
    CaulyAdSetting * adSetting = [CaulyAdSetting globalSetting];
    adSetting.appCode = key;
    
    self.adView.delegate = self;
    [self.adView startBannerAdRequest];
    
    return self.adView;
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
    
    CaulyAdSetting * adSetting = [CaulyAdSetting globalSetting];
    adSetting.appCode = key;
    
    if(_caulyInterstitialAd)
        self.caulyInterstitialAd = nil;
    
    _caulyInterstitialAd = [[CaulyInterstitialAd alloc]
                            initWithParentViewController:self.rootViewController];  //  전면광고 객체 생성
    _caulyInterstitialAd.delegate = self;                                           //  전면 delegate 설정
    [_caulyInterstitialAd startInterstitialAdRequest];
    
    return YES;
}


#pragma - CaulyAdViewDelegate

// 광고 정보 수신 성공
- (void)didReceiveAd:(CaulyAdView *)adView isChargeableAd:(BOOL)isChargeableAd{
    
    NSLog(@"didReceiveAd");
    
    [_adView stopAdRequest];
    
    // 화면에 광고를 보여줍니다.
    [self mediationBannerAdReceivedWithView:adView];
}

// 광고 정보 수신 실패
- (void)didFailToReceiveAd:(CaulyAdView *)adView errorCode:(int)errorCode errorMsg:(NSString *)errorMsg {
    
    NSLog(@"didFailToReceiveAd : %d(%@)", errorCode, errorMsg);
    
    [_adView stopAdRequest];
    
    // 광고 수신에 실패 처리를 요청합니다.
    [self mediationBannerAdFailedAd];
}

// 랜딩 화면 표시
- (void)willShowLandingView:(CaulyAdView *)adView {
    NSLog(@"willShowLandingView");
    
    [self mediationBannerReportClickEvent];
}

// 랜딩 화면이 닫혔을 때
- (void)didCloseLandingView:(CaulyAdView *)adView {
    NSLog(@"didCloseLandingView");
}

#pragma - CaulyInterstitialAd

// 광고 정보 수신 성공
- (void)didReceiveInterstitialAd:(CaulyInterstitialAd *)interstitialAd isChargeableAd:(BOOL)isChargeableAd {
    NSLog(@"didReceiveInterstitialAd");
    
    // 전면광고 성공을 알린다.
    [self mediationInterstitialAdReceived];
    
    [_caulyInterstitialAd show];
    
}

// 광고 정보 수신 실패
- (void)didFailToReceiveInterstitialAd:(CaulyInterstitialAd *)interstitialAd errorCode:(int)errorCode errorMsg:(NSString *)errorMsg {
    NSLog(@"didFailToReceiveInterstitialAd : %d(%@)", errorCode, errorMsg);
    
    // 전면광고 실패를 알린다.
    [self mediationInterstitialAdFailedAd];
    
    self.caulyInterstitialAd = nil;
}

// Interstitial 형태의 광고가 닫혔을 때
- (void)didCloseInterstitialAd:(CaulyInterstitialAd *)interstitialAd {
    NSLog(@"didCloseInterstitialAd");
    
    // 전면광고 닫힘을 알린다.
    [self mediationInterstitialAdViewClosed];
    
    self.caulyInterstitialAd = nil;
}

// Interstitial 형태의 광고가 보여지기 직전
- (void)willShowInterstitialAd:(CaulyInterstitialAd *)interstitialAd {
    NSLog(@"willShowInterstitialAd");
    
    // 전면 광고 클릭 리포팅
    [self mediationInterstitialAdReportClickEvent];
}

@end
