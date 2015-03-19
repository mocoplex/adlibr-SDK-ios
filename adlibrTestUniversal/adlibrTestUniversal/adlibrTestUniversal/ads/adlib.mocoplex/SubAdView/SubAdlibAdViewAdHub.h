/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with SamsungAdHub SDK 2.0.0
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import "AdHubView.h"
#import "AdHubInterstitial.h"
#import "AdHubViewDelegate.h"

@interface SubAdlibAdViewAdHub : SubAdlibAdViewCore<AdHubViewDelegate>
{
    BOOL iPad;
}

@property (nonatomic, strong) AdHubView *adView;

@end
