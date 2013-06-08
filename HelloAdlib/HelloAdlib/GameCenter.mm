//
//  GameCenter.mm
//  HelloAdlib
//
//  Created by Hana Kim on 13. 6. 7..
//
//

#import "GameCenter.h"
#include "cocos2d.h"

#import "AppDelegate.h"

@implementation GameCenter

+ (void) startGameCenter
{
    if( [self isGameCenterAPIAvailable] == NO )
    {
        return;
    }
    [self authenticateLocalPlayer];
}

+ (BOOL) isGameCenterAPIAvailable
{
    // Check for presence of GKLocalPlayer class.
    BOOL localPlayerClassAvailable = (NSClassFromString(@"GKLocalPlayer")) != nil;
    
    // The device must be running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (localPlayerClassAvailable && osVersionSupported);
}

+ (void) authenticateLocalPlayer
{
    GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
        if( localPlayer.isAuthenticated )
        {
            NSLog(@"Alias : %@", localPlayer.alias);
            NSLog(@"Player ID : %@", localPlayer.playerID);
        }
    }];
}

+ (void) reportScore:(int64_t)score
{
    GKScore* scoreReporter = [[[GKScore alloc] initWithCategory:LeaderboardID] autorelease];
    scoreReporter.value = score;
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if( error != nil )
        {
            
        }
    }];
}

UIViewController* tempUIView;
+ (void) showLeaderboard
{
    GKLeaderboardViewController* pController = [[[GKLeaderboardViewController alloc] init] autorelease];
    
    if( pController != nil )
    {
        pController.leaderboardDelegate = self;
        
        // hide ADLIBr
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate hideADLIBr];
        
        tempUIView = [[UIViewController alloc] init];
        [[[CCDirector sharedDirector] openGLView] addSubview:tempUIView.view];
        [tempUIView presentModalViewController:pController animated:YES];
    }
}

+ (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [viewController dismissModalViewControllerAnimated:YES];
    [viewController.view.superview removeFromSuperview];
    [tempUIView release];
    
    // show ADLIBr
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showADLIBr];
}

@end