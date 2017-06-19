//
//  ALNativeAdView.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 22..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALNativeAdRendering.h"

@interface ALNativeAdView : UIView <ALNativeAdRendering>

@property (nonatomic, strong) IBOutlet UIView *adMainContentView;

@property (nonatomic, strong) IBOutlet UILabel *adTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *adSubtitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *adDescriptionLabel;

@property (nonatomic, strong) IBOutlet UIImageView *adIconImageView;
@property (nonatomic, strong) IBOutlet UIButton *adButton;

/**
 * 네이티브 광고 메인 컨텐츠 이미지 뷰의 리사이즈 모드를 설정
 *
 * @date 2015.09.01
 */
- (void)setMainImageContentMode:(UIViewContentMode)mode;

@end
