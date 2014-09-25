//
//  AdlibAdView.h
//  adlibrTestUniversal
//
//  Created by Hana Kim on 2014. 3. 17..
//
//

#import <UIKit/UIKit.h>

@protocol AdlibAdViewDelegate;

@interface AdlibAdView : UIView {
    UIViewController *superViewController;
    NSString *adlibKey;
    id<AdlibAdViewDelegate> delegate;
}

@property (nonatomic, retain) UIViewController *superViewController;
@property (nonatomic, retain) NSString *adlibKey;
@property (nonatomic, retain) id <AdlibAdViewDelegate> delegate;

- (void)startAd;
- (void)stopAd;

@end

@protocol AdlibAdViewDelegate <NSObject>
@optional

- (void)didReceiveAdlibAd;
- (void)didFailToReceiveAdlibAd;

@end
