//
//  IMAdInterstitialDelegate.h
//  InMobi AdNetwork SDK
//
//  Copyright 2012 InMobi Technology Services Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IMAdInterstitial;
@class IMAdError;

/**
 * This is the delegate for receiving state change messages from an
 * IMAdInterstitial. Use this to receive callbacks for interstitial ad request
 * succeeding, failing or for the time when the interstitial ad is presented.
 */
@protocol IMAdInterstitialDelegate <NSObject>

@optional

#pragma mark Ad Request Lifecycle Notifications

/**
 * Callback sent when the interstitial is successfully loaded and is ready to
 * be displayed. You may want to show it at the next transition point in your
 * application such as when transitioning between view controllers.
 *
 * @param ad The IMAdInterstitial instance that successfully loaded an ad.
 */
- (void)interstitialDidFinishRequest:(IMAdInterstitial *)ad;

/**
 * Callback sent when an interstitial ad request completed without an
 * interstitial to show. This is common as interstitials are shown sparingly
 * to users.
 *
 * @param ad The IMAdInterstitial instance that failed to load an ad.
 * @param error The error that occurred during loading.
 */
- (void)interstitial:(IMAdInterstitial *)ad
    didFailToReceiveAdWithError:(IMAdError *)error;

#pragma mark Display-Time Lifecycle Notifications

/**
 * Callback sent just before presenting an interstitial. After this method
 * finishes, the interstitial will animate on to the screen. Use this
 * opportunity to stop animations and save the state of your application in
 * case the user leaves while the interstitial is on screen (e.g. to visit the
 * App Store from a link on the interstitial).
 *
 * @param ad The IMAdInterstitial instance that will present an interstitial
 *           to the user.
 */
- (void)interstitialWillPresentScreen:(IMAdInterstitial *)ad;

/**
 * Callback Sent when an interstitial ad fails to present a full screen to the
 * user. This will generally occur if an interstitial is not in the
 * kIMAdInterstitialStateReady state. See IMAdInterstitial.h for list of states.
 *
 * @note An interstitial ad can be shown only once. After dismissal, you must
 *         call loadRequest: again and wait for this ad request to succeed.
 * @param ad The IMAdInterstitial instance that failed to present the
 *           interstitial screen.
 * @param error The error that occurred during loading.
 */
- (void)interstitial:(IMAdInterstitial *)ad
    didFailToPresentScreenWithError:(IMAdError *)error;

/**
 * Callback sent before the interstitial is to be animated off the screen.
 * @param ad The IMAdInterstitial instance that will dismiss the interstitial
 *           screen.
 */
- (void)interstitialWillDismissScreen:(IMAdInterstitial *)ad;

/**
 * Callback sent just after dismissing an interstitial and it has animated off
 * the screen.
 *
 * @param ad The IMAdInterstitial instance that dismissed the interstitial
 *           screen.
 */
- (void)interstitialDidDismissScreen:(IMAdInterstitial *)ad;

/**
 * Callback sent just before the application goes into the background because
 * the user clicked on a link in the ad that will launch another application
 * (such as the App Store). The normal UIApplicationDelegate methods like
 * applicationDidEnterBackground: will immediately be called after this.
 *
 * @param ad The IMAdInterstitial instance that is launching another application.
 */
- (void)interstitialWillLeaveApplication:(IMAdInterstitial *)ad;

@end
