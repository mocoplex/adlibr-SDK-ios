//
//  ADLibBanner.h
//  Adlib
//
//  Created by gskang on 2016. 8. 17..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#ifndef ADLibBanner_h
#define ADLibBanner_h


#import <Adlib/ALMediationDefine.h>
#import <Adlib/ALMediation.h>
#import <Adlib/ADLibSession.h>

/*
 * 애드립 미디에이션 (신규버전)
 * 애드립 이외의 광고 플랫폼 사용 시 해당 플랫폼의 구현 클래스를 추가해야한다.
 * (Ex. ALAdapterAdmob)
 */

// 미디에이션 띠배너 요청 배너뷰
#import <Adlib/ALAdBannerView.h>

// 미디에이션 전면배너 요청 객체
#import <Adlib/ALInterstitialAd.h>

// 미디에이션 띠배너 BackFill제공 탬플릿뷰
#import <Adlib/ALAdBackFillView.h>




/**
 * 애드립 전용 이미지 광고 뷰
 * 애드립 및 애드립 하우스 플랫폼만 사용할 수 있는 이미지/웹 뷰 광고 제공 클래스
 */

// (Width x Height) 동적 소재사이즈 광고
#import <Adlib/ALDynamicBanner.h>


// (320 x 50) 규격 소재사이즈 광고
#import <Adlib/ALAdlibBannerView.h>

#endif /* ADLibBanner_h */
