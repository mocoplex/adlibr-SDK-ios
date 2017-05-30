//
//  ALAdBannerView.h
//  Adlib
//
//  Created by gskang on 2016. 4. 19..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALMediationDefine.h"

@class ALAdBannerView;

@protocol ALAdBannerViewDelegate <NSObject>

//ALAdBannerView 광고요청 재개 상태에서 내부적인 상태 변화를 통지합니다.
- (void)alAdBannerView:(ALAdBannerView *)bannerView didChangeState:(ALMEDIATION_STATE)state withExtraInfo:(id)info;

//플랫폼에 요청한 광고의 성공 상태를 반환합니다.
- (void)alAdBannerView:(ALAdBannerView *)bannerView didReceivedAdAtPlatform:(ALMEDIATION_PLATFORM)platform;

//플랫폼에 요청한 광고의 실패 상태를 반환합니다.
- (void)alAdBannerView:(ALAdBannerView *)bannerView didFailedAdAtPlatform:(ALMEDIATION_PLATFORM)platform;

//등록된 모든 플랫폼 광고의 실패 상태를 반환합니다.
- (BOOL)alAdBannerViewDidFailedAtAllPlatform:(ALAdBannerView *)bannerView;

@end


@protocol ALAdBannerViewReportProtocol <NSObject>

- (void)alReportMediationPlatformDidReceivedAd:(ALMEDIATION_PLATFORM)ptype withView:(UIView *)adView;
- (void)alReportMediationPlatformDidFailedAd:(ALMEDIATION_PLATFORM)ptype;

- (void)alReportMediationPlatformAdClick:(ALMEDIATION_PLATFORM)ptype;

@end


typedef NS_ENUM(NSInteger, AL_ADVIEW_VERTICAL_ALIGN) {
    AL_ADVIEW_VERTICAL_ALIGN_BOTTOM = 0, //DEFAULT
    AL_ADVIEW_VERTICAL_ALIGN_TOP,
};

/**
 *  해당 클래스를 사용하여 미디에이션 띠배너 기능을 사용할 수 있다. 
 *  Beta 버전
 */

@interface ALAdBannerView : UIView  <ALAdBannerViewReportProtocol> {
    
}

@property (nonatomic) AL_ADVIEW_VERTICAL_ALIGN verticalAlign;

//테스트 모드 설정 값 (기본값 : NO)
@property (nonatomic) BOOL isTestMode;

// 설정된 배너 플랫폼의 요청이 한바퀴 완료된 후 처음부터 재시작할지 여부,
// 기본값 : NO (값이 NO일 경우 마지막 수신한 광고 뷰가 유지된다.)
@property (nonatomic) BOOL repeatLoop;

// 모든 스케쥴 광고가 실패한 이후 다음 루프까지의 대기 시간
// 기본 설정 값 10초 (설정 가능 범위 값 1~120초)
@property (nonatomic) NSUInteger repeatLoopWaitTime;

// 미디에이션 플랫폼 모두 실패한 경우에 대한 백필뷰
@property (nonatomic, strong) UIView *backFillView;


- (void)setKey:(NSString *)key forPlatform:(ALMEDIATION_PLATFORM)platform;


//플랫폼 광고에 필요한 부가정보 세팅
- (void)setUserInfo:(NSDictionary *)info forPlatform:(ALMEDIATION_PLATFORM)platform;
- (NSDictionary *)getUserInfoForPlatform:(ALMEDIATION_PLATFORM)platform;

/**
 *  배너 광고를 요청한다.
 *  요청한 애드립 키값에 해당하는 띠배너 광고 플랫폼들에 대해서 순차적으로 광고를 요청하고 성공/실패 시 콜백을 호출한다.
 *
 *  @param mediationKey 애드립 앱키 (미디에이션 설정정보를 갖는 키값)
 *  @param delegate 광고 요청 및 수신 상태에 대한 델리게이트
 */
- (BOOL)startAdViewWithKey:(NSString *)mediationKey
        rootViewController:(UIViewController *)rootViewController
                adDelegate:(id<ALAdBannerViewDelegate>)delegate;

/**
 *  전면광고 요청을 중단한다.
 */
- (void)stopAdView;

@end


