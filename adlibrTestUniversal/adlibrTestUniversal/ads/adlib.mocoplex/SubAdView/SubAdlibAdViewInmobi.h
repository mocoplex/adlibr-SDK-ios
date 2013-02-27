/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 3.6.5
 */

#import <UIKit/UIKit.h>
#import "IMAdView.h"
#import "IMAdDelegate.h"
#import "IMAdRequest.h"
#import "IMAdError.h"
#import "SubAdlibAdViewCore.h"

@interface SubAdlibAdViewInmobi : SubAdlibAdViewCore<IMAdDelegate>
{
    BOOL    iPad;
    BOOL    bShowed;
    IMAdView *ad;
    int nSyncQueryFlag;
}

@end
