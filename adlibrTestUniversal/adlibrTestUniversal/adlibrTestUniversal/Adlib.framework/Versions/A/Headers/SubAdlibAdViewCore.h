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

- (void)subAdlibViewLoadInterstitial:(UIViewController*)viewController;
- (void)subAdlibViewInterstitialReceived:(NSString*)from;
- (void)subAdlibViewInterstitialFailed:(NSString*)from;
- (void)subAdlibViewInterstitialClosed:(NSString*)from;

// 광고 화면 처리 (2014.09.24 - yongsun)
- (void)queryAd;

// 띠배너 광고 클릭 이벤트를 애드립 대시보드에 리포트
- (void)reportBannerClickEvent;

// 전면 광고 클릭 이벤트를 애드립 대시보드에 리포트
- (void)reportInterstitialClickEvent;

//
+ (void)loadInterstitail:(UIViewController*)viewController;
+ (void)loadInterstitial:(UIViewController*)viewController;
+ (void)interstitialReceived:(NSString*)from;
+ (void)interstitialFailed:(NSString*)from;
+ (void)interstitialClosed:(NSString*)from;
//

@property (nonatomic, strong) SubAdlibAdsView* view;
@property (nonatomic, weak)   UIViewController* parentController;

@end
