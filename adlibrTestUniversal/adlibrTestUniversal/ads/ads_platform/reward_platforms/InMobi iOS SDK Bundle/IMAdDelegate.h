


#import <Foundation/Foundation.h>
@class IMAdView;
@class IMAdError;

/**
 * IMAdDelegate.h
 * @description Defines the IMAdDelegate protocol.
 * @author: InMobi
 * Copyright (c) 2012 InMobi Pte Limited. All rights reserved.
 */
@protocol IMAdDelegate <NSObject>
 
@optional

#pragma mark Ad Request Lifecycle Notifications
 
/**
 * Sent when an ad request loaded an ad. This is a good opportunity to add this
 * view to the hierarchy if it has not yet been added.
 * @param view - The IMAdView which finished loading the ad request.
 */

- (void)adViewDidFinishRequest:(IMAdView *)adView;

/**
 * Sent when an ad request failed. Normally this is because no network
 * connection was available or no ads were available, that is, a no fill. If the
 * error was received as a part of the server-side auto refresh, you can
 * examine the hasAutoRefreshed property of the view.
 * @param view - The IMAdView that failed to load the ad request.
 * @param error - The error that occurred during loading.
 */

- (void)adView:(IMAdView *)view
didFailRequestWithError:(IMAdError *)error;


#pragma mark Click-Time Lifecycle Notifications

/**
 * Sent just before the adview presents a full screen view to the user.
 * Use this opportunity to stop animations and save the state of your application.
 * @param adView - The adview that presents the screen.
 */
- (void)adViewWillPresentScreen:(IMAdView *)adView;

/**
 * Sent just before dismissing a full screen view.
 * @param adView - The adview that dismisses the screen.
 */
- (void)adViewWillDismissScreen:(IMAdView *)adView;

/**
 * Sent just after dismissing a full screen view. Use this opportunity to
 * restart anything you may have stopped as part of adViewWillPresentScreen:.
 * @param adView - The adview that dismisses the screen.
 */
- (void)adViewDidDismissScreen:(IMAdView *)adView;

/**
 * Sent just before the application goes into the background, or terminates 
 * because the user clicked on an ad that will launch another application 
 * (such as the App Store).
 * @param adView - The adview that launches another application.
 * @note - The normal UIApplicationDelegate methods, like
 * applicationDidEnterBackground:, will be called immediately after this.
 */

- (void)adViewWillLeaveApplication:(IMAdView *)adView;

@end

