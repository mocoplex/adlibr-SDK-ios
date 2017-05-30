//
//  ALNativeAdCollectionViewCell.h
//  Adlib
//
//  Created by gskang on 2017. 1. 19..
//  Copyright © 2017년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALNativeAdRendering.h"

@interface ALNativeAdCollectionViewCell : UICollectionViewCell <ALNativeAdRendering>

//IBOutlet
@property (nonatomic, strong) IBOutlet UIView *adMainContentView;
@property (nonatomic, strong) IBOutlet UIImageView *adIconImageView;

@property (nonatomic, strong) IBOutlet UILabel *adTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *adSubtitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *adDescriptionLabel;

@property (nonatomic, strong) IBOutlet UIButton *adButton;

@end
