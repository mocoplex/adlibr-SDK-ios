//
//  ADLibMediator.h
//  Adlib
//
//  Created by gskang on 2015. 10. 1..
//  Copyright © 2015년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ADLibSession.h"
#import "SubAdlibAdViewCore.h"
#import "AdlibManager.h"

/**
 *  ADLibMediator 전면광고 관련 프로토콜
 *
 *  애드립 SubAdlibAdViewCore 클래스를 상속받는 각 플랫폼의 (ex. SubAdlibAdViewAdmob)
 *  구현클래스에서 전면광고 뷰컨트롤러를 수신시 해당 프로토콜을 호출하는 코드를 추가로 적용해 주어야
 *  해당 클래스의 block을 통해 전면광고를 띄우는 처리를 수행 할 수있다.
 *  (애드립 / 애드립하우스 광고는 SDK 내부에서 적용 처리됨)
 */
@protocol ADLibMediatorInterstitial <NSObject>

- (void)ADLibMediatorInterstitial:(SubAdlibAdViewCore *)viewCore
            didReceivedController:(UIViewController *)presentedViewController;

- (void)ADLibMediatorInterstitial:(SubAdlibAdViewCore *)viewCore
               didFailedWithError:(NSError *)error;

- (void)ADLibMediatorInterstitialDismissScreen:(SubAdlibAdViewCore *)viewCore;

@end


/**
 *  애드립 미디에이션 광고 컨트롤 클래스
 *
 *  @notice 현재는 지원 기능 (beta 버전 지원기능)
 *  - 애드립 전면광고 및 전면광고 미디에이션
 */
@interface ADLibMediator : NSObject <ADLibMediatorInterstitial> {
    
}

// 애드립 세션 정보
@property (nonatomic, strong, readonly) ADLibSession *adlibSession;

/**
 *  애드립 키를 가지고 객체를 생성
 *  추가로 link 메소드를 호출해 세션정보를 수신한 이후 사용할 수 있다.
 */
- (instancetype)initWithAdlibKey:(NSString *)key;

/**
 *  동일한 키 값으로 기존에 생성한 세션정보를 가지고 객체를 생성
 *  별도의 세션 정보를 가져오는 과정을 생략할 수 있다 (link method 호출 생략가능)
 */
- (instancetype)initWithAdlibSession:(ADLibSession *)session;

/**
 *  애드립 키와 세션 설정 정보를 가지고 객체를 생성
 *  추가로 link 메소드를 호출해 세션정보를 수신한 이후 사용할 수 있다.
 */
- (instancetype)initWithAdlibKey:(NSString *)key configSession:(ADLibSession *)session;


/** 
 *  미디에이션 플랫폼 추가 (애드립 / 애드립 하우스 광고는 내부적으로 자동 추가됨)
 *
 *  @param platform 애드립 이외의 광고 플랫폼 타입값
 *  @param className 해당 플랫폼에 대응하는 AdlibSubViewCore 구현 클래스
 */
- (void)addPlatform:(ADLIB_MEDPLATFORM)platform withClass:(Class)className;


// 애드립 설정 정보 연결 메소드
- (BOOL)linkAdlibSession;           // 상용모드 세션연결
- (BOOL)testModeLinkAdlibSession;   // 테스트 모드 세션연결

#pragma mark -
#pragma mark - InterstitialAD Methods

/**
 *  전면광고 요청 메소드
 *  @param viewController 전면광고를 띄울 뷰컨트롤러
 */
- (void)loadInterstitialAdWithParentViewController:(UIViewController *)viewContoller;

// 전면광고 요청 취소 메소드
- (void)cancelInterstitialRequest;

/**
 *  전면 광고 뷰컨트롤러 종료 메소드
 *
 *  @param animated 종료 시 에니메이션 여부
 *  @return 요청 성공 여부 (서브뷰에서 정의 되지 않은 경우 NO 리턴)
 */
- (BOOL)closeInterstitialAd:(BOOL)animated;


// 애드립 세션 연결 성공 / 실패에 대한 블럭함수 설정
- (void)setAdlibSessionLinkHandler:(void (^)(BOOL success, ADLibSession *session, NSError *error))handler;

// 전면광고 호출 성공에 대한 블럭함수 설정
// 해당 블록함수 내부에서 매체사에서 직접 presentViewController: 수행
- (void)setShouldPresentViewControllerWithHandler:(void (^)(UIViewController *modalViewContoller))handler;

// 전면광고 호출 실패에 대한 블럭함수 설정
// 설정된 모든 미디에이션 플랫폼에대한 요청이 실패한경우의 처리
- (void)setInterstitialAdRequestFailHandler:(void (^)(void))handler;

#pragma mark -
#pragma mark - Class Methods

// 여러개의 앱키를 사용할경우 앱키에 해당하는 식별자를 설정하여 저장
+ (BOOL)setAdlibAppKey:(NSString *)appKey forIdentifier:(NSString *)ide;
+ (NSString *)adlibAppKeyForIdentifier:(NSString *)ide;
+ (BOOL)clearAllSavedAdlibAppKey;

// ADLibMediator 객체를 전역으로 저장하여 사용할 수 있도록 제공하는 편의 메소드
+ (BOOL)setAdlibMediator:(ADLibMediator *)mediator forKey:(NSString *)appKey;
+ (BOOL)removeAdlibMediatorForKey:(NSString *)appKey;
+ (ADLibMediator *)adlibMediatorForKey:(NSString *)appKey;
+ (BOOL)clearAllSavedAdlibMediator;

@end
