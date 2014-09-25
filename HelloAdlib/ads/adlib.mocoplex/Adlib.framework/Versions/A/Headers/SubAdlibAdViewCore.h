//
//  SubAdlibAdViewCore.h
//  AdlibTestProject
//
//  Created by Nara Park on 12. 2. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubAdlibAdsView.h"

@class AdlibManager;
@interface SubAdlibAdViewCore : NSObject

- (SubAdlibAdViewCore*)initWithManager:(AdlibManager*)m;

- (void)query:(UIViewController*)parent;
- (void)clearAdView;
- (void)startAdRequest;
- (void)stopAdRequest;
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
+ (void)loadInterstitial:(UIViewController*)viewController;
+ (void)interstitialReceived:(NSString*)from;
+ (void)interstitialFailed:(NSString*)from;
+ (void)interstitialClosed:(NSString*)from;

// 광고 화면 처리 (2014.09.24 - yongsun)
- (void)queryAd;

@property (nonatomic,retain) SubAdlibAdsView* view;
@property (nonatomic,assign) UIViewController* parentController;

@end
