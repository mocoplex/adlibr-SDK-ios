//
//  AppDelegate.m
//  ADLibSample
//
//  Created by gskang on 2016. 8. 17..
//
//

#import "AppDelegate.h"

#import <AVFoundation/AVFAudio.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                     withOptions:AVAudioSessionCategoryOptionMixWithOthers
                                           error:nil];

    return YES;
}

@end
