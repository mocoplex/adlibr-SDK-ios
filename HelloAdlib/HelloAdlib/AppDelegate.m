//
//  AppDelegate.m
//  HelloAdlib
//
//  Created by Nara on 12. 5. 8..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameCenter.h"
#import "HelloWorldLayer.h"

#import <Adlib/Adlib.h>

//#import "SubAdlibAdViewAdam.h"
//#import "SubAdlibAdViewAdmob.h"
//#import "SubAdlibAdViewCauly.h"
//#import "SubAdlibAdViewTAD.h"
//#import "SubAdlibAdViewiAd.h"
//#import "SubAdlibAdViewNaverAdPost.h"
//#import "SubAdlibAdViewShallWeAd.h"
//#import "SubAdlibAdViewInmobi.h"
//#import "SubAdlibAdViewDomob.h"
//#import "SubAdlibAdViewAdHub.h"
//#import "SubAdlibAdViewUPlusAD.h"
//#import "SubAdlibAdViewMedibaAd.h"
//#import "SubAdlibAdViewMMedia.h"

#define ADLIB_APP_KEY @"550787410cf2833915d71f3b" // 애드립에서 발급받은 키를 입력해주세요.

@interface AppDelegate () <AdlibSessionDelegate, AdlibManagerDelegate>

@end

@implementation AppDelegate

@synthesize window;

/// ADLIBr ///
- (void)showADLIBr
{
    
    BOOL bannerVerticalAlignTop = YES;

    /*
     * 하단 attach 메소드에 전달하는 containerView 상에서 상/하단 정렬 옵션을 
     * 지정합니다.
     */
    ADLIB_ADVIEW_VERTICAL_ALIGN vAlign = ADLIB_ADVIEW_VERTICAL_ALIGN_BOTTOM;
    if (bannerVerticalAlignTop) {
        vAlign = ADLIB_ADVIEW_VERTICAL_ALIGN_TOP;
    } else {
        vAlign = ADLIB_ADVIEW_VERTICAL_ALIGN_BOTTOM;
    }
    
    AdlibManager *manager = [AdlibManager sharedSingletonClass];
    [manager attachWithViewController:viewController
                      atContainerView:viewController.view
                          bannerAlign:ADLIB_BANNER_ALIGN_CENTER
                          adViewAlign:vAlign];
    manager.delegate = self;
    
}

- (void)hideADLIBr
{
    AdlibManager *manager = [AdlibManager sharedSingletonClass];
    [manager detach:viewController];
    manager.delegate = nil;
}

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}

- (void)initAdlib
{
    
    NSString* adlibKey = ADLIB_APP_KEY;
    
    if (adlibKey.length < 1) {
        adlibKey = nil;
    }
    
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

#pragma  mark - AdlibSessionDelegate

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


#pragma  mark - AdlibMangerDelegate

// 띠배너 광고 수신 성공시 호출되는 메소드.
- (void)didReceiveAdlibAd:(NSString*)from
{
    NSLog(@"didReceiveAdlibAd : %@", from);
}

// 띠배너 광고 수신 실패시 호출되는 메소드.
- (void)didFailToReceiveAdlibAd:(NSString*)from
{
    NSLog(@"didFailToReceiveAdlibAd : %@", from);
}

// 전면광고 수신 성공시 호출되는 메소드.
- (void)didReceiveAdlibInterstitialAd:(NSString*)from
{
    NSLog(@"didReceiveAdlibInterstitialAd : %@", from);
}

// 전면광고 수신 실패시 호출되는 메소드.
- (void)didFailToReceiveAdlibInterstitialAd:(NSString*)from
{
    NSLog(@"didFailToReceiveAdlibInterstitialAd : %@", from);
}

// 전면광고 닫힌 직후 호출되는 메소드.
- (void)didCloseAdlibInterstitialAd:(NSString*)from
{
    NSLog(@"didFailToReceiveAdlibAd : %@", from);
}

// 스케줄링 된 모든 전면광고 수신 실패시 호출되는 메소드.
- (void)didFailToReceiveAllInterstitialAd
{
    NSLog(@"didFailToReceiveAllInterstitialAd");
}

#pragma mark -

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    [self initAdlib];
    
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//

	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
    
    /*
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
     */	

	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
    
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
    window.rootViewController = viewController;
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	
	// Removes the startup flicker
	[self removeStartupFlicker];
	
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [HelloWorldLayer scene]];
    
    // 게임센터 start
    [GameCenter startGameCenter];
    
    // attach adlib..
    [self showADLIBr];
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

@end
