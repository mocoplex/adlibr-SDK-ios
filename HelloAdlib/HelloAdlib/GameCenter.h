//
//  GameCenter.h
//  HelloAdlib
//
//  Created by Hana Kim on 13. 6. 7..
//
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
///< iTunes Connect에 설정한 리더보드 Id
#define LeaderboardID @"Leaderboard_ID"

@interface GameCenter : NSObject

+ (void) startGameCenter;
+ (BOOL) isGameCenterAPIAvailable;
+ (void) authenticateLocalPlayer;
+ (void) reportScore:(int64_t)score;
+ (void) showLeaderboard;

@end