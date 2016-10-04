//
//  ALAdapterTad.m
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 10. 4..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import "ALAdapterTad.h"
#import "TadCore.h"

/*
 * confirmed compatible with T-ad SDK 3.3.5.6
 */


// TAD의 APP 아이디를 설정합니다.
#define TAD_ID @"IXT002001"                 //띠배너 테스트 ID - 고정값
#define TAD_INTERSTITIAL_ID @"IXT003001"    //전면배너 테스트 ID - 고정값


/**
 *   !!! 주의
 *  해당클래스의 작성 시점에 T AD 띠배너가 수신 되지않고 있어 띠배너의 노출 테스트가 완벽하게 되지 않은 버전입니다.
 *  전면광고의 경우 정상적으로 노출 테스트 완료 된 버전입니다.
 */

@interface ALAdapterTad () <TadDelegate>

@property (nonatomic, strong) TadCore *tadCore;
@property (nonatomic, strong) TadCore *interstitial;

@end


@implementation ALAdapterTad

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mediationPlatform = ALMEDIATION_PLATFORM_TAD;
    }
    return self;
}

- (TadCore *)tadCore
{
    if (_tadCore == nil) {
        
        TadCore *ad = [[TadCore alloc] initWithSeedView:self.bannerContainerView
                                               delegate:self];
        _tadCore = ad;
        
        [ad setSlotNo:TadSlotInline];
        
        // 상용서버를 사용 할지 테스트서버를 사용 할지 결정해준다.
        [ad setIsTest:YES];
        
        [ad setSeedViewController:self.rootViewController]; // 광고가 표시되는 ViewController를 전달
        
        // 선택 셋팅 사항
        //CGPoint offset = [self getTadOffSet];
        //[ad setOffset:offset];  // 광고의 오프셋을 결정한다. (Default 0.0)
        
        [ad setAutoRefersh:NO];
        [ad setIsMediation:YES];
        [ad setLogMode:NO];               // 로그를 보여줄지 아닐지 결정 (Default : NO)
        [ad setUseBackFillColor:YES];

    }
    
    return _tadCore;
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
    UIView *mview =  [self.tadCore getMediationView];
    
    //이시점에서는 nil을 반환하여 미리 그리는 작업이 수행되지 않습니다.
    //실제 광고 호출하는 시점에 미디에이션 뷰가 생성되어 반환됩니다.
    
    return mview;
}

- (UIView *)mediationBannerAdRequest:(UIViewController*)viewController withKey:(NSString *)key
{
    if (key == nil) {
        [self mediationBannerAdFailedAd];
        return nil;
    }
    
    [self.tadCore setClientID:key];
    
    [_tadCore viewWillAppear:NO];
    [_tadCore getAdvertisement];
    
    UIView *mview =  [self.tadCore getMediationView];
    return mview;
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
    
    if (self.interstitial) {
        [self.interstitial destroyAd];
        self.interstitial.delegate = nil;
        self.interstitial = nil;
    }
    
    TadCore *interstitial = [[TadCore alloc] initWithSeedView:self.rootViewController.view delegate:self];
    self.interstitial = interstitial;
    
    //필수 사항
    [interstitial setClientID:key];                             // 클라이언트 아이디
    [interstitial setSlotNo:TadSlotInterstitial];               // 슬롯 설정
    [interstitial setSeedViewController:self.rootViewController];
    
    // 선택 셋팅 사항
    [interstitial setIsTest:YES];                               // YES : 테스트 서버, NO : 상용 서버 (Default : YES)
    [interstitial setOffset:CGPointMake(0.0f, 0.0f)];          // 광고의 오프셋을 결정한다. (Default 0.0)
    [interstitial setAutoCloseWhenNoInteraction:NO];           // 전면광고 5초 후 자동 닫힘.
    [interstitial setAutoCloseAfterLeaveApplication:NO];       // 전면광고 랜딩 후 광고 닫힘.
    [interstitial setLogMode:NO];                              // 로그를 보여줄지 아닐지 결정 (Default : NO)
    [interstitial getAdvertisement];
    
    return YES;
}

#pragma mark - TadDelegate

- (void)tadOnAdLoaded:(TadCore *)tadCore
{
    if (tadCore == self.interstitial) {
        
        if (self.interstitial.canLoadInterstitial) {
            
            // 전면광고 성공을 알린다.
            [self mediationInterstitialAdReceived];
            [self.interstitial showAd];
            
        } else {
            
            // 전면광고 실패를 알린다.
            [self mediationInterstitialAdFailedAd];
        }
        
    } else if (tadCore == self.tadCore) {
        
        // 화면에 광고를 보여줍니다.
        [self mediationBannerAdReceivedWithView:[tadCore getMediationView]];
    }
}

- (void)tadCore:(TadCore *)tadCore tadOnAdFailed:(TadErrorCode)errorCode {
    
    if (tadCore == self.interstitial) {
        
        NSLog(@"tadCore interstitial adFailed:%zd", errorCode);
        
        // 전면광고 실패를 알린다.
        [self mediationInterstitialAdFailedAd];
        
    } else if (tadCore == self.tadCore) {
       
        NSLog(@"tadCore banner adFailed:%zd", errorCode);
        
        // 광고 수신에 실패 처리를 요청합니다.
        [self mediationBannerAdFailedAd];
    }
}

- (void)tadOnAdClicked:(TadCore *)tadCore {
    
    //NSLog(@"<Tad> 광고 클릭");
    //광고 클릭 이벤트를 리포팅
    
    if (tadCore == self.interstitial) {
        
        [self mediationInterstitialAdReportClickEvent];
        
    } else if (tadCore == self.tadCore) {
        
        [self mediationBannerReportClickEvent];
    }
}

@end
