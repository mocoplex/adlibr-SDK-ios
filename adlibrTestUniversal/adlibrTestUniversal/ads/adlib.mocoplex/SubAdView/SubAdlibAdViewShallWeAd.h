/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with ShallWeAd SDK 2.4.2
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "ShallWeAD_IOSSDK/ShallWeAD.h"


@interface SubAdlibAdViewShallWeAd : SubAdlibAdViewCore<ShallWeAdDelegate>
{
    BOOL bGotAd;
}

@end
