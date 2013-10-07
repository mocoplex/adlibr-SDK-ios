/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

#import <UIKit/UIKit.h>
#import "SubAdlibAdsView.h"

@class AdlibManager;
@interface SubAdlibAdViewCore : NSObject

- (SubAdlibAdViewCore*)initWithManager:(AdlibManager*)m;

- (void)query:(UIViewController*)parent;
- (void)clearAdView;
- (void)adsizeChanged;
- (void)gotAd;
- (void)failed;
- (CGSize)size;
- (BOOL)isLoaded;
- (BOOL)isPortrait;
- (void)orientationChanged;
- (void)setParentViewRect:(CGRect)rt;
- (UIViewController*)getParentController;

+ (BOOL)isStaticObject;

+ (void)loadInterstitail:(UIViewController*)viewController;
+ (void)interstitialReceived:(NSString*)from;
+ (void)interstitialFailed:(NSString*)from;
+ (void)interstitialClosed:(NSString*)from;

@property (nonatomic,retain) SubAdlibAdsView* view;
@property (nonatomic,assign) UIViewController* parentController;

@end
