/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with ad@m SDK 2.2.2
 */

// iOS / ad@m 플랫폼은 백그라운드 리퀘스트 기능을 지원하지 않습니다.
// 화면에 광고뷰가 노출된 상태에서만 응답을 받을 수 있으며
// 응답을 받기까지 빈화면으로 표시될 수 있습니다.

#import <UIKit/UIKit.h>
#import "SubAdlibAdViewCore.h"
#import "AdamAdView.h"
#import "AdamInterstitial.h"

#define AD_REFRESH_PERIOD 30
@interface SubAdlibAdViewAdam : SubAdlibAdViewCore<AdamAdViewDelegate>
{
    BOOL bGotAd;
    AdamAdView *ad;
}

@end
