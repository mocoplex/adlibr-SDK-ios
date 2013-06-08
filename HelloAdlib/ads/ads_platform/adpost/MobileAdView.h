
#import <UIKit/UIKit.h>

typedef enum {
    ERROR_SUCCESS = 0,
    ERROR_AD_LOAD = 1,
    ERROR_INVALID_PARAMETER = 2,
    ERROR_NETWORK = 3,
    ERROR_INVALID_REGION = 4,
    ERROR_INVALID_STATE = 5,
    ERROR_INTERNAL = 101,
    ERROR_INVALID_REQUEST = 102,
    ERROR_NO_ADS = 103,
    ERROR_WAIT_FOR_APPROVAL = 104,
    ERROR_INVALID_MEDIA = 105,
    ERROR_INVALID_CHANNEL = 106,
    ERROR_UNKNOWN = -1,
} MobileAdErrorType;

@protocol MobileAdViewDelegate;

@interface MobileAdView : UIView <UIWebViewDelegate, UIAlertViewDelegate>{

    UIViewController *superViewController;
    NSString *channelId;
    BOOL isTest;
    BOOL useAnimation;
    
    id<MobileAdViewDelegate> delegate;
}

@property (nonatomic, retain) UIViewController *superViewController;
@property (nonatomic, retain) NSString *channelId;
@property (nonatomic, assign) BOOL isTest;
@property (nonatomic, assign) BOOL useAnimation;

@property (nonatomic, assign) id<MobileAdViewDelegate> delegate;

+ (MobileAdView *)sharedMobileAdView;
- (MobileAdErrorType)addInfoWithKey:(NSString *)key value:(NSString *)value;
- (BOOL)isAutoRefresh;
- (void)start;
- (void)stop;
- (BOOL)isAdAvailable;

@end

@protocol MobileAdViewDelegate <NSObject>

@optional

- (void)adDidReceived:(MobileAdErrorType)err;

@end