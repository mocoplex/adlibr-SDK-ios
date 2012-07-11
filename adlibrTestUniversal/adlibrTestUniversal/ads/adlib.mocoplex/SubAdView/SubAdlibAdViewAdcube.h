/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with adcube SDK 1.9
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "zcView.h"

@interface SubAdlibAdViewAdcube : SubAdlibAdViewCore<zcViewDelegate>
{
    zcView *ad;
}

@end
