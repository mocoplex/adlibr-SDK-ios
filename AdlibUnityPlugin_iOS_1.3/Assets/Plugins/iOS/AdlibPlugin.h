//
//  AdlibPlugin.h
//  adlibrTestUniversal
//
//  Created by Hana Kim on 2014. 2. 9..
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Adlib/Adlib.h>

@interface AdlibPlugin : NSObject<AdlibManagerDelegate> {
@private
    // Value set by the Unity script to indicate whether the ad is to be
    // positioned at the top or bottom of the screen.
    BOOL positionAdAtTop_;
    BOOL attachedLink_;
}

@property(nonatomic, assign) UIViewController *viewController;
@property(nonatomic, retain) NSString *callbackHandlerName;

+ (AdlibPlugin *)pluginSharedInstance;

- (void)initializeWithAds:(NSString*) adlibKey;
- (void)showBannerPositionAtTop:(BOOL)positionAtTop;
- (void)hideBanner;
- (void)loadInterstitialAd;

@end