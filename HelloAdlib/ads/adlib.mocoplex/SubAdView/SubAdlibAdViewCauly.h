/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with cauly SDK 3.0.6
 */

#import <Adlib/Adlib.h>
#import "CaulyAdView.h"
#import "CaulyInterstitialAd.h"

@interface SubAdlibAdViewCauly : SubAdlibAdViewCore <CaulyAdViewDelegate>
{
    BOOL iPad;
}

@property (nonatomic, strong) CaulyAdView *adView;

@end
