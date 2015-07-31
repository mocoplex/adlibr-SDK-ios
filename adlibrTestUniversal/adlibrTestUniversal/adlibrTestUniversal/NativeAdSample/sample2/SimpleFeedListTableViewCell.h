//
//  SimpleFeedListTableViewCell.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 22..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  샘플 프로젝트 NativeAd Sample-2 피드 테이블 리스트에서 사용되는 셀 클래스
 */

@interface SimpleFeedListTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView *feedContentView;

@property (nonatomic, weak) IBOutlet UIImageView *feedIconImageView;
@property (nonatomic, weak) IBOutlet UILabel *feedTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *feedSubitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *feedContentImageView;

@end
