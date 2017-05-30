//
//  ALDynamicBannerView.h
//  Adlib
//
//  Created by gskang on 2015. 10. 6..
//  Copyright © 2015년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADLibSession.h"
#import "ALDynamicBanner.h"

// 다이나믹 사이즈 광고 뷰 (이미지 광고만 지원)
//
// 업로드 가능 이미지 사이즈 500K
// ex : 600x600 사이즈 이미지 업로드시
// SDK 광고 이미지는 300x300 크기로 사용 (서버 이미지는 @2x 기준)
//

@class ALDynamicBannerView;

@protocol ALDynamicBannerViewDelegate <NSObject>

@optional
- (void)alDynamicBannerView:(ALDynamicBannerView *)bannerView
       didChangeBannerState:(ALDynamicBannerState)state;

@end


@interface ALDynamicBannerView : UIView {
    
}

@property (nonatomic, weak) id <ALDynamicBannerViewDelegate> delegate;

@property (nonatomic, strong) UIColor *bannerBackgroundColor;

//광고 이미지의 contentMode 설정
//기본 값 : UIViewContentModeScaleAspectFit
@property (nonatomic) UIViewContentMode imageContentMode;

//광고 소재 이미지 재사용 여부
//기본 값 : YES
@property (nonatomic) BOOL useImageCache;


@property (nonatomic, weak) ALDynamicBanner *dynamicBanner;


//자동 갱신 시간
//기본 값 : 0 (0으로 지정시 자동 갱신 없음)
//최소 값 : 3 초
@property (nonatomic) NSTimeInterval refreshTimeinterval;

//네트워크 에러
@property (nonatomic, strong, readonly) NSError *error;

//하우스 모드 설정 값 (기본값 : NO)
@property (nonatomic) BOOL isHouseMode;

// 띠배너 타입으로 요청
- (void)startBannerRequestWithAdlibKey:(NSString *)key
                            bannerSize:(CGSize)bannerSize;

// 전면배너 타입으로 요청
- (void)startInterstitialRequestWithAdlibKey:(NSString *)key
                                  bannerSize:(CGSize)bannerSize;

/**
 *  광고 요청 중지 메소드
 */
- (void)stopAdRequest;


/**
 *  광고 요청 상태 블록 함수 등록 메소드
 */

- (void)setRequestAdStateHandler:(void (^)(ALDynamicBannerState state))handler;

// 배너를 화면에 노출하는 시점에 노출 보고를 위해 호출 필요
- (void)attachBannerViewForImpression;

/**
 *  Error Log 출력 설정
 */
+ (void)setLogging:(BOOL)logging;

+ (UIImage *)closeButtonImage;

@end
