//
//  ALNativeAd.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 9..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ALNativeAd : NSObject {
    
}

- (void)registerViewForInteraction:(UIView *)containerView
                withViewController:(UIViewController *)controller;

#pragma mark - getter

- (CGFloat)contentWidth;
- (CGFloat)contentHeight;

- (NSString *)contentTitle;
- (NSString *)contentSubtitle;
- (NSString *)adButtonTitle;

- (NSURL *)thumbnailVideoURL;
- (NSNumber *)thumbnailVideoLength;
- (NSURL *)contentVideoURL;

- (BOOL)isVideoAd;
- (BOOL)playAbleToVideoStreaming;

- (CGSize)iconImageSize;
- (CGSize)mainContentSize;

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
