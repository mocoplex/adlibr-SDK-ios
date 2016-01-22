//
//  GappingLoader.h
//  Gapping
//
//  Created by Ryan on 2016. 01. 20..
//  Copyright © 2016년 Gapping. All rights reserved.
//
//  Version 2.0
//  Build 2016. 01. 20

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GappingIconADAlign){
    
    GappingIconAdAlignLEFT = 0, //default
    GappingIconAdAlignRIGHT,
};
typedef NS_ENUM(NSInteger, GappingADType){
    GappingADType_NONE = 0,
    GappingADType_ICON,
    GappingADType_BANNER,
    GappingADType_INTERSTITIAL,
    GappingADType_INTRO,
    GappingADType_SECTION,
    GappingADType_VIRTUAL,
};
typedef NS_ENUM(NSInteger, GappingDirectEvent){
    GappingDirectEvent_CLOSE = 0,
    GappingDirectEvent_ERROR,
};
@class GappingLoader;

@protocol GappingLoaderDelegate <NSObject>

@required
//광고 요청 성공 시
- (void)didReceivedAd:(GappingLoader *)loader;
//광고 요청 실패 시
- (void)didReceivedFailed:(GappingLoader *)loader withError:(NSError *)error;
@end


@interface GappingLoader : NSObject {
    
}

//기본적인 광고 요청/Delegate를 통해 광고 수신 성공/실패 여부 전달
-(void)loadAdWithType:(GappingADType)type withKey:(NSString *)key
             delegate:(id<GappingLoaderDelegate>)delegate;

//Icon 형 광고를 노출 하고자 하는 경우 사용
-(void)loadIconAdWithAlign:(GappingIconADAlign)align withKey:(NSString *)key
                  delegate:(id<GappingLoaderDelegate>)delegate;

//광고 뷰 적재
- (BOOL)attachAdViewToMainWindow; // 권장
//화면 특정 영역에 광고를 넣고자 하는 경우 광고를 넣을 View를 지정해서 사용
- (BOOL)attachAdViewToView:(UIView *)containerView; //옵션

//3D 컨텐츠를 직접 사용하고자 하는 경우
-(void)directLoadGapping:(NSString *)path;
//광고 뷰 제거
- (void)detachAdView;

//뷰컨트롤러 화면 회전 시 광고 컨텐츠 영역 조정 요청
- (void)reloadContentForParentViewRotate;

//Background 진입 시 사용
+ (void) onPause;
//Foreground 진입 시 사용
+ (void) onResume;

//광고 타입 설정
@property (nonatomic) GappingADType adType;
//테스트 모드 사용 시
@property (nonatomic) BOOL isTestMode;
//가상 광고 테스트 모드 사용 시, 이 값을 설정하면 20초 단위로 노출
@property (nonatomic) BOOL isVRTestMode;

@end
