/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with admob SDK 6.0.1
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "GADBannerView.h"

@interface SubAdlibAdViewAdmob : SubAdlibAdViewCore<GADBannerViewDelegate>
{
    BOOL iPad;    
    GADBannerView *ad;
}

@end
