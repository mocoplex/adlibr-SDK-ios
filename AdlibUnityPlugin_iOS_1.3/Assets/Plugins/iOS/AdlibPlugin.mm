//
//  AdlibPlugin.m
//  adlibrTestUniversal
//
//  Created by mocoplx on 2015. 6. 15..
//
//

#import <Foundation/Foundation.h>
#import "AdlibPlugin.h"
#import <Adlib/Adlib.h>
//#import "SubAdlibAdViewAdam.h"
//#import "SubAdlibAdViewAdmob.h"
//#import "SubAdlibAdViewCauly.h"
//#import "SubAdlibAdViewTAD.h"
//#import "SubAdlibAdViewiAd.h"
//#import "SubAdlibAdViewNaverAdPost.h"
//#import "SubAdlibAdViewShallWeAd.h"
//#import "SubAdlibAdViewInmobi.h"
//#import "SubAdlibAdViewDomob.h"
//#import "SubAdlibAdViewAdHub.h"
//#import "SubAdlibAdViewUPlusAD.h"
//#import "SubAdlibAdViewMedibaAd.h"
//#import "SubAdlibAdViewMMedia.h"
//#import <MillennialMedia/MMSDK.h>

@interface AdlibPlugin ()

// Root view controller for Unity applications can be accessed using this method.
extern UIViewController *UnityGetGLViewController();

@end

@implementation AdlibPlugin

@synthesize viewController = viewController_;
@synthesize callbackHandlerName = callbackHandlerName_;

#pragma mark Unity bridge

+ (AdlibPlugin *)pluginSharedInstance {
    static AdlibPlugin *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AdlibPlugin alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    self = [super init];
    if (self) {
        attachedLink_ = NO;
    }
    return self;
}

- (void)initializeWithAds:(NSString*) adlibKey {
    
    self.viewController = UnityGetGLViewController();
    
    BOOL isTestMode = YES;
    AdlibManager *adlibManager = [AdlibManager sharedSingletonClass];
    if (isTestMode) {
        [adlibManager testModeLinkWithAdlibKey:adlibKey];
    } else {
        [adlibManager linkWithAdlibKey:adlibKey];
    }
    
    
    // 쓰지 않을 광고 플랫폼은 삭제해주세요.
//    [[AdlibManager sharedSingletonClass] setPlatform:@"ADAM" withClass:[SubAdlibAdViewAdam class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"ADMOB" withClass:[SubAdlibAdViewAdmob class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"CAULY" withClass:[SubAdlibAdViewCauly class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"TAD" withClass:[SubAdlibAdViewTAD class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"IAD" withClass:[SubAdlibAdViewiAd class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"NAVER" withClass:[SubAdlibAdViewNaverAdPost class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"SHALLWEAD" withClass:[SubAdlibAdViewShallWeAd class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"INMOBI" withClass:[SubAdlibAdViewInmobi class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"DOMOB" withClass:[SubAdlibAdViewDomob class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"ADHUB" withClass:[SubAdlibAdViewAdHub class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"UPLUSAD" withClass:[SubAdlibAdViewUPlusAD class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"MEDIBAAD" withClass:[SubAdlibAdViewMedibaAd class]];
//    [[AdlibManager sharedSingletonClass] setPlatform:@"MMEDIA" withClass:[SubAdlibAdViewMMedia class]];
//    [MMSDK initialize];  // MillennialMedia v5.2.0 이상을 사용하시려면 반드시 초기화를 호출해 주세요.
}

- (void)showBannerPositionAtTop:(BOOL)positionAtTop {
    
    positionAdAtTop_ = positionAtTop;
    ADLIB_ADVIEW_VERTICAL_ALIGN vAlign;
    if (positionAtTop) {
        vAlign = ADLIB_ADVIEW_VERTICAL_ALIGN_TOP;
    } else {
        vAlign = ADLIB_ADVIEW_VERTICAL_ALIGN_BOTTOM;
    }
    AdlibManager *manager = [AdlibManager sharedSingletonClass];
    [manager attachWithViewController:self.viewController
                      atContainerView:self.viewController.view
                         withDelegate:self
                          bannerAlign:ADLIB_BANNER_ALIGN_CENTER
                          adViewAlign:vAlign];
}

- (void)hideBanner {
    
    AdlibManager *manager = [AdlibManager sharedSingletonClass];
    [manager detach:self.viewController];
}

- (void)loadInterstitialAd {

    AdlibManager *manager = [AdlibManager sharedSingletonClass];
    [manager loadInterstitialAd:self.viewController withDelegate:self];
}

-(UIColor *)colorFromARGB:(NSString*)hexString {
    
    unsigned int argb;
    [[NSScanner scannerWithString:hexString] scanHexInt:&argb];
    int blue = argb & 0xff;
    int green = argb >> 8 & 0xff;
    int red = argb >> 16 & 0xff;
    int alpha = argb >> 24 & 0xff;
    
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha/255.f];
}

//interstitial delegate:optional
- (void)didReceiveAdlibInterstitialAd:(NSString*)from
{
    UnitySendMessage([callbackHandlerName_ UTF8String],
                     "OnReceivedInterstitialAd",
                     [from UTF8String]);
}

-(void)didFailToReceiveAllInterstitialAd
{
    UnitySendMessage([callbackHandlerName_ UTF8String],
                     "OnFailedToReceiveInterstitialAd",
                     "");
}

- (void)didCloseAdlibInterstitialAd:(NSString*)from
{
    UnitySendMessage([callbackHandlerName_ UTF8String],
                     "OnClosedInterstitialAd",
                     "");
}

@end

// Helper method used to convert NSStrings into C-style strings.
NSString *CreateNSString(const char* string) {
    if (string) {
        return [NSString stringWithUTF8String:string];
    } else {
        return [NSString stringWithUTF8String:""];
    }
}

// Unity can only talk directly to C code so use these method calls as wrappers
// into the actual plugin logic.
extern "C" {
    
    void _Initialize(const char *adlibKey) {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin initializeWithAds:CreateNSString(adlibKey)];
    }
    
    void _SetCallbackHandlerName(const char *callbackHandlerName) {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin setCallbackHandlerName:CreateNSString(callbackHandlerName)];
    }
    
    void _ShowBanner(bool positionAtTop) {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin showBannerPositionAtTop:(BOOL)positionAtTop];
    }
    
    void _HideBanner() {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin hideBanner];
    }
    
    void _LoadInterstitialAd() {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin loadInterstitialAd];
    }
    
}