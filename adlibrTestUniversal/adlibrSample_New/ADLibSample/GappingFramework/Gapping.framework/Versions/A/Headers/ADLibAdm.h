//
//  ADLibAdm.h
//  Adlib
//
//  Created by gskang on 2017. 1. 20..
//  Copyright © 2017년 mocoplex. All rights reserved.
//

#ifndef ADLibAdm_h
#define ADLibAdm_h

/*
 * 애드립 미디에이션 (구버전) 적용시 필요한 클래스 정의
 * 개발 업데이트 지원 중단 버전으로 AdlibManager를 통한 광고 연동시 사용
 *
 * 해당 방식은 어플리케이션에서 단일의 배너뷰를 사용할 경우 간단하게 적용하기위해 제작된 방식으로
 * 여러개의 광고뷰를 사용할 경우 적절하지 않을수 있다.
 * 하나의 광고뷰를 사용할 경우에도 위의 신규 버전 사용을 권장 !!!
 */

// 애드립 이외의 플랫폼 추가로 사용할 경우
// 어플리케이션에 광고 플랫폼의 구현 클래스를 추가해야한다. (Ex. SubAdlibAdViewAdmob)

#import <Adlib/AdlibManager.h>
#import <Adlib/ADLibMediator.h>
#import <Adlib/SubAdlibAdsView.h>
#import <Adlib/SubAdlibAdViewCore.h>


#endif /* ADLibAdm_h */
