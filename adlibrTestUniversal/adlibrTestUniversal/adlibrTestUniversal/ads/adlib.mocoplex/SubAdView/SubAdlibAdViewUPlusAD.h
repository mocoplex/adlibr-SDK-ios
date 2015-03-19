/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with U+AD SDK 3.0.4
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import "UplusAd.h"

@interface SubAdlibAdViewUPlusAD : SubAdlibAdViewCore
{
    BOOL iPad;    
}

@property (nonatomic, strong) UplusAd *adView;

@end
