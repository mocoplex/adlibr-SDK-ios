//
//  AppDelegate.m
//  ADLib-sample-project
//
//  Created by gskang on 2015. 3. 2..
//  Copyright (c) 2015년 adlibr. All rights reserved.
//

#import "AppDelegate.h"
#import <Adlib/Adlib.h>

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

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)initializeAdlib
{
    NSString* adlibKey = ADLIB_APP_KEY;
    
    if (adlibKey.length < 1) {
        adlibKey = nil;
    }
    
    AdlibManager *sharedManager = [AdlibManager sharedSingletonClass];
    sharedManager.sessionDelegate = self;
    
    // 사용할 플랫폼을 등록 후 쓰지 않을 광고 플랫폼은 삭제해주세요.
    //[sharedManager setPlatform:@"ADAM"  withClass:[SubAdlibAdViewAdam class]];
    //[sharedManager setPlatform:@"ADMOB" withClass:[SubAdlibAdViewAdmob class]];
    //[sharedManager setPlatform:@"IAD"   withClass:[SubAdlibAdViewiAd class]];
    //[sharedManager setPlatform:@"NAVER" withClass:[SubAdlibAdViewNaverAdPost class]];
    //[sharedManager setPlatform:@"CAULY" withClass:[SubAdlibAdViewCauly class]];
    //[sharedManager setPlatform:@"TAD" withClass:[SubAdlibAdViewTAD class]];
    //[sharedManager setPlatform:@"INMOBI" withClass:[SubAdlibAdViewInmobi class]];
    //[sharedManager setPlatform:@"ADMIXER" withClass:[SubAdlibAdAdmixer class]];
    //[sharedManager setPlatform:@"MEDIBAAD" withClass:[SubAdlibAdViewMedibaAd class]];
    //[sharedManager setPlatform:@"SHALLWEAD" withClass:[SubAdlibAdViewShallWeAd Class]];
    //[sharedManager setPlatform:@"ADHUB" withClass:[SubAdlibAdViewAdHub Class]];
    //[sharedManager setPlatform:@"DOMOB" withClass:[SubAdlibAdViewDomob class]];
    //[sharedManager setPlatform:@"MM" withClass:[SubAdlibAdViewMMedia class]];
    //[MMSDK initialize];  // MillennialMedia v5.2.0 이상을 사용하시려면 반드시 초기화를 호출해 주세요.
    
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
