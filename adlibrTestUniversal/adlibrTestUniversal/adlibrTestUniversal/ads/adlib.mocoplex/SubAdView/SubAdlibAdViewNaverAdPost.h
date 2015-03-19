/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with NaverAdPost SDK 1.3.0
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import "MobileAdView.h"

@interface SubAdlibAdViewNaverAdPost : SubAdlibAdViewCore<MobileAdViewDelegate>
{
    BOOL bGotAd;
    
}

@property (nonatomic, strong) MobileAdView *adView;

@end