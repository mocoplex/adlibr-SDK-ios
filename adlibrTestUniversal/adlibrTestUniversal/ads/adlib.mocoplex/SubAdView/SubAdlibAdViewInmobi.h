/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 4.0.4
 */

#import <UIKit/UIKit.h>
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import <Adlib/Adlib.h>

@interface SubAdlibAdViewInmobi : SubAdlibAdViewCore<IMBannerDelegate>
{
    BOOL    iPad;
    IMBanner *ad;
}
@property (nonatomic,retain) IMBanner *ad;

@end
