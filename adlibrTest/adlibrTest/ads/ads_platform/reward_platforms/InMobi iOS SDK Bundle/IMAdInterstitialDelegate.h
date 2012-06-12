

#import <Foundation/Foundation.h>
@class IMAdInterstitial;
@class IMAdError;

/**
 * IMAdInterstitialDelegate.h
 * @description Defines the IMAdInterstitialDelegate protocol
 * @author: InMobi
 * Copyright (c) 2012 InMobi Pte Limited. All rights reserved.
 */
@protocol IMAdInterstitialDelegate <NSObject>

@optional

#pragma mark Ad Request Lifecycle delegate callbacks

/**
 * Sent when an interstitial ad request succeeded. 
 * @param ad - The interstitial ad that was loaded.
 */

- (void)interstitialDidFinishRequest:(IMAdInterstitial *)ad;

/**
 * Sent when an interstitial ad request completed without an interstitial to
 * show. This is common as interstitials are shown sparingly to users.
 * @param ad - The interstitial ad that failed to load.
 * @param error - The error that occurred during loading.
 */

- (void)interstitial:(IMAdInterstitial *)ad
didFailToReceiveAdWithError:(IMAdError *)error;

#pragma mark Display-Time Lifecycle delegate callbacks

/**
 * Sent just before presenting an interstitial. After this method finishes, the
 * interstitial will animate on to the screen. Use this opportunity to stop
 * animations and save the state of your application.
 * @param ad - The interstitial ad that will be presented to the user.
 */

- (void)interstitialWillPresentScreen:(IMAdInterstitial *)ad;

/**
 * Sent when an interstitial ad fails to present a full screen to the user.
 * This will generally occur if an interstitial is not in the kIMInterstitialAdStateReady state.
 * See IMAdInterstitial.h for a list of states.
 * @param ad - The interstitial ad that failed to present screen.
 * @param error - The error that occurred during loading.
 * @note - An interstitial ad can be shown only once.
 * After dismissal, you must call loadRequest: again and wait for this ad request to succeed.
 */
- (void)interstitial:(IMAdInterstitial *)ad didFailToPresentScreenWithError:(IMAdError *)error;

/**
 * Sent before the interstitial is to be animated off the screen.
 * @param ad - The interstitial that will be dismissed from the screen.
 */
- (void)interstitialWillDismissScreen:(IMAdInterstitial *)ad;


/**
 * Sent just after dismissing an interstitial and it has animated off the
 * screen.
 * @param ad - The interstitial that was dismissed from the screen.
 */
- (void)interstitialDidDismissScreen:(IMAdInterstitial *)ad;

/**
 * Sent just before the application goes to the background, or terminate, because the
 * user clicked on an ad that launches another application (such as the App
 * Store). The normal UIApplicationDelegate methods, like
 * applicationDidEnterBackground:, will be called immediately before this.
 * @param ad - The interstitial that caused tha user to leave the application.
 */

- (void)interstitialWillLeaveApplication:(IMAdInterstitial *)ad;

@end
