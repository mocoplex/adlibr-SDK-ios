/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with cauly SDK 2.5.0
 */

#import "SubAdlibAdViewCore.h"
#import "CaulyViewController.h"

@interface SubAdlibAdViewCauly : SubAdlibAdViewCore<CaulyProtocol>
{
    BOOL bGotAd;
    BOOL iPad;
}

@end
