//
//  ALDynamicBanner.h
//  Adlib
//
//  Created by gskang on 2016. 11. 23..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALDynamicBannerState){
    
    ALDynamicBannerStateRequestStart        = -1000,        //요청 시작
    ALDynamicBannerStateReceivedAd          = -1001,        //광고 응답 성공
    ALDynamicBannerStateResponseEmptyAd     = -1002,        //광고 응답 실패 - 광고 없음
    
    ALDynamicBannerStateNetworkError        = -1003,        //요청 네트워크 에러
    ALDynamicBannerStateRequestFailed       = -1004,        //요청 실패
    ALDynamicBannerStateResponseFailed      = -1005,        //요청 응답 실패
    ALDynamicBannerStateNotFoundImageSource = -1006,        //광고 응답 실패 - 이미지 리소를 찾을 수 없음
    ALDynamicBannerStateADLibSessionError   = -1007,        //광고 요청 실패 - 세션 에러
    ALDynamicBannerStateNotFoundAdmSource   = -1008,        //광고 응답 실패 - 광고 소스 에러
    ALDynamicBannerStateInvalidKey          = -1009,        //광고 요청 실패 - 유효하지 않은 요청 키
    ALDynamicBannerStateSessionLinkError    = -1010,        //광고 요청 실패 - 세션 연결 실패
    ALDynamicBannerStateWebLoadFailed       = -1011,        //광고 요청 실패 - 웹 로딩 실패
    
    ALDynamicBannerStateEmptySchedule       = -1012,        //광고 요청 실패 - 애드립 스케쥴 사용시 스케쥴 미포함
    ALDynamicBannerStateInvalidSchedule     = -1013,        //광고 요청 실패 - 애드립 스케쥴 사용시 스케쥴 설정 오류
    
    ALDynamicBannerStateSetViewHidden       = 9998,         //광고뷰 속성 hidden YES로 변경되는 상태를 알림
    ALDynamicBannerStateSetViewVisible      = 9999,         //광고뷰 속성 hidden NO로 변경되는 상태를 알림
};


@class ALDynamicBanner;

@protocol ALDynamicBannerDelegate <NSObject>

- (void)alDynamicBannerDidReceivedAd:(ALDynamicBanner *)dynamicBanner;
- (void)alDynamicBanner:(ALDynamicBanner *)dynamicBanner didFailedAdWithState:(ALDynamicBannerState)state;

@end


@interface ALDynamicBanner : NSObject {
    
}

@property (nonatomic) BOOL isTestMode; //default : NO
@property (nonatomic, strong, readonly) NSError *internalError;


// 애드립 대시보드에서 사용하는 띠배너, 전면배너 스케쥴을 사용하여 광고 요청 우선순위를 지정합니다.
// 스케쥴상에 애드립과 애드립 하우스만을 지원합니다.
// 모두 포함되지 않은 경우 요청을 수행하지 않습니다.
@property (nonatomic) BOOL useAdlibSchedule; //default : NO

/**
 *  애드립 키값으로 초기화합니다.
 *  애드립 설정 세션 연결은 내부적으로 처리됩니다.
 */
- (id)initWithKey:(NSString *)key
      contentSize:(CGSize)size
         delegate:(id<ALDynamicBannerDelegate>)delegate;


// 띠 배너 요청
- (BOOL)loadRequestBanner;

// 전면 배너 요청
- (BOOL)loadRequestInterstitial;

// 광고 요청 취소
- (void)cancelAdRequest;


// 배너 뷰 화면에 노출 처리
- (void)attachToView:(UIView *)adContainerView;


// 배너 뷰 화면에서 제거 처리
- (void)detachFromContainerView;


// 배너 뷰의 프레임을 재조정할 필요가 있을 경우 호출
- (void)needLayoutSubviews:(CGRect)frame;


// 전면 배너를 모달뷰로 사용 시 노출 처리
- (void)presentAdWithParentViewController:(UIViewController *)ctr
                                 animated:(BOOL)animate;


+ (NSString *)logForBannerState:(ALDynamicBannerState)state;

@end
