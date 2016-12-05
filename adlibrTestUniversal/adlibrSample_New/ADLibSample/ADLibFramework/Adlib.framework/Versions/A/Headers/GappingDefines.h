//
//  GappingType.h
//  Adlib
//
//  Created by Ryan Kim on 2016. 3. 7..
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GAPPING_AD_STATUS) { //컨텐츠 상태 정의 코드
    GAPPING_AD_STATUS_STARTED               = 1, //컨텐츠 재생 시작
    GAPPING_AD_STATUS_FINISHED              = 2, //컨텐츠 재생 완료
    GAPPING_AD_STATUS_TERMINATED            = 4, //컨텐츠 삭제 완료
};

typedef NS_ENUM(NSInteger, GAPPING_AD_EVENT) { //컨텐츠 이벤트 정의 코드
    GAPPING_AD_EVENT_CLICKED                = 1, //랜딩 이벤트
    GAPPING_AD_EVENT_CLOSED                 = 2, //닫기 버튼 이벤트
    GAPPING_AD_EVENT_CLEARED                = 3, //컨텐츠 내부 삭제 이벤트
    GAPPING_AD_EVENT_FORCED_CLOSE           = 4, //컨텐츠 외부 삭제 이벤트
};

typedef NS_ENUM(NSInteger, GappingADType) { // Gapping 광고 타입
    GappingADType_NONE = 0,
    GappingADType_FLOATING,
    GappingADType_BANNER,
    GappingADType_INTERSTITIAL,
    GappingADType_INTRO,
    GappingADType_SECTION,
    GappingADType_VIRTUAL,
    GappingADType_LIVE,
    GappingADType_LOADING,
    GappingADType_FIXED_BANNER,
    GappingADType_FIXED_LARGE_BANNER,
};

typedef NS_ENUM(NSInteger, GappingFloatingADAlign) { // 아이콘 광고 노출 위치
    
    GappingFloatingADAlignLEFT = 0, //default
    GappingFloatingADAlignRIGHT,
};

typedef NS_ENUM(NSInteger, GappingBannerADAlign) { // 배너 광고 노출 위치
    
    GappingBannerADAlignTop = 0, //default
    GappingBannerADAlignCenter,
    GappingBannerADAlignBottom,
};

typedef NS_ENUM(NSInteger, GappingVRADAlign) { // 가상광고 노출 위치
    GappingVRADAlignDefault = 0,
    GappingVRADAlignTopLeft = 1,
    GappingVRADAlignTopCenter,
    GappingVRADAlignTopRight,
    GappingVRADAlignMiddleLeft,
    GappingVRADAlignMiddleCenter,
    GappingVRADAlignMiddleRight,
    GappingVRADAlignBottomLeft,
    GappingVRADAlignBottomCenter,
    GappingVRADAlignBottomRight,
};


#define kFloatingAdMarginOffsetFromLeftSide 0.3
#define kFloatingAdMarginOffsetFromBottomSide 0.3

#define kFloatingAdMarginOffsetMin 0.0
#define kFloatingAdMarginOffsetMax 1.0

#define kFloatingAdContentDefaultRatio 1.5
#define kFloatingAdContentMinRatio 0.7
#define kFloatingAdContentMaxRatio 3.0


@interface GappingDefines : NSObject

@end

