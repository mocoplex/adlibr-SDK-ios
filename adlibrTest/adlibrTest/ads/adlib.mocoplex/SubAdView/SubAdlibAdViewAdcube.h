/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with adcube SDK 1.9 (2012.04.21)
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "zcView.h"

@interface SubAdlibAdViewAdcube : SubAdlibAdViewCore<zcViewDelegate>
{
    zcView *ad;
}

@end
