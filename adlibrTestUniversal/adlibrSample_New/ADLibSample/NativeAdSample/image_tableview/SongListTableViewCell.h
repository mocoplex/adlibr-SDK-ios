//
//  SongListTableViewCell.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 15..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  샘플 프로젝트 NativeAd Sample-1 음악 파일 테이블 리스트에서 사용되는 셀 클래스
 */

@interface SongListTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *thumbImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *durationLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistLabel;

@end
