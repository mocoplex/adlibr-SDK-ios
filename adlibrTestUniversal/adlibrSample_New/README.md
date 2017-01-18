# ADLib iOS SDK 적용 가이드
애드립 iOS SDK를 사용하여 애드립 광고를 노출하는 방법을 제공합니다.<br>
또한 기타 광고 플랫폼을 사용하여 미디에이션 기능을 사용하는 방법을 제공합니다.

---
### SDK 지원 Version
* 신규버전 v4.200 이상부터 미디에이션 신규클래스 사용 가능

### 지원 광고 플랫폼
* adlib / adlib-house 
* google admob
* facebook audience network
* inmobi
* adam adfit
* cauly v.3.1
* admixer v.1.3.1

### 개발환경
Adlib SDK version : v.4.201 <br>
Base SDK : iOS 7.0 이상<br>
iOS Deployment Target : iOS 7.0 이상
<br><br>

### SDK 4.1 버전 가이드
SDK 4.2 버전 이전의 가이드는 아래 사이트 링크에서 확인 가능합니다. <br>
프로젝트 설정 및 SDK 추가 가이드는 해당 페이지를 통해서 더 상세하게 확인하실 수 있습니다.<br>
[SDK 4.1 버전 가이드 링크](http://developer.adlibr.com/ssp_ios_guide.html)
<br>
* 신규 미디에이션 기능은 4.200 버전 이상부터 사용가능하며, 기존 미디에이션 적용방법은 계속 지원됩니다.
<br><br>

### iOS9 [ATS(App Transport Security)](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/) 처리

iOS9 이후 부터 ATS(App Transport Security) 기능이 기본으로 설정됩니다. <br><br>
Application Info.plist 파일의 해당 항목을 설정을 하지않을 경우 광고가 차단되어 정상적으로 노출되지 않을 수 있습니다. <br> (현재 애드립과 연동된 모든 플랫폼이 https를 지원하지 않는 상황으로 해당 설정이 반드시 필요합니다.)

```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
<br><br>
### ADLib SDK 설치 방법
#### 단계1. ADLibFramework 폴더 추가
ADLibFramework 폴더를 프로젝트에 추가합니다. <br>
해당 폴더에는 애드립 SDK 연동에 필요한 파일들을 포함되어있습니다. (Adlib.framework 파일 및  리소스 파일)

#### 단계2. ADLibAdapter 폴더 추가 
미디에이션을 사용할 경우 프로젝트에 추가 후 사용하실 미디에이션 플랫폼 어뎁터를 제외하고 나머지 파일들은 제거합니다.
#### 단계3. 광고 플랫폼 미디에이션 라이브러리 추가
미디에이션을 사용할 경우 프로젝트에 추가할 광고 플랫폼의 라이브러리 파일을 추가합니다. <br>
Ex.) GoogleMobileAds.framework

<br><br>
### 프로젝트 설정 및 라이브러리 import
#### 단계1. Other Linker Flags 설정 : -ObjC 
Project - Build Settings 항목에 Other Linker Flags 추가가 필요합니다.
Linking - Other Linker Flags 항목에 -ObjC 를 추가합니다.

#### 단계2.  TARGET  Build Phases 항목에 Library 추가
프로젝트 TARGET 설정의 Build Phases 항목 Link Binary With Libraries 탭에 SDK 필요한 아래 라이브러리를 추가합니다. <br><br>
* libxml2.2.tbd <br>
* libstdc++.6.0.0.tbd <br>

<br><br>
### 애드립 배너 연동 ( 띠 배너)
#### 단계1. 배너 연동을 위한 초기화
<br>
애드립 배너를 연동할 ViewController에 애드립 배너 delegate를 선언하고, 애드립 배너 객체들을 선언합니다.

``` objectivec
#import "AdlibSampleController.h"
#import <Adlib/ADLibBanner.h>

#define ADLIB_APP_KEY @"550787410cf2833XXXXXXX" 

@interface AdlibSampleController () <ALInterstitialAdDelegate, ALAdBannerViewDelegate>

@property (nonatomic) IBOutlet ALAdBannerView *bannerView;
@property (nonatomic, strong) ALInterstitialAd *interstitialAd;

@end

@implementation AdlibSampleController
...
@end
```

#### 단계2. 띠 배너 광고 요청 시작
<br>
광고를 호출할 시점에 하단 코드처럼 요청 시작 메소드를 호출합니다.

``` objectivec
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //테스트 모드를 설정할 수 있습니다.
    _bannerView.isTestMode = YES;
    
    //광고 호출 완료 후 설정된 시간 이후 자동 갱신 요청 여부를 설정합니다.
    _bannerView.repeatLoop = NO;
    
    /**
     *  배너 광고를 요청한다.
     *  요청한 애드립 키값에 해당하는 띠배너 광고 플랫폼들에 대해서 순차적으로 광고를 요청하고 성공/실패 시 콜백을 호출한다.
     *
     *  @param key : 애드립 앱키
     *  @param rootViewController : 광고를 호출하는 뷰컨트롤러
     *  @param delegate : 광고 요청 및 수신 상태에 대한 델리게이트
     */
    [_bannerView startAdViewWithKey:ADLIB_APP_KEY
                 rootViewController:self
                         adDelegate:self];
}
```

#### 단계3. 띠 배너 광고 요청 중단
<br>
광고 호출을 중단할 시점에 하단 코드처럼 메소드를 호출합니다.

``` objectivec
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_bannerView stopAdView];
} 
```
#### 단계4. 띠 배너 광고 Delegate 처리
<br>
ALAdBannerViewDelegate 프로토콜을 구현한 delegate를 아래와 같이 구현하고, 광고 수신 성공 / 실패 여부를 확인할 수 있습니다.

``` objectivec
/**
 *  띠 배너 광고요청 재개 상태에서 내부적인 상태 변화를 통지합니다.
 */
