//
//  SongListTableViewADCell.m
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 15..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import "ALExampleMusicAdCell.h"

@implementation ALExampleMusicAdCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.adIconImageView.image = nil;
}

@end
