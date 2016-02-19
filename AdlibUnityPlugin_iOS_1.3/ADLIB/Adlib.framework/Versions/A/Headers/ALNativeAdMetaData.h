//
//  ALNativeAdMetaData.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 17..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALNativeAd, ALNativeAdContents;

@interface ALNativeAdMetaData : NSObject {
    
}

/**
 * 수신한 네이티브 광고의 갯수를 반환한다.
 * @return 광고의 갯수
 * @date 2014.12.15
 * @brief API 응답 JSON 결과에 광고 아이템이 존재하지 않을 경우 0을 리턴한다.
 */
- (NSUInteger)countOfNativeAds;

/**
 * 요청한 인덱스의 네이티브 광고 객체를 반환한다.
 * @param idx 요청 인덱스
 * @return ALNativeAd 객체
 * @date 2014.12.15
 */
- (ALNativeAd *)nativeAdAtIndex:(NSUInteger)idx;

/**
 * 네이티브 광고 객체 리스트를 반환한다.
 * @return ALNativeAd 객체 리스트 배열
 * @date 2014.12.15
 */
- (NSArray *)nativeAdList;

/**
 * 이미지 광고 객체 리스트를 반환한다.
 * @return ALNativeAd 객체 리스트 배열
 * @date 2014.12.15
 */
- (NSArray *)nativeImageAdList;

/**
 * 동영상 광고 객체 리스트를 반환한다.
 * @return ALNativeAd 객체 리스트 배열
 * @date 2014.12.15
 */
- (NSArray *)nativeVideoAdList;

@end
