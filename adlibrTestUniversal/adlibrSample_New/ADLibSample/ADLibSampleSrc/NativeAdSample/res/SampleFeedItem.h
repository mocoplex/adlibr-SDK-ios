//
//  SampleFeedItem.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 10..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SampleFeedItem : NSObject

@property (nonatomic) NSInteger feedId;
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *timeStamp;

@property (nonatomic, strong) NSString *imageUrlString;
@property (nonatomic, strong) NSString *iconUrlString;
@property (nonatomic, strong) NSString *urlString;

- (NSTimeInterval)timeIntervalSince1970;
- (NSString *)timeStampDescription;

/**
 * 메인 컨텐츠 이미지의 입력한 가로대비 세로 높이를 계산하여 반환한다.
 * @param viewWidth 이미지를 표시할 뷰의 가로 넓이
 * @return 표시할 이미지의 세로 높이
 * @date 2014.12.10
 */
- (NSInteger)expectedContentImageHeightForWidth:(NSInteger)viewWidth;

/**
 * 컨텐츠를 표시할 뷰의 가로 넓이에 해당하는 캐시된 세로 높이 값을 반환한다.
 * @param viewWidth 컨텐츠를 표시할 뷰의 가로 넓이
 * @return 표시할 컨텐츠 뷰의 세로 높이
 * @date 2014.12.10
 */
- (NSInteger)contentHeightForWidth:(NSInteger)viewWidth;

/**
 * 컨텐츠를 가로 넓이에 해당하는 높이값을 캐싱하기 위해 호출
 * @param height 캐싱할 컨텐츠의 높이 값
 * @param viewWidth 컨텐츠를 표시할 뷰의 가로 넓이
 * @date 2014.12.10
 */
- (void)setContentHeight:(NSInteger)height ForWidth:(NSInteger)viewWidth;

@end


@interface SampleFeedItemDeserializer : NSObject

+ (instancetype)deserializer;

/**
 * 입력한 json 바이너리 데이터를 파싱하여 SampleFeedItem 객체의 리스트를 생성, 반환한다.
 * @param data json 바이너리 데이터
 * @param error 에러를 저장할 객체의 주소값
 * @return SampleFeedItem 객체의 배열
 * @date 2014.12.10
 */
- (NSArray *)sampleFeedItemArrayForData:(NSData *)data error:(NSError **)error;

@end


@interface SongListItem : NSObject

@property (nonatomic) NSInteger songid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *thumbUrlString;

@end
