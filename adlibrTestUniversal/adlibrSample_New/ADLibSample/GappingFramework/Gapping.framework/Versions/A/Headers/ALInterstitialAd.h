//
//  ALInterstitialAd.h
//  Adlib
//
//  Created by gskang on 2016. 4. 19..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>
#import "ALMediationDefine.h"

@class ALInterstitialAd;

@protocol ALInterstitialAdDelegate <NSObject> 

//해당 플랫폼 전면광고에 대한 수신성공
- (void)alInterstitialAd:(ALInterstitialAd *)interstitialAd didReceivedAdAtPlatform:(ALMEDIATION_PLATFORM)platform;

//해당 플랫폼 전면광고에 대한 수신실패
- (void)alInterstitialAd:(ALInterstitialAd *)interstitialAd didFailedAdAtPlatform:(ALMEDIATION_PLATFORM)platform;

//스케쥴링에 설정된 모든 플랫폼 전면광고에 대한 수신 실패
- (void)alInterstitialAdDidFailedAd:(ALInterstitialAd *)interstitialAd;

@optional
//해당 플랫폼 전면광고에 대한 클릭 이벤트 발생
- (void)alInterstitialAd:(ALInterstitialAd *)interstitialAd didClickedAdAtPlatform:(ALMEDIATION_PLATFORM)platform;

@end


@protocol ALInterstitialAdReportProtocol <NSObject>

- (void)alReportMediationPlatformDidFailedAd:(ALMEDIATION_PLATFORM)ptype;
- (void)alReportMediationPlatformDidReceivedAd:(ALMEDIATION_PLATFORM)ptype;
- (void)alReportMediationPlatformDidClosedController:(ALMEDIATION_PLATFORM)ptype;
- (void)alReportMediationPlatformAdClick:(ALMEDIATION_PLATFORM)ptype;

@end


/**
 *  해당 클래스를 사용하여 미디에이션 전면배너 기능을 사용할 수 있다.
 */
@interface ALInterstitialAd : NSObject <ALInterstitialAdReportProtocol> {
    
}

//테스트 모드 설정 값 (기본값 : NO)
@property (nonatomic) BOOL isTestMode;

@property (nonatomic, weak, readonly) UIViewController *rootViewController;


/**
 *  전면광고 요청 생성자 (Beta 버전)
 *
 *  @param rootViewController 전면광고 뷰컨트롤러를 노출한 루트뷰 컨트롤러
 */
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;


/**
 *  애드립외 미디에이션 광고플랫폼에서 발급받은 전면광고 호출에 필요한 키값을 세팅한다.
 *
 */
- (void)setKey:(NSString *)key forPlatform:(ALMEDIATION_PLATFORM)platform;


//플랫폼 광고에 필요한 부가정보 세팅
- (void)setUserInfo:(NSDictionary *)info forPlatform:(ALMEDIATION_PLATFORM)platform;
- (NSDictionary *)getUserInfoForPlatform:(ALMEDIATION_PLATFORM)platform;

/**
 *  젼면광고를 요청한다.
 *  요청한 애드립 키값에 해당하는 전면광고 플랫폼들에 대해서 순차적으로 광고를 요청하고 성공 시 콜백을 호출한다.
 *  모든 플랫폼광고에 전면광고 요청이 실패한경우 실패에 대한 콜백을 호출한다.
 *
 *  @param mediationKey 애드립 앱키 (미디에이션 설정정보를 갖는 키값)
 *  @param delegate 광고 요청 및 수신 상태에 대한 델리게이트
 */
- (BOOL)requestAdWithKey:(NSString *)mediationKey adDelegate:(id<ALInterstitialAdDelegate>)delegate;

/**
 *  전면광고 요청을 중단한다.
 */
- (void)stopAdReqeust;

@end
