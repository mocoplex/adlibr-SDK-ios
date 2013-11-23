/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

#import "AppDelegate.h"
#import "ViewController.h"

#import <Adlib/Adlib.h>

#import "SubAdlibAdViewAdam.h"
#import "SubAdlibAdViewAdmob.h"
#import "SubAdlibAdViewCauly.h"
#import "SubAdlibAdViewTAD.h"
#import "SubAdlibAdViewiAd.h"
#import "SubAdlibAdViewNaverAdPost.h"
#import "SubAdlibAdViewShallWeAd.h"
#import "SubAdlibAdViewInmobi.h"
#import "SubAdlibAdViewMMedia.h"
#import "SubAdlibAdViewDomob.h"
#import "SubAdlibAdViewAdHub.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)initAdlib
{
    NSString* adlibKey;
    
    // 애드립에서 발급받은 키를 입력해주세요.
    adlibKey = @"ADLIBr - KEY";
    
    [[AdlibManager sharedSingletonClass] initAdlib:adlibKey];
    
    // 쓰지 않을 광고 플랫폼은 삭제해주세요.
    [[AdlibManager sharedSingletonClass] setPlatform:@"ADAM" withClass:[SubAdlibAdViewAdam class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"ADMOB" withClass:[SubAdlibAdViewAdmob class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"CAULY" withClass:[SubAdlibAdViewCauly class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"TAD" withClass:[SubAdlibAdViewTAD class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"IAD" withClass:[SubAdlibAdViewiAd class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"NAVER" withClass:[SubAdlibAdViewNaverAdPost class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"SHALLWEAD" withClass:[SubAdlibAdViewShallWeAd class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"INMOBI" withClass:[SubAdlibAdViewInmobi class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"MMEDIA" withClass:[SubAdlibAdViewMMedia class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"DOMOB" withClass:[SubAdlibAdViewDomob class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"ADHUB" withClass:[SubAdlibAdViewAdHub class]];
    // 쓰지 않을 광고 플랫폼은 삭제해주세요.
    
}


- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initAdlib];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
    } else {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
