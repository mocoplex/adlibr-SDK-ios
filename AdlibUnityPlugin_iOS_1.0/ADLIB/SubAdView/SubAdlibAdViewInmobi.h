/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 4.3.0
 */

#import <UIKit/UIKit.h>
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import "IMInterstitial.h"
#import "IMInterstitialDelegate.h"
#import <Adlib/Adlib.h>

@interface SubAdlibAdViewInmobi : SubAdlibAdViewCore<IMBannerDelegate>
{
    IMBanner *ad;
}

@end
