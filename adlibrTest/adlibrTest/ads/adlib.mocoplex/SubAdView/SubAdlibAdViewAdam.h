/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with ad@m SDK 2.0 (2012.04.21)
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "AdamAdView.h"

#define AD_REFRESH_PERIOD 60
@interface SubAdlibAdViewAdam : SubAdlibAdViewCore<AdamAdViewDelegate>
{
    AdamAdView *ad;
}

@end
