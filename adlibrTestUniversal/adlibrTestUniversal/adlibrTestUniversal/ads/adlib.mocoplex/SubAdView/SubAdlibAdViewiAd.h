/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with iAD
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import <iAd/iAd.h>

@interface SubAdlibAdViewiAd : SubAdlibAdViewCore <ADBannerViewDelegate>
{
    BOOL iPad;
}

@property (nonatomic, strong) ADBannerView *iAdBannerView;

@end
