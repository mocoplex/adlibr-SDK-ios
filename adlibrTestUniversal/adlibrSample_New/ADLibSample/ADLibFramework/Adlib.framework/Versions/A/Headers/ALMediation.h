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
 *  이 클래스는 애드립 배너 미디에이션을 구현하는 어뎁터 클래스들의 기본 구현 부모 클래스이다.
 *  띠배너와 전면 배너 미디에이션 구현에 필요한 프로토콜을 상속받고 있으며, 서브 클래스들 또한 해당
 *  프로토콜을 상속해야한다.
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

