/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with NaverAdPost SDK 1.2.0
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "MobileAdView.h"

@interface SubAdlibAdViewNaverAdPost : SubAdlibAdViewCore<MobileAdViewDelegate>
{
    BOOL bGotAd;
    MobileAdView *ad;
}

@end