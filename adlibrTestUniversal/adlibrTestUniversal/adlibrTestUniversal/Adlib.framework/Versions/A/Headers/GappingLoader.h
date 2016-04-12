//
//  GappingLoader.h
//  Gapping
//
//  Created by Ryan on 2016. 01. 20..
//  Copyright © 2016년 Gapping. All rights reserved.
//
//  Version 2.4.0
//  Build 2016. 04. 05
//  Recently modified 2016.04.05

#import <UIKit/UIKit.h>
#import "GappingDefines.h"

@class GappingLoader;

@protocol GappingLoaderDelegate <NSObject>
@optional
// 매체 App 내에서 광고 컨텐츠에서 발생한 interaction을 수신 하고자 하는 경우 사용
- (void) didReceiveInteraction:(NSString *)data;
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

//VR 광고 시 광고 노출 영역을 설정하여 광고를 노출하는 경우 사용
//enableTimer : 가상광고를 반복적으로 노출 설정 값
-(void)loadVRAdWithAlign:(GappingVRADAlign)align withKey:(NSString *)key
                delegate:(id<GappingLoaderDelegate>)delegate enableTimer:(BOOL)enable;

//Banner 광고 시 광고 노출 영역을 설정하여 광고를 노출하는 경우 사용
-(void)loadBannerAdWithAlign:(GappingBannerADAlign)align withKey:(NSString *)key
                delegate:(id<GappingLoaderDelegate>)delegate;

//광고 뷰 적재
- (BOOL)attachAdViewToMainWindow; // 권장
//화면 특정 영역에 광고를 넣고자 하는 경우 광고를 넣을 View를 지정해서 사용
- (BOOL)attachAdViewToView:(UIView *)containerView; //옵션


-(void)enableSoundButton:(BOOL)enable;
-(void)enableReplayButton:(BOOL)enable;
-(void)enableCloseButton:(BOOL)enable;

//광고 뷰 제거
-(void)detachAdView;

//뷰컨트롤러 화면 회전 시 광고 컨텐츠 영역 조정 요청
-(void)reloadContentForParentViewRotate;

-(void)isHouseAD:(BOOL)isHouse;

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
