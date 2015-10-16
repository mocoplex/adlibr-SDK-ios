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
#define TAD_ID @"IXT002001"              //띠배너 테스트 ID - 고정값
#define TAD_INTERSTITIAL_ID @"IXT003001" //전면배너 테스트 ID - 고정값

#define kTAD_BANNER_SIZE CGSizeMake(320, 50)

@interface SubAdlibAdViewTAD () <TadDelegate>

@property (nonatomic, strong) TadCore *interstitial;

@end

@implementation SubAdlibAdViewTAD

+ (BOOL)isStaticObject
{
    return YES;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    if (self.tadCore == nil) {
        TadCore *ad = [[TadCore alloc] initWithSeedView:self.view delegate:self];
        self.tadCore = ad;
      
        //필수 사항
        // 테스트할 Client ID (필수 사항)
        [ad setClientID:TAD_ID];
        // 테스트할 슬롯을 설정해준다. (필수 사항)
        [ad setSlotNo:TadSlotInline];
        
        // 상용서버를 사용 할지 테스트서버를 사용 할지 결정해준다.
        [ad setIsTest:YES];
        
        [ad setSeedViewController:parent]; // 광고가 표시되는 ViewController를 전달
        
        // 선택 셋팅 사항
        //CGPoint offset = [self getTadOffSet];
        //[ad setOffset:offset];  // 광고의 오프셋을 결정한다. (Default 0.0)
        
        [ad setRefershInterval:20.0f];      // 광고 재요청 시간 간격을 설정한다. 15~60초 (Default : 20)
        [ad setIsMediation:NO];
        
        [ad setLogMode:NO];               // 로그를 보여줄지 아닐지 결정 (Default : NO)
        [ad setUseBackFillColor:YES];
    }
    
    [self queryAd];
    
    [_tadCore viewWillAppear:NO];
    [_tadCore getAdvertisement];
}

- (void)clearAdView
{
    [super clearAdView];
    
    if(_tadCore != nil)
    {
        [_tadCore viewWillDisappear:NO];
        [_tadCore destroyAd];
        _tadCore.delegate = nil;
        self.tadCore = nil;
    }
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    //[_tadCore setOffset:CGPointMake(0, 0)];
}

- (void)subAdlibViewLoadInterstitial:(UIViewController*)viewController
{
    if (self.interstitial) {
        [self.interstitial destroyAd];
        self.interstitial.delegate = nil;
        self.interstitial = nil;
    }
    
    TadCore *interstitial = [[TadCore alloc] initWithSeedView:self.view delegate:self];
    self.interstitial = interstitial;
    
    //필수 사항
    [interstitial setClientID:TAD_INTERSTITIAL_ID];             // 클라이언트 아이디
    [interstitial setSlotNo:TadSlotInterstitial];               // 슬롯 설정
    [interstitial setSeedViewController:viewController];
    
    // 선택 셋팅 사항
    [interstitial setIsTest:YES];                               // YES : 테스트 서버, NO : 상용 서버 (Default : YES)
    [interstitial setOffset:CGPointMake(0.0f, 0.0f)];          // 광고의 오프셋을 결정한다. (Default 0.0)
    [interstitial setAutoCloseWhenNoInteraction:NO];           // 전면광고 5초 후 자동 닫힘.
    [interstitial setAutoCloseAfterLeaveApplication:NO];       // 전면광고 랜딩 후 광고 닫힘.
    [interstitial setLogMode:NO];                              // 로그를 보여줄지 아닐지 결정 (Default : NO)
    [interstitial getAdvertisement];
}

- (CGPoint)getTadOffSet
{
    CGPoint pt = CGPointZero;
    CGFloat originX = (self.view.bounds.size.width - kTAD_BANNER_SIZE.width)/2;
    CGFloat originY = self.view.bounds.size.height - kTAD_BANNER_SIZE.height;
    if (originX < 0) {
        originX = 0;
    }
    if (originY < 0) {
        originY = 0;
    }
    pt = CGPointMake(originX, originY);
    
    return pt;
}

#pragma mark - TadDelegate

- (void)tadOnAdLoaded:(TadCore *)tadCore
{
    if (tadCore == self.interstitial) {
        
        if (self.interstitial.canLoadInterstitial) {
            
            // 전면광고 성공을 알린다.
            [self subAdlibViewInterstitialReceived:@"tad"];
            [self.interstitial showAd];
            
        } else {
            // 전면광고 실패를 알린다.
            [self subAdlibViewInterstitialFailed:@"tad"];
        }
        
    } else if (tadCore == self.tadCore) {
        
        //광고 로드 완료
        [self gotAd];
        bGotAd = YES;
    }
}

- (void)tadCore:(TadCore *)tadCore tadOnAdFailed:(TadErrorCode)errorCode {
    
    if (tadCore == self.interstitial) {
        NSLog(@"tadCore interstitial adFailed:%zd", errorCode);
        
        // 전면광고 실패를 알린다.
        [self subAdlibViewInterstitialFailed:@"tad"];
        
    } else if (tadCore == self.tadCore) {
        NSLog(@"tadCore band adFailed:%zd", errorCode);
        
        [self failed];
        bGotAd = NO;
    }
}

- (void)tadOnAdClicked:(TadCore *)tadCore {
    
    //NSLog(@"<Tad> 광고 클릭");
    //광고 클릭 이벤트를 리포팅
    
    if (tadCore == self.interstitial) {
        
        [self reportInterstitialClickEvent];
        
    } else if (tadCore == self.tadCore) {
        
        [self reportBannerClickEvent];
    }
}

@end
