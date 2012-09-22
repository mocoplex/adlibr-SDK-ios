//
//  IMAdInterstitial.h
//  InMobi AdNetwork SDK
//
//  Copyright 2012 InMobi Technology Services Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IMAdRequest.h"
#import "IMAdError.h"
#import "IMAdInterstitialDelegate.h"

typedef enum {
    /**
     * The default state of an interstitial.
     * If an interstitial ad request fails, or if the user dismisses the
     * interstitial, the state will be changed back to init.
     */
	kIMAdInterstitialStateInit,
    /**
     * Indicates that an interstitial ad request is in progress.
     */
    kIMAdInterstitialStateLoading,
    /**
     * Indicates that an interstitial ad is ready to be displayed.
     * An interstitial ad can be displayed only if the state is ready.
     * You can call presentFromRootViewController: to display this ad.
     */
    kIMAdInterstitialStateReady,
    /**
     * Indicates that an interstitial ad is displayed on the user's screen.
     */
    kIMAdInterstitialStateActive

} IMAdInterstitialState;

/**
 IMAdInterstitial is the class that displays an Interstitial Ad.
 Interstitials are full screen advertisements that are shown at natural
 transition points in your application such as between game levels, when
 switching news stories, in general when transitioning from one view controller
 to another. It is best to request for an interstitial several seconds before
 when it is actually needed, so that it can preload its content and become
 ready to present, and when the time comes, it can be immediately presented to
 the user with a smooth experience.
 
 Interstitials are shown sparingly; Expect low to no fill.
 */
@interface IMAdInterstitial : NSObject {

}

/**
 Delegate object that receives state change notifications from this
 interstitial object. Typically, this is a UIViewController instance.
 @warning When releasing the adView in the dealloc method of your
 UIViewController, make sure to set its delegate to nil to prevent any chance
 of your application crashing.
    - (void)dealloc {
        imAdInterstitial.delegate = nil;
        [imAdInterstitial release]; imAdInterstitial = nil;
        [super dealloc];
    }
 */
@property (nonatomic, assign) id<IMAdInterstitialDelegate> delegate;

/**
 * App ID can be obtained in the Publisher section by logging in to
 * InMobi's website. http://www.inmobi.com
 */
@property (nonatomic, copy) NSString *imAppId;

/**
 * Slot ID is an unique identifier that identifies one slot in your app. It can
 * be obtained in the Publisher section by logging in to InMobi's website.
 */
@property (nonatomic, assign) long long imSlotId;

#pragma mark Ad Request methods

/**
 * Makes an interstitial ad request. This is best to do several seconds before
 * the interstitial is needed to preload its content. Once, it is fetched and
 * is ready to display, you can present it using presentFromRootViewController:
 * method.
 *
 * @param request The ad request which will be loaded. Additional targeting
 *                options can be supplied with a request object.
 */
- (void)loadRequest:(IMAdRequest *)request;

/**
 * Call this method to stop loading the current interstitial ad request.
 */
- (void)stopLoading;

#pragma mark Post-Request

/**
 * Returns the state of the interstitial ad. The delegate's
 * interstitialDidFinishRequest: will be called when this switches from the
 * kIMAdInterstitialStateInit state to the kIMAdInterstitialStateReady state.
 */
@property (nonatomic, assign, readonly) IMAdInterstitialState state;

/**
 * This presents the interstitial ad that takes over the entire screen until
 * the user dismisses it. This has no effect unless the interstitial state is
 * kIMAdInterstitialStateReady and/or the delegate's interstitialDidReceiveAd:
 * has been received. After the interstitial has been dismissed by the user,
 * the delegate's interstitialDidDismissScreen: will be called.
 *
 * @param rootViewController The current view controller at the time this
 *                           method is called.
 */
- (void)presentFromRootViewController:(UIViewController *)rootViewController
                             animated:(BOOL)_animated;

@end

