/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with MillennialMedia SDK 5.1.1
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "MMAdView.h"

@interface SubAdlibAdViewMMedia : SubAdlibAdViewCore
{
    BOOL iPad;    
    MMAdView *ad;
}

@end
