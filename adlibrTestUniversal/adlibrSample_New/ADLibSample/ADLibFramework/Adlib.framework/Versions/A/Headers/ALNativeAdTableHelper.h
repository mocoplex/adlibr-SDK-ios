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

- (void)ALNativeAdTableHelper:(ALNativeAdTableHelper *)helper didReceivedNativeAds:(NSArray *)adList;
- (void)ALNativeAdTableHelper:(ALNativeAdTableHelper *)helper didFailedRequestWithError:(NSError *)error;

@end


@interface ALNativeAdTableHelper : NSObject {
    
}

//테스트광고 설정 여부
@property (nonatomic) BOOL isTestMode; //default : NO;

/**
 * 네이티브 광고 테이블 헬퍼 클래스 생성자
 *
 * @param key 애드립 키
 * @param delegate 광고 추가 / 실패 델리게이트
 * @date 2015.10.01
 */
- (id)initWithViewController:(UIViewController *)viewController
                   tableView:(UITableView *)tableView
                    adlibKey:(NSString *)key
                    delegate:(id<ALNativeAdTableHelperDelegate>)delegate;

/**
 * 네이티브 광고 요청
 *
 * @param type 네이티브 광고 형식 (이미지 / 비디오 / 모든형식)
 * @date 2014.12.18
 */
- (void)requestNativeAdItemType:(ALAdRequestItemType)type;;

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
 * 네이티브 광고 셀이 화면에 노출되는 상황의 처리를 내부적으로 수행합니다.
 * Ex. 비디오 광고 셀인 경우 자동 재생 처리.
 *
 * @param cell 화면에 노출되는 셀
 * @param indexPath 셀의 indexPath 값
 * @date 2017.1.19
 */
- (void)willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 * 네이티브 광고 셀이 화면에 노출되는 상황의 처리를 내부적으로 수행합니다.
 * Ex. 비디오 광고 셀인 경우 자동 정지 처리.
 *
 * @param cell 화면에서 사라지는 셀
 * @param indexPath 셀의 indexPath 값
 * @date 2017.1.19
 */
- (void)didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;


/**
 * 네이티브 광고 셀을 클릭 이벤트를 처리한다.
 *
 * @param adObject 해당 셀의 광고 객체
 * @param indexPath 선택된 셀의 indexPath
 * @param controller 전면 비디오광고 뷰컨트롤러를 present하는데 사용되는 뷰컨트롤러
 * @date 2014.12.18
 */
- (void)didSelectAdCellForAd:(ALNativeAd *)adObject
                 atIndexPath:(NSIndexPath *)path
    presentingViewController:(UIViewController *)controller;


#pragma mark - Optional 

/**
 * 네이티브 광고 메인 컨텐츠 이미지 뷰의 리사이즈 모드를 설정
 *
 * @date 2015.09.01
 */
- (void)setMainImageContentMode:(UIViewContentMode)mode;


/**
 * 가변 높이의 셀의 경우 높이를 계산하는데 필요한 광고 정보를 광고 뷰에 지정한다.
 * @param cell 광고 셀
 * @param adObject nativeAd 광고 객체
 * @date 2014.12.19
 * @brief 이미지 등 다운로드 완료가 필요한 요소의 값들은 해당하지 않는다.
 */
- (void)preconfigureCell:(UITableViewCell *)cell forAd:(ALNativeAd *)adObject;

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

@end
