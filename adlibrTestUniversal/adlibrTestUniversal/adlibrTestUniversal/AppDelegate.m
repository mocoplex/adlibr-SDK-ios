//
//  AppDelegate.m
//  ADLib-sample-project
//
//  Created by mocoplex on 2015. 3. 2..
//  Copyright (c) 2015년 mocoplex. All rights reserved.
//

#import "AppDelegate.h"
#import <Adlib/ADLibSDK.h>

//#import "SubAdlibAdViewAdam.h"
//#import "SubAdlibAdViewAdmob.h"
//#import "SubAdlibAdViewiAd.h"
//#import "SubAdlibAdViewNaverAdPost.h"
//#import "SubAdlibAdViewInmobi.h"
//#import "SubAdlibAdViewTAD.h"
//#import "SubAdlibAdViewCauly.h"
//#import "SubAdlibAdViewDomob.h"
//#import "SubAdlibAdViewMedibaAd.h"
//#import "SubAdlibAdViewMMedia.h"
//#import "SubAdlibAdViewShallWeAd.h"
//#import "SubAdlibAdViewAdHub.h"
//#import "SubAdlibAdAdmixer.h"

#define ADLIB_APP_KEY @"550787410cf2833915d71f3b" // 애드립에서 발급받은 키를 입력해주세요.


@interface AppDelegate () <AdlibSessionDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializeAdlib];
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)initializeAdlib
{
    NSString* adlibKey = ADLIB_APP_KEY;
    
    if (adlibKey.length < 1) {
        adlibKey = nil;
    }
    
    [ADLibMediator setAdlibAppKey:ADLIB_APP_KEY forIdentifier:@"adlibSampleKey"];
    
    AdlibManager *sharedManager = [AdlibManager sharedSingletonClass];
    sharedManager.sessionDelegate = self;
    
    // 사용할 플랫폼을 등록 후 쓰지 않을 광고 플랫폼은 삭제해주세요.

    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_ADMOB withClass:[SubAdlibAdViewAdmob class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_ADAM withClass:[SubAdlibAdViewAdam class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_ADMIXER withClass:[SubAdlibAdAdmixer class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_CAULY withClass:[SubAdlibAdViewCauly class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_INMOBI withClass:[SubAdlibAdViewInmobi class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_TAD withClass:[SubAdlibAdViewTAD class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_SHALLWEAD withClass:[SubAdlibAdViewShallWeAd Class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_IAD withClass:[SubAdlibAdViewiAd Class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_ADHUB withClass:[SubAdlibAdViewAdHub Class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_DOMOB withClass:[SubAdlibAdViewDomob Class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_MEDIBAAD withClass:[SubAdlibAdViewMedibaAd Class]];
    //[sharedManager registerPlatform:ADLIB_MEDPLATFORM_NAVER withClass:[SubAdlibAdViewNaverAdPost Class]];
    
    // SDK 로그 메시지를 출력하도록 설정
    [sharedManager setLogging:NO];
    
#warning 배포이전에 하단 코드 확인하기.
    BOOL isTestMode = YES;
    
    if (isTestMode)
    {
        //개발 버전에서 사용하는 세션 연결
        [sharedManager testModeLinkWithAdlibKey:adlibKey];
    }
    else
    {
        //배포 버전에서 사용하는 세션 연결
        [sharedManager linkWithAdlibKey:adlibKey];
    }
}

#pragma mark - AdlibManager Session Delegate

//애드립 세션 연결 성공 시 호출되는 메소드.
- (void)adlibManager:(AdlibManager *)manager didLinkedSessionWithUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"adlib session linked");
}

//애드립 세션 연결 실패 시 호출되는 메소드.
- (void)adlibManager:(AdlibManager *)manager didFailedSessionLinkWithError:(NSError *)error
{
    NSLog(@"adlib session link failed");
}

@end
