//
//  ALNativeAdTableManager.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 26..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ALNativeAd.h"
#import "ALNativeAdRequest.h"

@class ALNativeAdTableHelper, ADLibSession;

@protocol ALNativeAdTableHelperDelegate <NSObject>

- (void)ALNativeAdTableHelper:(ALNativeAdTableHelper *)helper didReceivedNativeAd:(ALNativeAd *)nativeAd;
- (void)ALNativeAdTableHelper:(ALNativeAdTableHelper *)helper didFailedRequestWithError:(NSError *)error;

@end


@interface ALNativeAdTableHelper : NSObject {
    
}

// 테이블 뷰 스크롤 시 비디오 자동 재생 여부
@property (nonatomic) BOOL autoPlayVideo;

/**
 * 네이티브 광고 테이블 헬퍼 클래스 생성자
 *
 * @param tableView 테이블 뷰
 * @param session 애드립세션 객체
 * @param delegate 광고 추가 / 실패 델리게이트
 * @date 2015.10.01
 */
- (id)initWithTableView:(UITableView *)tableView
           adlibSession:(ADLibSession *)session
               delegate:(id<ALNativeAdTableHelperDelegate>)delegate;

/**
 * 네이티브 광고 요청
 *
 * @param type 네이티브 광고 형식 (이미지 / 비디오 / 모든형식)
 * @param count 요청 광고 수 (최대 10개)
 * @param timeout 지정된 시간까지만의 광고 추가 알림을 받음
 * @date 2014.12.18
 *
 * @brief 
 * 네이티브 지면광고에 필요한 리소스까지 다운로드 완료된 상태에서 델리게이트를 
 * 호출함. (최대 10개 설정 시 10번까지 델리게이트가 호출될 수 있음)
 */
- (void)requestNativeAdItemType:(ALAdRequestItemType)type
                   maximumCount:(NSUInteger)count
                timeoutInterval:(NSTimeInterval)timeout;

/**
 * 네이티브 광고 요청을 모두 취소
 *
 * @date 2014.12.18
 */
- (void)cancelReqeust;


/**
 * 헬퍼 클래스에서 사용하고 있는 리소스를 명시적으로 해제함.
 *
 * @date 2014.12.18
 */
- (void)clearResources;


/**
 * 네이티브 광고 셀을 생성하여 반환하는 함수
 *
 * @param adObject 해당 셀의 광고 객체
 * @param identifier 셀 재사용 고유 문자열
 * @param indexPath 셀의 indexPath 값
 * @return 생성한 테이블 뷰 광고 셀 객체
 * @date 2014.12.18
 */
- (UITableViewCell *)adCellForAd:(ALNativeAd *)adObject
                  cellIdentifier:(NSString *)identifier
                    forIndexPath:(NSIndexPath *)indexPath;


/**
 * 가변 높이의 셀에 해당하는 높이 값을 반환 (사전 계산으로 캐싱된 저장 값을 찾아 반환됨)
 *
 * @param width 캐싱된 값을 찾기 위한 키 값. (가로 넓이 기준으로 계산되어진 값을 찾음)
 * @param indexPath 특정 위치의 광고를 찾기위해 위치 값을 전달
 * @return 해당 위치의 광고에 대한 요청 가로 대비 세로 높이 값을 반환
 * @date 2014.12.18
 */
- (CGFloat)nativeAdCellExpectedHeightForContentWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;


/**
 * 가변 높이의 셀에 해당하는 높이 값을 반환 (사전 계산으로 캐싱된 저장 값을 찾아 반환됨)
 *
 * @param width 캐싱된 값을 찾기 위한 키 값. (가로 넓이 기준으로 계산되어진 값을 찾음)
 * @param indexPath 특정 위치의 광고를 찾기위해 위치 값을 전달
 * @return 해당 위치의 광고에 대한 요청 가로 대비 세로 높이 값을 반환
 * @date 2014.12.18
 */
- (void)setExpectedAdCellHeight:(CGFloat)height forWidth:(CGFloat)width atRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 * 가변 높이의 셀의 경우 높이를 계산하는데 필요한 광고 정보를 광고 뷰에 지정한다.
 * @param cell 광고 셀
 * @param adObject nativeAd 광고 객체
 * @date 2014.12.19
 * @brief 이미지 등 다운로드 완료가 필요한 요소의 값들은 해당하지 않는다.
 */
- (void)preconfigureCell:(UITableViewCell *)cell forAd:(ALNativeAd *)adObject;


/**
 * 네이티브 광고 셀을 클릭 이벤트를 처리한다.
 *
 * @param adObject 해당 셀의 광고 객체
 * @param controller 전면 비디오광고 뷰컨트롤러를 present하는데 사용되는 뷰컨트롤러
 * @date 2014.12.18
 */
- (void)didSelectAdCellForAd:(ALNativeAd *)adObject
    presentingViewController:(UIViewController *)controller;

/**
 * 네이티브 광고 메인 컨텐츠 이미지 뷰의 리사이즈 모드를 설정
 *
 * @param mode 해당 셀의 광고 객체
 * @date 2015.09.01
 */
- (void)setMainImageContentMode:(UIViewContentMode)mode;

@end
