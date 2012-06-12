/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with iAD (2012.04.21)
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "iAd/iAd.h"

@interface SubAdlibAdViewiAd : SubAdlibAdViewCore<ADBannerViewDelegate>
{
    ADBannerView* ad;
}

@end
