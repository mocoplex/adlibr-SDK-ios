//
//  ALAdInterstitialViewController.h
//  ADLibSDK
//
//  Created by mocoplex on 2015. 1. 15..
//  Copyright (c) 2015년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAdlibBannerEvent;
@class ALAdInterstitialViewController;
@class ADLibSession;

@protocol ALAdInterstitialControllerDelegate <NSObject>

- (void)ALAdInterstitialControllerDismiss:(ALAdInterstitialViewController *)controller;

@end

/**< 애드립 전면광고 뷰 컨트롤러 */
@interface ALAdInterstitialViewController : UIViewController

- (instancetype)initWithBannerEvent:(ALAdlibBannerEvent *)bannerEvent
                            session:(ADLibSession *)session;

- (instancetype)initWithWebUrl:(NSURL *)webUrl;

@property (nonatomic, weak) id <ALAdInterstitialControllerDelegate>delegate;
@property (nonatomic, strong) UIColor *bgColor;

@end