- (void)alAdBannerView:(ALAdBannerView *)bannerView didChangeState:(ALMEDIAION_STATE)state withExtraInfo:(id)info
{
    NSLog(@"bannerView state : %@, info = %@", [ALMediationDefine descriptionOfState:state], info);
}

/**
 *  플랫폼에 요청한 띠배너 광고의 성공 상태를 반환합니다.
 */
- (void)alAdBannerView:(ALAdBannerView *)bannerView didReceivedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"bannerView receivedAd : %@", [ALMediationDefine nameOfPlatform:platform]);
}

/**
 *  플랫폼에 요청한 띠배너 광고의 실패 상태를 반환합니다.
 */
- (void)alAdBannerView:(ALAdBannerView *)bannerView didFailedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"bannerView failedAd : %@", [ALMediationDefine nameOfPlatform:platform]);
    
}

/**
 *  플랫폼에 요청한 띠배너 광고의 실패 상태를 반환합니다.
 *  반환값 BackFill 뷰 사용여부, 모든 플랫폼 광고요청이 실패한 경우 노출할 뷰를 지정하여 사용할 수 있습니다.
 */
- (BOOL)alAdBannerViewDidFailedAtAllPlatform:(ALAdBannerView *)bannerView
{
    NSLog(@"bannerView failed all-platform");
    
    //해당 델리게이트에서 애드립 플랫폼에 등록된 광고의 모두 실패 상태를 처리할 수 있습니다.
    //등록된 플랫폼 스케쥴이 (애드립, 애드몹, 애드핏)인 경우 각 각 요청 후 모두 실패한 케이스의 상황
    //해당 상황에 특별한 처리를 하지 않으면 광고 영역이 공백으로 노출될 수 있으며 뷰의 repeatLoop의 값에 따라
    //일정 시간 (초)대기후 첫 플랫폼 부터 재호출 되거나 요청이 더이상 발생하지 않는 상태로 남아있다.

    return YES;
}

```

<br><br>

### 애드립 배너 연동 (전면 배너)
#### 단계1. 전면광고 요청
<br>
전면광고를 요청할 시점에 다음과 같이 처리합니다.

```objectivec
- (IBAction)requestIntersAd:(id)sender
{
    ALInterstitialAd *interstitialAd = [[ALInterstitialAd alloc] initWithRootViewController:self];
    self.interstitialAd = interstitialAd;
    
    interstitialAd.isTestMode = YES;
    
    [_interstitialAd requestAdWithKey:ADLIB_APP_KEY adDelegate:self];
}
```

#### 단계2. 전면광고 요청 취소
<br>
전면광고 요청 도중 취소하기 위해서는 아래와 같이 처리합니다.

``` objectivec
- (void)cancelInterstitialAdRequest
{
    if (_interstitialAd) {
        [_interstitialAd stopAdReqeust];
    }
}
```

#### 단계3. 전면광고 Delegate 처리
<br>
ALInterstitialAdDelegate 프로토콜을 구현한 delegate를 아래와 같이 구현하고, 광고 수신 성공 / 실패 여부를 확인할 수 있습니다.

```objectivec
/**
 *  전면광고 요청이 성공에 대한 알림
 */
