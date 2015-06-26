/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with domob SDK 4.3.3
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import "DMAdView.h"

@interface SubAdlibAdViewDomob : SubAdlibAdViewCore <DMAdViewDelegate>
{
    BOOL iPad;
    
}

@property (nonatomic, strong) DMAdView *ad;

@end