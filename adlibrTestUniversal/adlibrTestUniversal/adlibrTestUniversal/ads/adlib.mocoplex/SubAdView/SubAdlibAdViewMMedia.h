/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with MillennialMedia SDK 5.3.0
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import <MillennialMedia/MMAdView.h>
#import <MillennialMedia/MMInterstitial.h>

@interface SubAdlibAdViewMMedia : SubAdlibAdViewCore
{
    BOOL iPad;
}

@property (nonatomic, strong) MMAdView *adView;

@end
