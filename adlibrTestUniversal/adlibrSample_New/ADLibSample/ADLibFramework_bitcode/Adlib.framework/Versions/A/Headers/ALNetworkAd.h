//
//  ALNetworkAd.h
//  Adlib
//
//  Created by gskang on 2017. 5. 12..
//  Copyright © 2017년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALNetworkAdResCode) {
    
    ALNetworkAdResCodeReceivedAd = 0,     //광고 응답 성공
    ALNetworkAdResCodeEmptyAd = 9000,     //광고 응답 실패 - 광고 없음
    
    ALNetworkAdResCodeInvalidKey,         //요청 매체키 에러
    ALNetworkAdResCodeADLibSessionError,  //애드립 세션연결 실패 에러
    ALNetworkAdResCodeAPIError,           //요청 API 서버 에러
    ALNetworkAdResCodeNetworkError,       //요청 네트워크 에러
    ALNetworkAdResCodeInvalidSchedule,    //매체키 스케쥴 설정오류
};

typedef NS_ENUM(NSInteger, ALNetworkAdImageDrawMode) {
    
    ALNetworkAdImageDrawModeScaleToFill = 0,    // ScaleToFill : 기본값
    ALNetworkAdImageDrawModeScaleAspectFit,     // ScaleAspectFit
    ALNetworkAdImageDrawModeScaleAspectFill,    // ScaleAspectFill
    ALNetworkAdImageDrawModeScaleRatioCenter,   // 중앙에 이미지 비율에 맞추어 정렬 및 여백 배경색상처리 (웹뷰광고 드로잉방식과 동일)
};

@class ALNetworkAd;

@protocol ALNetworkAdDelegate <NSObject>

- (void)alNetworkAdDidReceivedAd:(ALNetworkAd *)networkAd;
- (void)alNetworkAd:(ALNetworkAd *)networkAd didFailedAdWithState:(ALNetworkAdResCode)state;

@end


@interface ALNetworkAd : NSObject {
    
}

@property (nonatomic, readonly) BOOL isLoaded;

@property (nonatomic) BOOL isTestMode;  //default : NO

// 애드립 대시보드에서 사용하는 띠배너, 전면배너 스케쥴을 사용하여 광고 요청 우선순위를 지정합니다.
// 스케쥴상에 애드립과 애드립 하우스만을 지원합니다.
// 모두 포함되지 않은 경우 요청을 수행하지 않습니다.
@property (nonatomic) BOOL useAdlibSchedule; //default : NO


/**
 *  애드립 키값으로 초기화합니다.
 *  애드립 설정 세션 연결은 내부적으로 처리됩니다.
 *
 *  @param key 애드립에서 발급 받은 매체키
 *  @param delegate 광고 상태처리 Delegate
 */
- (id)initWithKey:(NSString *)key
         delegate:(id<ALNetworkAdDelegate>)delegate;


// 전면 배너 요청 - 320*480비율 소재의 전면광고 요청
- (BOOL)loadRequestInterstitial;

// 광고 요청 취소
- (void)cancelAdRequest;

/**
 *  배너 뷰 화면에 노출 처리
 *
 *  @param adContainerView 광고뷰를 적재할 superView
 *  @param frame 광고 컨테이너뷰 내부에서 위치할 광고뷰 프레임
 */
- (BOOL)attachToView:(UIView *)adContainerView withFrame:(CGRect)frame;

// 배너 뷰 화면에서 제거 처리
- (void)detachFromContainerView;

/**
 *  배너 뷰의 프레임을 재조정할 필요가 있을 경우 호출
 *
 *  @param frame 광고 컨테이너뷰 내부에서 위치를 조정할 광고뷰 프레임
 */
- (void)needLayoutSubviews:(CGRect)frame;

// 광고 컨텐츠 로딩 시작
- (BOOL)loadContents;

// 광고 컨텐츠 로딩 중지
- (void)stopLoadingContents;

// 인앱 브라우저를 사용할경우 클릭 이벤트 처리 등록 (옵션 - 등록하지 않은 경우 내부에서 사파리 랜딩 처리)
- (void)registerClickEventBlock:(void (^)(NSURL *landingUrl))block;

// 상태코드 메세지
+ (NSString *)logForResultCode:(ALNetworkAdResCode)state;


/**
 *  이미지광고를 노출할 경우에 사용되는 이미지뷰의 속성 값을 매체사에서 지정할 수 있도록 제공함.
 *  단, 웹뷰를 사용하는 웹광고 소재의 경우 별도의 html 광고소재 태그에 따라감.
 */

// 이미지 광고 소재 컨텐츠 모드 (기본값 : UIViewContentModeScaleToFill)
+ (void)setupNetworkAdViewImageDrawMode:(ALNetworkAdImageDrawMode)mode;

// 이미지 광고 클릭시 Dim 뷰의 알파 값 설정 전역 메소드 (0.0 <= v <=0.5, 기본값 : 0.2)
+ (void)setupNetworkAdViewDimAlphaValue:(CGFloat)value;

@end