- (void)alInterstitialAd:(ALInterstitialAd *)interstitialAd didReceivedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"didReceivedAdAtPlatform : %zd", platform);
}

/**
 * *  전면광고 요청 실패에 대한 알림
 */
- (void)alInterstitialAd:(ALInterstitialAd *)interstitialAd didFailedAdAtPlatform:(ALMEDIATION_PLATFORM)platform
{
    NSLog(@"didFailedAdAtPlatform : %zd", platform);
}

/**
 *  모든 전면광고 요청 실패에 대한 알림
 */
- (void)alInterstitialAdDidFailedAd:(ALInterstitialAd *)interstitialAd
{
    NSLog(@"alInterstitialAdDidFailedAd");
}
```

<br><br>
### 애드립 미디에이션 연동
미디에이션을 연동하기 위해서는 위 애드립 광고 연동과 동일과정을 수행하나 추가로
미디에이션 플랫폼 등록 및 해당 플랫폼에 필요한 광고 키 값을 등록하는 추가 과정이 필요합니다.

#### 단계1. 미디에이션 플랫폼 추가 (초기화 단계)
<br>
사용할 미디에이션 플랫폼에 해당하는 어뎁터 클래스를 선언하고, 해당 플랫폼에서 발급 받은 광고 키값을 미리 정의합니다.

```objectivec
#import "MediationSampleController.h"

#import <Adlib/ADLibBanner.h>
#import "ALAdapterAdmob.h"
#import "ALAdapterCauly.h"


//애드립의 키값을 설정합니다.
#define ADLIB_APP_KEY @"54caefb80cf28dexxxxxxxxx" //adlib, admob, cauly

// ADMOB의 APP 아이디를 설정합니다.
#define ADMOB_ID @"ca-app-pub-2656860633xxxxx/28382xxxx"
#define ADMOB_INTERSTITIAL_ID @"ca-app-pub-xxxxxx"

// CAULY의 키값을 설정합니다.
#define CAULY_ID        @"CAULY"


@interface MediationSampleController () <ALInterstitialAdDelegate, ALAdBannerViewDelegate>

@property (nonatomic) IBOutlet ALAdBannerView *bannerView;
@property (nonatomic, strong) ALInterstitialAd *interstitialAd;

@end

@implementation MediationSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 미디에이션 플랫폼 등록
    [ALMediation registerPlatform:ALMEDIATION_PLATFORM_ADMOB withClass:[ALAdapterAdmob class]];
    [ALMediation registerPlatform:ALMEDIATION_PLATFORM_CAULY withClass:[ALAdapterCauly class]];
    
}
@end
```
<br><br>

#### 단계2. 미디에이션 띠 배너 요청
<br>
기본적으로는 위에서 설명한 애드립 띠배너 요청과 동일하나 추가로 광고 키값 설정 코드가 필요합니다.

```objectivec
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 미디에이션 플랫폼 띠배너 키설정
    [_bannerView setKey:ADMOB_ID forPlatform:ALMEDIATION_PLATFORM_ADMOB];
    [_bannerView setKey:CAULY_ID forPlatform:ALMEDIATION_PLATFORM_CAULY];
    
    _bannerView.isTestMode = YES;
    _bannerView.repeatLoop = NO;
    
    [_bannerView startAdViewWithKey:ADLIB_APP_KEY
                 rootViewController:self
                         adDelegate:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_bannerView stopAdView];
}
```

<br><br>
#### 단계2. 미디에이션 전면 배너 요청
<br>
기본적으로는 위에서 설명한 애드립 전면 배너 요청과 동일하나 추가로 광고 키값 설정 코드가 필요합니다.

```objectivec
- (IBAction)requestIntersAd:(id)sender
{
    ALInterstitialAd *interstitialAd = [[ALInterstitialAd alloc] initWithRootViewController:self];
    self.interstitialAd = interstitialAd;
    
    //미디에이션 플랫폼 전면배너 키설정
    [_interstitialAd setKey:ADMOB_INTERSTITIAL_ID forPlatform:ALMEDIATION_PLATFORM_ADMOB];
    [_interstitialAd setKey:CAULY_ID forPlatform:ALMEDIATION_PLATFORM_CAULY];
    
    [_interstitialAd requestAdWithKey:ADLIB_APP_KEY adDelegate:self];
}
```

<br><br>





