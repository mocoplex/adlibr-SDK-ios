
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IMAdRequest.h"
#import "IMAdError.h"
#import "IMAdInterstitialDelegate.h"

/**
 * IMAdInterstitial.h
 * @description An interstitial ad. This is a full-screen advertisement shown at natural
 * transition points in your application, such as between game levels or news stories.
 * @note Interstitials are shown sparingly. Expect low to no fill.
 * @author: InMobi
 * Copyright (c) 2012 InMobi Pte Limited. All rights reserved.
 */

@interface IMAdInterstitial : NSObject
    
typedef enum {
    /**
     * The default state of an interstitial.
     * If an interstitial ad request fails, or if the user dismisses the interstitial,
     * the state will be changed back to init.
     */
	kIMInterstitialAdStateInit,
    /**
     * Indicates that an interstitial ad request is in progress.
     */
    kIMInterstitialAdStateLoading,
    /**
     * Indicates that an interstitial ad is ready to be displayed.
     * An interstitial ad can be displayed only if the state is ready.     
     * You can call presentFromRootViewController: to display this ad.
     */
    kIMInterstitialAdStateReady,
    /**
     * Indicates that an interstitial ad is displayed on the user's screen.
     */
    kIMInterstitialAdStateActive
    
} InterstitialState;

/**
 * You can obtain your App ID in the Publisher section by logging in to www.inmobi.com. 
 * @description must be not-null.
 */
@property ( nonatomic, copy) NSString *imAppId;
/**
 * Optional delegate object that receives state change notifications from this interstitial object.
 * Typically this is a UIViewController instance.
 * Set the delegate property of this object to nil in the dealloc method of your UIViewController.
 - (void)dealloc {
 imAdInterstitial.delegate = nil;
 [imAdInterstitial release]; imAdInterstitial = nil;
 [super dealloc];
 *   }
 */
@property ( nonatomic, assign) id<IMAdInterstitialDelegate> delegate;

#pragma mark Ad Request methods

/**
 * Makes an interstitial ad request.
 * This is best to do several seconds before the interstitial is needed to
 * preload its content.  
 * @param request - The ad request which will be loaded. Additional targeting options can be supplied with a request object.
 * @note - Show the interstitial by calling the presentFromRootViewController: method.
 */

- (void)loadRequest:(IMAdRequest *)request;

#pragma mark Post-Request

/**
 * Returns the state of the interstitial ad. The delegate's
 * interstitialDidFinishRequest: will be called when this switches from the kIMInterstitialAdStateInit state  
 * to the kIMInterstitialAdStateReady state.
 * 
 */

@property (nonatomic,assign,readonly) InterstitialState state;

/**
 * Presents the interstitial ad that takes over the entire screen until the
 * user dismisses it.  
 * This has no effect unless interstitialState returns kIMInterstitialAdStateReady and/or the delegate's interstitialDidReceiveAd: has been received.
 * @param _rootViewController - The current view controller at the time this method is called.
 * @note - After the interstitial has been removed, the delegate's
 * interstitialDidDismissScreen: will be called.
 */

- (void)presentFromRootViewController:(UIViewController *)rootViewController;

@end

