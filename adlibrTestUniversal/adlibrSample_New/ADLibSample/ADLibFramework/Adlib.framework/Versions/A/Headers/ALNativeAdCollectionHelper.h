//
//  ALNativeAdCollectionHelper.h
//  Adlib
//
//  Created by gskang on 2017. 1. 19..
//  Copyright © 2017년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ALNativeAd.h"
#import "ALNativeAdRequest.h"

@class ALNativeAdCollectionHelper, ADLibSession;

@protocol ALNativeAdCollectionHelperDelegate <NSObject>

- (void)ALNativeAdCollectionHelper:(ALNativeAdCollectionHelper *)helper didReceivedNativeAds:(NSArray *)adList;
- (void)ALNativeAdCollectionHelper:(ALNativeAdCollectionHelper *)helper didFailedRequestWithError:(NSError *)error;

@end

@interface ALNativeAdCollectionHelper : NSObject

//테스트광고 설정 여부
@property (nonatomic) BOOL isTestMode; //default : NO;

/**
 * 네이티브 광고 콜랙션뷰 헬퍼 클래스 생성자
 *
 * @param key 애드립 키
 * @param delegate 광고 추가 / 실패 델리게이트
 * @date 2015.10.01
 */
- (id)initWithViewController:(UIViewController *)viewController
              collectionView:(UICollectionView *)collectionView
                    adlibKey:(NSString *)key
                    delegate:(id<ALNativeAdCollectionHelperDelegate>)delegate;

/**
 * 네이티브 광고 요청
 *
 * @param type 네이티브 광고 형식 (이미지 / 비디오 / 모든형식)
 * @date 2014.12.18
 */
- (void)requestNativeAdItemType:(ALAdRequestItemType)type;

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
- (UICollectionViewCell *)adCellForAd:(ALNativeAd *)adObject
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
- (void)willDisplayCell:(UICollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 * 네이티브 광고 셀이 화면에 노출되는 상황의 처리를 내부적으로 수행합니다.
 * Ex. 비디오 광고 셀인 경우 자동 정지 처리.
 *
 * @param cell 화면에서 사라지는 셀
 * @param indexPath 셀의 indexPath 값
 * @date 2017.1.19
 */
- (void)didEndDisplayingCell:(UICollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;

/**
 * 가변 높이의 셀의 경우 높이를 계산하는데 필요한 광고 정보를 광고 뷰에 지정한다.
 * @param cell 광고 셀
 * @param adObject nativeAd 광고 객체
 * @date 2014.12.19
 * @brief 이미지 등 다운로드 완료가 필요한 요소의 값들은 해당하지 않는다.
 */
- (void)preconfigureCell:(UICollectionViewCell *)cell
                   forAd:(ALNativeAd *)adObject;


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

/**
 * 네이티브 광고 메인 컨텐츠 이미지 뷰의 리사이즈 모드를 설정
 *
 * @date 2015.09.01
 */
- (void)setMainImageContentMode:(UIViewContentMode)mode;

@end
