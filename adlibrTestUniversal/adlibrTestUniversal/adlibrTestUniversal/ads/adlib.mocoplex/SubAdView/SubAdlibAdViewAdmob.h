/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with admob SDK 7.4.1
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import <GoogleMobileAds/GADBannerView.h>
#import <GoogleMobileAds/GADInterstitial.h>

@interface SubAdlibAdViewAdmob : SubAdlibAdViewCore
{
    BOOL _iPad;
}

@property (nonatomic, strong) GADBannerView *adView;

@end
