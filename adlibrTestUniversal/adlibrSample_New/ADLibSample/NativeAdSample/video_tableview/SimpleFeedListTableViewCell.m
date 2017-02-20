//
//  SimpleFeedListTableViewCell.m
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 22..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import "SimpleFeedListTableViewCell.h"

@implementation SimpleFeedListTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    _feedIconImageView.image = nil;
    _feedContentImageView.image = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
