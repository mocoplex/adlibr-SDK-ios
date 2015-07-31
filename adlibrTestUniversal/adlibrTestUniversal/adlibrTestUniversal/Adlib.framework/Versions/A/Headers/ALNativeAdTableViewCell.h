//
//  ALTableViewAdCell.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 17..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALNativeAdRendering.h"

@interface ALNativeAdTableViewCell : UITableViewCell <ALNativeAdRendering>

//IBOutlet
@property (nonatomic, strong) IBOutlet UIImageView *adIconImageView;
@property (nonatomic, strong) IBOutlet UIImageView *adContentImageView;

@property (nonatomic, strong) IBOutlet UILabel *adTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *adSubtitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *adDescriptionLabel;

@property (nonatomic, strong) IBOutlet UIButton *adButton;
@property (nonatomic, strong) IBOutlet UIView *adEmbeddedVideoView;

@end
