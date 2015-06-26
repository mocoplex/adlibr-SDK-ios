/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with Inmobi SDK 4.5.1
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import "IMInterstitial.h"
#import "IMInterstitialDelegate.h"


@interface SubAdlibAdViewInmobi : SubAdlibAdViewCore<IMBannerDelegate>
{
    BOOL    iPad;
    
}

@property (nonatomic, strong) IMBanner *adView;

@end
