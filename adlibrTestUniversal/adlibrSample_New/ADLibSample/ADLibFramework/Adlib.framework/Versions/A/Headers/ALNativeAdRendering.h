//
//  ALNativeAdRendering.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 17..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALNativeAd.h"

/**
 * ALNativeAdRendering 커스텀 뷰 클래스에 광고 컨텐츠를 표시하기위해 정의하는 포로토콜
 */
@protocol ALNativeAdRendering <NSObject>

/**
 * ALNativeAd 광고 객체의 정보를 뷰에 지정한다.
 *
 * @param adObject 뷰에 설정할 광고 객체
 * @param needToload 다운로드가 필요한 컨텐츠의 로딩을 수행할지 여부, 단순히 뷰 크기를 계산하기 위해서 사용할때는 NO 값을 지정한다.
 * @date 2014.12.15
 */
- (void)layoutAdProperties:(ALNativeAd *)nativeAd loadContent:(BOOL)needToload;
- (void)setMainImageViewContentMode:(UIViewContentMode)mode;

@optional

/**
 * ALNativeAd 섬네일 비디오 광고를 재생한다.
 * @date 2014.12.15
 */
- (void)playVideo;

/**
 * ALNativeAd 섬네일 비디오 광고 재생을 중단한다.
 * @date 2014.12.15
 */
- (void)pauseVideo;

@end
