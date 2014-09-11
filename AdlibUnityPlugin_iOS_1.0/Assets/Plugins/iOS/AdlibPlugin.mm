//
//  AdlibPlugin.m
//  adlibrTestUniversal
//
//  Created by Hana Kim on 2014. 2. 9..
//
//

#import <Foundation/Foundation.h>
#import "AdlibPlugin.h"
#import <Adlib/Adlib.h>
#import "SubAdlibAdViewAdam.h"
#import "SubAdlibAdViewAdmob.h"
#import "SubAdlibAdViewCauly.h"
#import "SubAdlibAdViewTAD.h"
#import "SubAdlibAdViewiAd.h"
#import "SubAdlibAdViewNaverAdPost.h"
#import "SubAdlibAdViewShallWeAd.h"
#import "SubAdlibAdViewInmobi.h"
#import "SubAdlibAdViewDomob.h"
#import "SubAdlibAdViewAdHub.h"
#import "SubAdlibAdViewUPlusAD.h"
#import "SubAdlibAdViewMedibaAd.h"
#import "SubAdlibAdViewMMedia.h"
#import <MillennialMedia/MMSDK.h>

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
    attachedLink_ = NO;
    
    return self;
}

- (void)initializeWithAds:(NSString*) adlibKey {
    
    self.viewController = UnityGetGLViewController();
    
    [[AdlibManager sharedSingletonClass] initAdlib:adlibKey];
    
    // 쓰지 않을 광고 플랫폼은 삭제해주세요.
    [[AdlibManager sharedSingletonClass] setPlatform:@"ADAM" withClass:[SubAdlibAdViewAdam class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"ADMOB" withClass:[SubAdlibAdViewAdmob class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"CAULY" withClass:[SubAdlibAdViewCauly class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"TAD" withClass:[SubAdlibAdViewTAD class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"IAD" withClass:[SubAdlibAdViewiAd class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"NAVER" withClass:[SubAdlibAdViewNaverAdPost class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"SHALLWEAD" withClass:[SubAdlibAdViewShallWeAd class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"INMOBI" withClass:[SubAdlibAdViewInmobi class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"DOMOB" withClass:[SubAdlibAdViewDomob class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"ADHUB" withClass:[SubAdlibAdViewAdHub class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"UPLUSAD" withClass:[SubAdlibAdViewUPlusAD class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"MEDIBAAD" withClass:[SubAdlibAdViewMedibaAd class]];
    [[AdlibManager sharedSingletonClass] setPlatform:@"MMEDIA" withClass:[SubAdlibAdViewMMedia class]];
    [MMSDK initialize];  // MillennialMedia v5.2.0 이상을 사용하시려면 반드시 초기화를 호출해 주세요.
}

- (void)showBannerPositionAtTop:(BOOL)positionAtTop useHouseBanner:(BOOL)useHouseBanner {
    
    positionAdAtTop_ = positionAtTop;
    [[AdlibManager sharedSingletonClass] attach:self.viewController
                                       withView:self.viewController.view
                                   withDelegate:self
                                    defaultSize:CGSizeMake(320,50)
                                   defaultAlign:ADLIB_ALIGN_CENTER
                                 useHouseBanner:useHouseBanner];
}

- (void)hideBanner {
    
    [[AdlibManager sharedSingletonClass] detach:self.viewController];
}

- (void)loadInterstitialAd {
    
    [[AdlibManager sharedSingletonClass] loadInterstitialAd:self.viewController withDelegate:self];
}

- (void)showPopBannerFrameColor:(NSString*)frameColor btnColor:(NSString*)btnColor
                      useInAnim:(BOOL)inAnim useOutAnim:(BOOL)outAnim
                          align:(NSString*)align padding:(int)padding {
    
    AdlibPopBtnStyle btnStyle = [self AdlibPopBtnStyleFromString:btnColor];
    AdlibPopAnimationType inType = [self AdlibPopAnimationTypeFromBOOL:inAnim];
    AdlibPopAnimationType outType = [self AdlibPopAnimationTypeFromBOOL:outAnim];
    AdlibPopAlign alignType = [self AdlibPopAlignFromString:align];
    
    // pop banner 설정 및 호출
    [[AdlibManager sharedSingletonClass] setAdlibPopFrameColor:[self colorFromARGB:frameColor]];
    [[AdlibManager sharedSingletonClass] setAdlibPopCloseButtonStyle:btnStyle];
    [[AdlibManager sharedSingletonClass] setAdlibPopInAnimation:inType outAnimation:outType];
    [[AdlibManager sharedSingletonClass] showAdlibPopBanner:alignType withPadding:padding withDelegate:self];
}

- (void)hidePopBanner {
    
    [[AdlibManager sharedSingletonClass] hideAdlibPopBanner];
}

- (void)showRewardLinkId:(NSString*)linkId posX:(int)posX posY:(int)posY {
    
    if(!attachedLink_)
    {
        [[AdlibRewardLink sharedSingletonClass] attachRewardLink:self.viewController withView:self.viewController.view];
        attachedLink_ = YES;
    }
    
    CGPoint point = CGPointMake(posX, posY);
    [[AdlibRewardLink sharedSingletonClass] addRewardLinkIcon:linkId atPoint:point];
}

- (void)hideRewardLink {
    
    [[AdlibRewardLink sharedSingletonClass] detachRewardLink:self.viewController];
    attachedLink_ = NO;
}

- (AdlibPopBtnStyle)AdlibPopBtnStyleFromString:(NSString *)string {
    if ([string isEqualToString:@"BLACK"]) {
        return AdlibPopBtnStyleBlack;
    } else {
        return AdlibPopBtnStyleWhite;
    }
}

- (AdlibPopAnimationType)AdlibPopAnimationTypeFromBOOL:(BOOL)use {
    if (use) {
        return AdlibPopAnimationTypeSlide;
    } else {
        return AdlibPopAnimationTypeNone;
    }
}

- (AdlibPopAlign)AdlibPopAlignFromString:(NSString *)string {
    if ([string isEqualToString:@"LEFT"]) {
        return AdlibPopAlignLeft;
    } else if ([string isEqualToString:@"TOP"]) {
        return AdlibPopAlignTop;
    } else if ([string isEqualToString:@"RIGHT"]) {
        return AdlibPopAlignRight;
    } else {
        return AdlibPopAlignBottom;
    }
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

// 광고를 수신했다. 광고view 의 크기와 위치를 재설정한다.
- (void)gotAd
{
    CGPoint adPoint = CGPointMake(0, 0);
    CGRect rt = self.viewController.view.frame;
    
    // 광고 view의 크기
    CGSize sz = [[AdlibManager sharedSingletonClass] size];
    
    if(positionAdAtTop_)
    {
        // 상단에 광고 위치
        rt = CGRectMake(0, sz.height, rt.size.width, self.viewController.view.bounds.size.height-sz.height);
    }
    else
    {
        // 하단에 광고 위치
        rt = CGRectMake(0, 0, rt.size.width, self.viewController.view.bounds.size.height-sz.height);
        adPoint = CGPointMake(0, self.viewController.view.bounds.size.height-sz.height);
    }
    
    [[AdlibManager sharedSingletonClass] moveAdContainer:adPoint];
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

//pop banner delegate:optional
-(void)didReceiveAdlibPopAd
{
    UnitySendMessage([callbackHandlerName_ UTF8String],
                     "OnReceivedPopBanner",
                     "");
}

-(void)didFailToReceiveAdlibPopAd
{
    UnitySendMessage([callbackHandlerName_ UTF8String],
                     "OnFailedToReceivePopBanner",
                     "");
}

-(void)didCloseAdlibPopAd
{
    UnitySendMessage([callbackHandlerName_ UTF8String],
                     "OnClosedPopBanner",
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
    
    void _ShowBanner(bool positionAtTop,
                     bool useHouseBanner) {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin showBannerPositionAtTop:(BOOL)positionAtTop useHouseBanner:(BOOL)useHouseBanner];
    }
    
    void _HideBanner() {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin hideBanner];
    }
    
    void _LoadInterstitialAd() {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin loadInterstitialAd];
    }
    
    void _ShowPopBanner(const char *frameColor,
                        const char *btnColor,
                        bool inAnim,
                        bool outAnim,
                        const char *align,
                        int padding) {
        AdlibPlugin *adlibPlugin = [AdlibPlugin  pluginSharedInstance];
        [adlibPlugin showPopBannerFrameColor:CreateNSString(frameColor)
                                    btnColor:CreateNSString(btnColor)
                                   useInAnim:inAnim
                                  useOutAnim:outAnim
                                       align:CreateNSString(align)
                                     padding:padding];
    }
    
    void _HidePopBanner() {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin hidePopBanner];
    }
    
    void _ShowRewardLink(const char *linkId,
                         int posX,
                         int posY) {
        AdlibPlugin *adlibPlugin = [AdlibPlugin  pluginSharedInstance];
        [adlibPlugin showRewardLinkId:CreateNSString(linkId)
                                 posX:posX
                                 posY:posY];
    }
    
    void _HideRewardLink() {
        AdlibPlugin *adlibPlugin = [AdlibPlugin pluginSharedInstance];
        [adlibPlugin hideRewardLink];
    }
}