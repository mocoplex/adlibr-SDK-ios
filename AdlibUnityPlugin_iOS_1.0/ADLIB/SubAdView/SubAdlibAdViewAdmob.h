/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with admob SDK 6.8.0
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import "GADBannerView.h"
#import "GADInterstitial.h"

@interface SubAdlibAdViewAdmob : SubAdlibAdViewCore<GADBannerViewDelegate>
{
    GADBannerView *ad;
}

@end
