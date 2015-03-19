/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with mediba ad SDK 2.0.3
 */

#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>
#import "MasManagerViewController.h"

@interface SubAdlibAdViewMedibaAd : SubAdlibAdViewCore <MasManagerViewControllerDelegate>
{

}

@property (nonatomic, strong) MasManagerViewController *mas;

@end
