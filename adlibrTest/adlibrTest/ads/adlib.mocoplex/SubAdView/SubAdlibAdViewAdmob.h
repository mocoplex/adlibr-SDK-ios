/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with admob SDK 5.0.5 (2012.04.21)
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "GADBannerView.h"

@interface SubAdlibAdViewAdmob : SubAdlibAdViewCore<GADBannerViewDelegate>
{
    GADBannerView *ad;
}

@end
