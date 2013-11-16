/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 3.7.0
 */

#import <UIKit/UIKit.h>
#import "IMAdView.h"
#import "IMAdDelegate.h"
#import "IMAdRequest.h"
#import "IMAdError.h"
#import <Adlib/Adlib.h>

@interface SubAdlibAdViewInmobi : SubAdlibAdViewCore<IMAdDelegate>
{
    BOOL    iPad;
    BOOL    bShowed;
    IMAdView *ad;
    int nSyncQueryFlag;
}

@end