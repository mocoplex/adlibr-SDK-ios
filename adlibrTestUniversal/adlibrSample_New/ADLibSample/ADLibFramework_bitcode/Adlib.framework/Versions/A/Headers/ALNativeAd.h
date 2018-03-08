//
//  ALNativeAd.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 9..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ALNativeAdClickBlock)(NSURL *landingUrl);

@interface ALNativeAd : NSObject {
    
}

// 광고 노출 처리를 위해 등록합니다.
// 해당 함수로 등록시 클릭 처리는 제공하는 clickURL을 통해 직접 구현합니다.
- (void)registerViewForInteraction:(UIView *)containerView;

// 클릭 이벤트 처리 등록 (옵션 - 등록하지 않은 경우 내부에서 처리)
- (void)registerClickEventBlock:(void (^)(NSURL *landingUrl))block;

@property (nonatomic, copy, readonly) ALNativeAdClickBlock clickBlock;

#pragma mark - getter

//클릭, 랜딩 주소 반환
- (NSURL *)clickURL;

//iconIamge Contents

//아이콘 이미지 및 사이즈 반환
- (UIImage *)iconImage;
- (CGSize)iconImageSize;

//메인 이미지 및 사이즈 반환
- (UIImage *)mainContentImage;
- (CGSize)mainContentSize;

//배너 이미지 및 사이즈 반환
- (UIImage *)bannerImage;
- (CGSize)bannerImageSize;

//Text Contents
- (NSString *)contentTitle;
- (NSString *)contentSubtitle;
- (NSString *)adButtonTitle;

//Video Contents
- (BOOL)isVideoAd;
- (BOOL)playAbleToVideoStreaming;

- (NSURL *)thumbnailVideoURL;
- (NSNumber *)thumbnailVideoLength;
- (NSURL *)contentVideoURL;

- (CGFloat)contentWidth;
- (CGFloat)contentHeight;


//하단 메소드들은 편의로 제공하는 메소드이다.
#pragma mark - layout ALNativeAd assets

/**
 * 광고 타이틀 문자열을 라벨 텍스트에 지정한다.
 * @param label 텍스트를 지정할 UILabel 뷰 객체
 * @date 2014.12.16
 */
- (void)loadTitleIntoLabel:(UILabel *)label;

/**
 * 광고 서브타이틀 문자열을 라벨 텍스트에 지정한다.
 * @param label 텍스트를 지정할 UILabel 뷰 객체
 * @date 2014.12.16
 */
- (void)loadSubtitleIntoLabel:(UILabel *)label;

/**
 * 광고 상세 설명 문자열을 라벨 텍스트에 지정한다.
 * @param label 텍스트를 지정할 UILabel 뷰 객체
 * @date 2014.12.16
 */
- (void)loadDescriptionIntoLabel:(UILabel *)label;

/**
 * 광고 버튼 문자열을 버튼 텍스트에 지정한다.
 * @param button 텍스트를 지정할 UIButton 뷰 객체
 * @date 2014.12.16
 */

- (void)loadButtonTitleIntoButton:(UIButton *)button;

/**
 * 아이콘 이미지를 이미지 뷰에 지정한다.
 * @param imageView 아이콘 이미지를 지정할 이미지 뷰 객체
 * @date 2014.12.16
 */
- (void)loadIconIntoImageView:(UIImageView *)imageView;

/**
 * 메인 콘텐츠 이미지를 이미지 뷰에 지정한다.
 * @param imageView 메인 콘텐츠 이미지를 지정할 이미지 뷰 객체
 * @date 2014.12.16
 */
- (void)loadContentImageIntoImageView:(UIImageView *)imageView;

#pragma mark - adView height cache

/**
 * 메인 컨텐츠 이미지의 높이 값을 이미지 가로:세로 비율을 사용하여 디스플레이 뷰 너비 값을 기준으로 계산하여 반환한다.
 * @param viewWidth 광고 메인 컨텐츠 이미지를 담을 뷰의 가로 너비 값
 * @return 컨텐츠 이미지를 표시할 높이 값
 * @date 2014.12.19
 * @brief 이미지 원본의 가로:세로 비율에 대비하여 스크린 가로 대비 세로로 표시할 높이 값을 계산함.
 */
- (NSInteger)expectedMainContentHeightForWidth:(NSInteger)viewWidth;

/**
 * 메인 컨텐츠 이미지의 높이 값을 고정 비율을 사용하여 디스플레이 뷰 너비 값을 기준으로 계산하여 반환한다.
 * @param viewWidth 광고 메인 컨텐츠 이미지를 담을 뷰의 가로 너비 값
 * @return 컨텐츠 이미지를 표시할 높이 값
 * @date 2014.12.19
 * @brief 고정 가로:세로 비율에 대비하여 가로:세로(16:9) 고정 비율을 사용하여 세로로 표시할 높이 값을 계산함.
 */
- (NSInteger)fixedMainContentHeightForWidth:(NSInteger)viewWidth;

@end
