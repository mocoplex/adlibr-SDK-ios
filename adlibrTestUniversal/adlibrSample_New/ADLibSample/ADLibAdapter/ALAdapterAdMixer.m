//
//  ALAdapterAdMixer.m
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 8. 18..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import "ALAdapterAdMixer.h"

#import "AdMixerInfo.h"
#import "AdMixerInterstitial.h"
#import "AdMixerView.h"

/*
 * confirmed compatible with admixer SDK 1.3.1
 */

#define kAdMixerBannerViewSize CGSizeMake(320, 50)

@interface ALAdapterAdMixer () <AdMixerViewDelegate, AdMixerInterstitialDelegate>

@property (nonatomic, strong) AdMixerView *adView;
@property (nonatomic, strong) AdMixerInterstitial *adMixerInters;

@end


@implementation ALAdapterAdMixer

+ (void)initializeAdMixer
{
    ///[AdMixer registerUserAdAdapterNameWithAppCode:AMA_ADAM cls:[AdamAdapter class] appCode:@"DAN-1hux8dwpvj581"];
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_ADAM cls:[AdamAdapter class] appCode:@"adam_app_code"];
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_ADMOB cls:[AdmobAdapter class] appCode:@"admob_app_code"];
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_ADMOB_ECPM cls:[AdmobECpmAdapter class] appCode:@"admob_app_code"
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_ADPOST cls:[AdpostAdapter class] appCode:@"adpost_app_code"];
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_CAULY cls:[CaulyAdapter class] appCode:@"cauly_app_code"];
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_SHALLWE cls:[ShallWeAdapter class] appCode:@”shall_app_code"];
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_TAD cls:[TAdAdapter class] appCode:@"tad_app_code"];
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_INMOBI cls:[InmobiAdapter class] appCode:@”inmobi_app_code"];
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_IAD cls:[IAdAdapter class] appCode:@”iad_app_code"];
    //    [AdMixer registerUserAdAdapterNameWithAppCode:AMA_FACEBOOK cls:[FacebookAdapter class] appCode:@”facebook_app_code"];
    
    //[AdMixer setLogLevel:AXLogLevelDebug]; // 로그 레벨 설정
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mediationPlatform = ALMEDIATION_PLATFORM_ADMIXER;
    }
    return self;
}

- (AdMixerView *)adView
{
    if (_adView == nil) {
        
        AdMixerView *adView = [[AdMixerView alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            kAdMixerBannerViewSize.width,
                                                                            kAdMixerBannerViewSize.height)];
        _adView = adView;
        _adView.delegate = self;
        _adView.adSize = AXBannerSize_Default; // 배너 크기 요청 조절
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
    
    AdMixerInfo *adMixerInfo = [[AdMixerInfo alloc] init];
    adMixerInfo.axKey = key;
    
    // 고수익 배너 상/하단 여백 처리 방식 지정(AdMixerRTBVAlignTop, AdMixerRTBVAlignCenter, AdMixerRTBVAlignBottom)
    adMixerInfo.rtbVerticalAlign = AdMixerRTBVAlignBottom;
    
    // 디폴트 광고 유지 시간(초단위로 지정한 시간 이후 광고 로딩)
    adMixerInfo.defaultAdTime = 0;
    
    [self.adView startWithAdInfo:adMixerInfo baseViewController:self.rootViewController];
    
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
    
    AdMixerInfo * adInfo = [[AdMixerInfo alloc] init];
    adInfo.axKey = key;
    
    AdMixerInterstitial * interstitial = [[AdMixerInterstitial alloc] init];
    self.adMixerInters = interstitial;
    interstitial.delegate = self;
    [interstitial startWithAdInfo:adInfo baseViewController:viewController];
    
    return YES;
}


#pragma mark -

- (void)onSucceededToReceiveAd:(AdMixerView *)adView
{
    NSLog(@"onSucceededToReceiveAd");
    
    // 화면에 광고를 보여줍니다.
    [self mediationBannerAdReceivedWithView:adView];
}

- (void)onFailedToReceiveAd:(AdMixerView *)adView error:(AXError *)error;
{
    NSLog(@"onFailedToReceiveAd : %@", error.errorMsg);
    
    // 광고 수신에 실패 처리를 요청합니다.
    [self mediationBannerAdFailedAd];
}

#pragma mark - AdmixerInterstitial Delegate

- (void)onSucceededToReceiveInterstitalAd:(AdMixerInterstitial *)intersitial
{
    // 전면광고 성공을 알린다.
    [self mediationInterstitialAdReceived];
}

- (void)onFailedToReceiveInterstitialAd:(AdMixerInterstitial *)intersitial error:(AXError *)error
{
    // 전면광고 실패를 알린다.
    [self mediationInterstitialAdFailedAd];
    
    self.adMixerInters = nil;
}

- (void)onClosedInterstitialAd:(AdMixerInterstitial *)intersitial
{
    // 전면광고 닫힘을 알린다.
    [self mediationInterstitialAdViewClosed];
    
    self.adMixerInters = nil;
}

@end
