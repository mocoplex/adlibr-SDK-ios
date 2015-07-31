//
//  SongListTableViewController.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 15..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * NativeAD Sample-1 이미지 광고만을 사용하는 예제
 *
 * 어플리케이션 셀 SongListTableViewCell
 * 이미지 광고 셀 ALExampleMusicAdCell
 *
 * 이미지 광고 셀의 경우 ALTableViewNativeAdCell을 상속 받아 사용합니다.
 * 광고의 아이콘 이미지, 제목 문구, 설명 문구 속성을 표시하며, 해당 속성의 뷰는
 * ALExampleMusicAdCell.xib에서 레이아웃 변경이 가능합니다.
 * 해당 xib 파일은 오토 레이아웃 기반으로 작성되었으며 뷰에 관해서는 사용자가 수정 가능하며, 
 * 클래스를 상속 받아 코드로도 구현이 가능합니다.
 */
@interface SongListTableViewController : UITableViewController

@end
