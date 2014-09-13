/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with ShallWeAd SDK 2.4.7
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import <ShallWeAD_IOSSDK/ShallWeAD.h>


@interface SubAdlibAdViewShallWeAd : SubAdlibAdViewCore<ShallWeAdDelegate>
{
    BOOL    iPad;
    BOOL    bGotAd;
}

@end
