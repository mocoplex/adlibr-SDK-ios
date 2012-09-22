//
//  IMAdDelegate.h
//  InMobi AdNetwork SDK
//
//  Copyright 2012 InMobi Technology Services Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IMAdView;
@class IMAdError;

/**
 * This is the delegate for receiving state change messages from an IMAdView.
 * Use this to receive callbacks for banner ad request succeeding, failing or
 * for the events after the banner ad is clicked.
 */
@protocol IMAdDelegate <NSObject>

@optional

#pragma mark Ad Request Lifecycle Notifications

/**
 * Callback sent when an ad request loaded an ad. This is a good opportunity
 * to add this view to the hierarchy if it has not yet been added.
 *
 * @param adView The IMAdView instance which finished loading the ad request.
 */
- (void)adViewDidFinishRequest:(IMAdView *)adView;

/**
 * Callback sent when an ad request failed. Normally this is because no network
 * connection was available or no ads were available (i.e. no fill).
 *
 * @param adView The IMAdView instance that failed to load the ad request.
 * @param error The error that occurred during loading.
 */
- (void)adView:(IMAdView *)adView didFailRequestWithError:(IMAdError *)error;

#pragma mark Click-Time Lifecycle Notifications

/**
 * Callback sent just before when the adView is presenting a full screen view
 * to the user. Use this opportunity to stop animations and save the state of
 * your application in case the user leaves while the full screen view is on
 * screen (e.g. to visit the App Store from a link on the full screen view).
 *
 * @param adView The IMAdView instance that presents the screen.
 */
- (void)adViewWillPresentScreen:(IMAdView *)adView;

/**
 * Callback sent just before dismissing the full screen view.
 *
 * @param adView The IMAdView instance that dismisses the screen.
 */
- (void)adViewWillDismissScreen:(IMAdView *)adView;

/**
 * Callback sent just after dismissing the full screen view.
 * Use this opportunity to restart anything you may have stopped as part of
 * adViewWillPresentScreen: callback.
 *
 * @param adView The IMAdView instance that dismissed the screen.
 */
- (void)adViewDidDismissScreen:(IMAdView *)adView;

/**
 * Callback sent just before the application goes into the background because
 * the user clicked on a link in the ad that will launch another application
 * (such as the App Store). The normal UIApplicationDelegate methods like
 * applicationDidEnterBackground: will immediately be called after this.
 *
 * @param adView The IMAdView instance that is launching another application.
 */
- (void)adViewWillLeaveApplication:(IMAdView *)adView;

@end
