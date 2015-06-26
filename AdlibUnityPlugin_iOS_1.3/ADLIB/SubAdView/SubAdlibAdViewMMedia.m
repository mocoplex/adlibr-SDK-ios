/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with MillennialMedia SDK 5.3.0
 */

#import "SubAdlibAdViewMMedia.h"

/*
 MillennialMedia v5.2.0 이상부터는
 AppDelegate의 didFinishLaunchingWithOptions 메소드에서
 [MMSDK initialize];
 를 반드시 호출해 주세요.
 */

// MILLENNIAL MEDIA의 APP 아이디를 설정합니다.
#define MMEDIA_ID @"MILLENNIALMEDIA_ID"
#define MMEDIA_INTERSTITIAL_ID @"MILLENNIALMEDIA_INTERSTITIAL_ID"

#define MILLENNIAL_IPHONE_AD_VIEW_FRAME CGRectMake(0, 0, 320, 50)
#define MILLENNIAL_IPAD_AD_VIEW_FRAME CGRectMake(0, 0, 728, 90)
#define MILLENNIAL_AD_VIEW_FRAME ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? MILLENNIAL_IPAD_AD_VIEW_FRAME : MILLENNIAL_IPHONE_AD_VIEW_FRAME)

@implementation SubAdlibAdViewMMedia

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    // Returns an autoreleased MMAdView object
    MMAdView *ad = [[MMAdView alloc] initWithFrame:MILLENNIAL_AD_VIEW_FRAME
                                              apid:MMEDIA_ID
                                rootViewController:parent];
    
    self.adView = ad;
    
    // Ad banner to the view
    [ad removeFromSuperview];
    [self.view addSubview:ad];
    
    [self queryAd];
    [self getAd];
}

- (CGSize)size
{
    int w = self.view.bounds.size.width;
    
    CGRect adViewFrame = MILLENNIAL_AD_VIEW_FRAME;
    
    return CGSizeMake(adViewFrame.size.width, adViewFrame.size.height);
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    CGSize viewSize = self.view.bounds.size;
    CGFloat height = 50;
    CGRect adViewFrame = MILLENNIAL_AD_VIEW_FRAME;
    
    CGFloat originX = (viewSize.width - adViewFrame.size.width)/2;
    if (originX < 0) {
        originX = 0;
    }
    
    CGFloat originY = (viewSize.height - adViewFrame.size.height);
    if (originY < 0) {
        originY = 0;
    }
    
    _adView.frame = CGRectMake(originX, originY, viewSize.width, height);
}


- (void)clearAdView
{
    [super clearAdView];
    
    if(_adView != nil)
    {
        [_adView removeFromSuperview];
        _adView.rootViewController = nil;
        self.adView = nil;
    }
}

#pragma mark - Get Ad

- (void)getAd
{
    MMRequest *request = [MMRequest request];
    
    // Get a banner ad
    [ad getAdWithRequest:request onCompletion:^(BOOL success, NSError *error) {
        if (success) {
            // 화면에 광고를 보여줍니다.
            [self gotAd];
        }
        else {
            // 광고 수신에 실패하였습니다.
            [self failed];
        }
    }];
}

- (void)subAdlibViewLoadInterstitial:(UIViewController*)viewController
{
    //MMRequest Object
    MMRequest *request = [MMRequest request];
    
    //Replace YOUR_APID with the APID provided to you by Millennial Media
    [MMInterstitial fetchWithRequest:request
                                apid:MMEDIA_INTERSTITIAL_ID
                        onCompletion:^(BOOL success, NSError *error) {
                            if (success) {
                                [MMInterstitial displayForApid:MMEDIA_INTERSTITIAL_ID
                                            fromViewController:viewController
                                               withOrientation:MMOverlayOrientationTypeAll
                                                  onCompletion:^(BOOL success, NSError *error) {
                                                      if (success) {
                                                          // Interstitial displayed successfully.
                                                          [self didReceiveInterstitialAd];
                                                      }
                                                      else {
                                                          // Error displaying interstitial
                                                          [self didFailToReceiveInterstitialAd];
                                                      }
                                                  }];
                            }else{
                                // Error fetching ad
                                [self didFailToReceiveInterstitialAd];
                            }
                        }];
}

- (void)didReceiveInterstitialAd
{
    // 전면광고 성공을 알린다.
    [self subAdlibViewInterstitialReceived:@"mmedia"];
}

- (void)didFailToReceiveInterstitialAd
{
    // 전면광고 실패를 알린다.
    [self subAdlibViewInterstitialFailed:@"mmedia"];
}

@end
