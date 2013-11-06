//
//  AppDelegate.h
//  HelloAdlib
//
//  Created by Nara on 12. 5. 8..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>

@interface AppDelegate : NSObject <UIApplicationDelegate,AdlibManagerDelegate> {
	UIWindow			*window;
	UIViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

- (void)showADLIBr;
- (void)hideADLIBr;

@end
