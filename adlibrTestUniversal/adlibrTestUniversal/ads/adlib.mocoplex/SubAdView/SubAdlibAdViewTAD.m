/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with t-ad SDK 3.0.0.6
 */

#import "SubAdlibAdViewTAD.h"

// Tad를 사용할 경우 Tad의 library에 JSONKit이 포함되어 있으므로 애드립 lib 폴더의 JSONKit을 삭제하세요.

// TAD의 APP 아이디를 설정합니다.
#define TAD_ID @"T_AD"

@implementation SubAdlibAdViewTAD

- (void)query:(UIViewController*)parent
{
    [super query:parent];

    tadCore = [[TadCore alloc] initWithSeedView:self.view delegate:self];
    //필수 사항
    [tadCore setClientID:TAD_ID];       // 클라이언트 아이디
    [tadCore setSlotNo:TadSlotInline];  // 슬롯 설정
    
    // 선택 셋팅 사항
    [tadCore setIsTest:NO];                               // YES : 테스트 서버, NO : 상용 서버 (Default : YES)
    [tadCore setOffset:CGPointMake(0.0f, 0.0f)];          // 광고의 오프셋을 결정한다. (Default 0.0)
    [tadCore setRefershInterval:30.0f];                   // 리프레쉬 인터벌을 결정한다. 15~60초 사이만 가능 (Default : 60)
    [tadCore setLogMode:NO];                              // 로그를 보여줄지 아닐지 결정 (Default : NO)
    [tadCore getAdvertisement];
    
    if(bGotAd)
        [self gotAd];    
}

- (void)clearAdView
{
    [super clearAdView];
    [tadCore release];
    tadCore = nil;
}

#pragma mark - TadDelegate

- (void)tadOnAdWillReceive {
    //NSLog(@"<Tad> 광고 전문 요청 시작");
}

- (void)tadOnAdReceived {
    //NSLog(@"<Tad> 광고 전문 수신 완료");
}

- (void)tadOnAdWillLoad {
    //NSLog(@"<Tad> 광고 로드 시작");
}

- (void)tadOnAdLoaded {
    //광고 로드 완료
    [self gotAd];
    bGotAd = YES;
}

- (void)tadOnAdClicked {
    //NSLog(@"<Tad> 광고 클릭");
}

- (void)tadOnAdColsed {
    //NSLog(@"<Tad> 전면 형 광고 닫힘");
}

- (void)tadOnAdExpanded {
    //NSLog(@"<Tad> 광고 확장");
}

- (void)tadOnAdExpandClose {
    //NSLog(@"<Tad> 광고 확장 닫기");
}

- (void)tadOnAdResized {
    //NSLog(@"<Tad> 광고 리사이징");
}

- (void)tadOnAdResizeClosed {
    //NSLog(@"<Tad> 광고 리사이징 닫기");
}

- (void)tadFailed:(TadErrorCode)errorCode {
    
    // 실패했다. 바로 다음 스케줄 광고를 보인다.
    [self failed];
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

@end
