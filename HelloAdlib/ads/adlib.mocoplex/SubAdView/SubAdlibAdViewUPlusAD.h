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
#import "SubAdlibAdViewCore.h"
#import "UplusAd.h"

@interface SubAdlibAdViewUPlusAD : SubAdlibAdViewCore
{
    BOOL iPad;
    UplusAd *ad;
}

@end
