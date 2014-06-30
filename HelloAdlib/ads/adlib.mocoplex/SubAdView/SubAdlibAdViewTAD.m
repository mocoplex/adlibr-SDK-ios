/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with t-ad SDK 3.3.5.6
 */

#import "SubAdlibAdViewTAD.h"

// Tad를 사용할 경우 Tad의 library에 JSONKit이 포함되어 있으므로 애드립 lib 폴더의 JSONKit을 삭제하세요.

// TAD의 APP 아이디를 설정합니다.
#define TAD_ID @"T_AD"
#define TAD_INTERSTITIAL_ID @"T_AD_INTERSTITIAL"

@implementation SubAdlibAdViewTAD

- (void)query:(UIViewController*)parent
{
    [super query:parent];

    ad = [[TadCore alloc] initWithSeedView:self.view delegate:self];
    //필수 사항
    [ad setClientID:TAD_ID];       // 클라이언트 아이디
    [ad setSlotNo:TadSlotInline];  // 슬롯 설정
    [ad setSeedViewController:parent]; // 광고가 표시되는 ViewController를 전달
    
    // 선택 셋팅 사항
    [ad setIsTest:NO];                               // YES : 테스트 서버, NO : 상용 서버 (Default : YES)
    [ad setOffset:CGPointMake(0.0f, 0.0f)];          // 광고의 오프셋을 결정한다. (Default 0.0)
    [ad setRefershInterval:30.0f];                   // 광고 재요청 시간 간격을 설정한다. 15~60초 (Default : 20)
    [ad setLogMode:NO];                              // 로그를 보여줄지 아닐지 결정 (Default : NO)
    [ad getAdvertisement];
}

- (void)clearAdView
{
    [super clearAdView];
    if(ad != nil)
    {
        [ad destroyAd];
        [ad release];
        ad = nil;
    }
}

#pragma mark - TadDelegate

- (void)tadOnAdLoaded:(TadCore *)tadCore {
    //광고 로드 완료
    [self gotAd];
    bGotAd = YES;
}

- (void)tadOnAdClicked:(TadCore *)tadCore {
    //NSLog(@"<Tad> 광고 클릭");
}

- (void)tadCore:(TadCore *)tadCore tadOnAdFailed:(TadErrorCode)errorCode {
    
    // 실패했다. 바로 다음 스케줄 광고를 보인다.
    [self failed];
    bGotAd = NO;
}

- (CGSize)size
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    int w;
    if([self isPortrait])
    {
        w = screenWidth;
    }
    else
    {
        w = screenHeight;
    }
    
    return CGSizeMake(w, 50);
}

+ (void)loadInterstitail:(UIViewController*)viewController
{
    TadCore *interstitial = [[TadCore alloc] initWithSeedView:viewController.view delegate:self];
    //필수 사항
    [interstitial setClientID:TAD_INTERSTITIAL_ID];       // 클라이언트 아이디
    [interstitial setSlotNo:TadSlotInterstitial];  // 슬롯 설정
    
    // 선택 셋팅 사항
    [interstitial setIsTest:YES];                               // YES : 테스트 서버, NO : 상용 서버 (Default : YES)
    [interstitial setOffset:CGPointMake(0.0f, 0.0f)];          // 광고의 오프셋을 결정한다. (Default 0.0)
    [interstitial setAutoCloseWhenNoInteraction:NO];           // 전면광고 5초 후 자동 닫힘.
    [interstitial setAutoCloseAfterLeaveApplication:NO];       // 전면광고 랜딩 후 광고 닫힘.
    [interstitial setLogMode:NO];                              // 로그를 보여줄지 아닐지 결정 (Default : NO)
    [interstitial getAdvertisement];
}

+ (void)tadOnAdLoaded:(TadCore *)interstitial
{
    // 전면광고 성공을 알린다.
    [self interstitialReceived:@"tad"];
    [interstitial showAd];
}

+ (void)tadCore:(TadCore *)interstitial tadOnAdFailed:(TadErrorCode)errorCode
{
    // 전면광고 실패를 알린다.
    [self interstitialFailed:@"tad"];
}

+ (void)tadOnAdDidDismissModal:(TadCore *)interstitial
{
    // 전면광고 닫힘을 알린다.
    [self interstitialClosed:@"tad"];
}

@end
