//
//  ALMediation.h
//  Adlib
//
//  Created by gskang on 2016. 4. 19..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ALMediationDefine.h"
#import "ALInterstitialAd.h"
#import "ALAdBannerView.h"

/**
 *  이 클래스는 구버전 AdlibManager 클래스를 대체하기 위한 클래스이다.
 *  AdlibManager는 싱글톤 객체로 설계되어 단일 객체로 사용 시 발생할 수 있는 문제가 있으며,
 *  따라서 AdlibRenew 폴더 내부의 클래스들로 대체하여 사용하는 방법을 제공한다.
 */

@interface ALMediation : NSObject <ALMediationInterstitialProtocol, ALMediationBannerProtocol> {
    
}

//광고 플랫폼의 타입값
@property (nonatomic) ALMEDIATION_PLATFORM mediationPlatform;

//광고 플랫폼에서 발급받은 띠 배너 키
@property (nonatomic, copy) NSString *adPlatformBannerKey;

//광고 플랫폼에서 발급받은 전면 배너 키
@property (nonatomic, copy) NSString *adPlatformInterstitialKey;

//루트 뷰 컨트롤러
@property (nonatomic, weak) UIViewController *rootViewController;

@property (nonatomic, weak) ALInterstitialAd *interstitialAd;
@property (nonatomic, weak) ALAdBannerView   *bannerContainerView;

// Mediation subClass
+ (BOOL)registerPlatform:(ALMEDIATION_PLATFORM)ptype withClass:(Class)className;
+ (Class)classForPlatform:(NSNumber *)ptype;

@end

