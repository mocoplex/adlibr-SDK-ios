/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with t-ad SDK 3.1.0.6
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "TadCore.h"

@interface SubAdlibAdViewTAD : SubAdlibAdViewCore<TadDelegate>
{
    BOOL    bGotAd;
    TadCore *tadCore;
}

@end
