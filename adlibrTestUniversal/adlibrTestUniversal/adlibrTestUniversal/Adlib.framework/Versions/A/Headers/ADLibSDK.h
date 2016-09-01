//
//  ADLibSDK.h
//  ADLibSDK
//
//  Created by mocoplex on 2014. 12. 30..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//
//  Adlib SDK version 4.2.1.0
//  Build (4.210) 2016.08.30. 10:00


#import <Adlib/ADLibSession.h>

///////////////////////////////////////////////////////////////////////////
// 애드립 광고 미디에이션 클래스                                                //
///////////////////////////////////////////////////////////////////////////


// 애드립 미디에이션 - !!! 하나의 키만 사용할경우 싱글톤클래스로 사용하는 방법을 제공
// 어플리케이션에서 광고 플랫폼의 구현 클래스를 추가해야한다. (Ex. SubAdlibAdViewAdmob)
#import <Adlib/ADLibMediator.h>
#import <Adlib/SubAdlibAdsView.h>
#import <Adlib/SubAdlibAdViewCore.h>


// 애드립 미디에이션 (신규버전) - !!! 여러개의 키를 사용하는 경우 객체로 사용하는 방법을 제공
// 어플리케이션에서 광고 플랫폼의 구현 클래스를 추가해야한다. (Ex. ALAdapterAdmob)
#import <Adlib/ALMediationDefine.h>
#import <Adlib/ALMediation.h>

// 미디에이션 띠배너 요청 배너뷰
#import <Adlib/ALAdBannerView.h>
// 미디에이션 전면배너 요청 객체
#import <Adlib/ALInterstitialAd.h>


///////////////////////////////////////////////////////////////////////////
// 애드립 전용 이미지 광고 뷰                                                  //
///////////////////////////////////////////////////////////////////////////

// (320 x 50) 규격 소재사이즈 광고
#import <Adlib/ALAdlibBannerView.h>

// (Width x Height) 동적 소재사이즈 광고
#import <Adlib/ALDynamicBannerView.h>
#import <Adlib/ALDynamicBannerController.h>


///////////////////////////////////////////////////////////////////////////
// 애드립 3D 광고 - 갭핑 상품                                                 //
///////////////////////////////////////////////////////////////////////////

#import <Adlib/ALGappingDefines.h>
#import <Adlib/ALIconAdLoader.h>
#import <Adlib/GappingLoader.h>


///////////////////////////////////////////////////////////////////////////
// 애드립 네이티브 광고                                                       //
///////////////////////////////////////////////////////////////////////////

#import <Adlib/ALNativeAdRequest.h>
#import <Adlib/ALNativeAd.h>
#import <Adlib/ALNativeAdTableViewCell.h>
#import <Adlib/ALNativeAdRendering.h>
#import <Adlib/ALNativeAdTableHelper.h>
#import <Adlib/ALImageDownloader.h>

