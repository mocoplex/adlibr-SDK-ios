//
//  SimpleFeedListTableViewController.m
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 22..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import "SimpleFeedListTableViewController.h"
#import "SimpleFeedListTableViewCell.h"
#import "SampleFeedItem.h"
#import "ALExampleSimpleFeedAdCell.h"

#import <Adlib/ADLibNative.h>
#import "SampleKey.h"

#define kMapKeyIsAd @"isAd"
#define kMapKeyItem @"item"


static NSString * const ALSimpleFeedListAdCellIdentifier = @"ALExampleSimpleFeedAdCell";
static NSString * const SimpleFeedListItemCellIdentifier = @"SimpleFeedListTableViewCell";


@interface SimpleFeedListTableViewController () <ALNativeAdTableHelperDelegate>

@property (nonatomic, strong) NSMutableArray *tableItemList;

// 어플리케이션에서 이미지 URL 캐시 다운로드를 사용할 수 있도록 제공하는 클래스
// 개발사에서 사용하는 이미지 다운로드 방식으로 대체 사용을 권장합니다.
@property (nonatomic, strong) ALImageDownloader *imageLoader;

@property (nonatomic, strong) ALNativeAdTableHelper *nativeAdTableManager;

// Native 광고 객체의 인덱스 리스트
@property (nonatomic, strong) NSMutableArray *adItemIndexList;

@end


@implementation SimpleFeedListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"FeedList Type";
    

// AppDelegate에서 이미 설정 (동영상 광고를 포함해서 App 외부 출력과 Mix 설정의 코드로 필요 시 설정합니다.
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
//                                     withOptions:AVAudioSessionCategoryOptionMixWithOthers
//                                           error:nil];
    
    _tableItemList = [[NSMutableArray alloc] init];
    
    //어플리케이션에서 사용하는 이미지 다운로드 방식이 이미 존재한다면 사용하지 않아도된다.
    //샘플 프로젝트 코드를 위해 편의로 제공하는 클래스이며, ALNativeAd 클래스에서 내부적으로 사용하는 방식과 다를 수 있다.
    _imageLoader = [[ALImageDownloader alloc] init];
    
    //register cell nib
    [self.tableView registerNib:[UINib nibWithNibName:SimpleFeedListItemCellIdentifier bundle:nil]
         forCellReuseIdentifier:SimpleFeedListItemCellIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:ALSimpleFeedListAdCellIdentifier bundle:nil]
         forCellReuseIdentifier:ALSimpleFeedListAdCellIdentifier];
    
    //샘플 테이블의 피드리스트를 불러옵니다.
    [self loadFeedList];
    
    //샘플 테이블의 네이티브 광고를 요청합니다.
    [self loadNativeAds];
}

- (void)dealloc
{
    [_nativeAdTableManager cancelReqeust];
}

#pragma mark - <UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableItemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //광고 셀 을 반환
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    
    if (nativeAd) {
        return [self al_tableView:tableView adCellForRowAtIndexPath:indexPath];
    } else {
        return [self al_tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

#pragma mark - <UITableViewDelegate>

// 광고뷰가 화면 노출되는 상황의 처리를 위해 필요
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_nativeAdTableManager willDisplayCell:cell forRowAtIndexPath:indexPath];
}

// 광고뷰가 화면에서 사라지는 상황의 처리를 위해 필요
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [_nativeAdTableManager didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
}

// 테이블 뷰 셀 선택 처리
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

// 기본적인 뷰 액션은 네이티브 광고뷰 컴포넌트에 처리되있습니다.
// 추가로 테이블뷰 셀 선택 액션에 처리가 필요할 경우에만 사용합니다.
//
//    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
//    if (nativeAd) {
//        [_nativeAdTableManager didSelectAdCellForAd:nativeAd
//                                        atIndexPath:indexPath
//                           presentingViewController:self];
//    }
}

#pragma mark -

// 샘플 테이블의 피드셀을 반환합니다.
- (UITableViewCell *)al_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //샘플 피드리스트 셀 반환
    SimpleFeedListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleFeedListItemCellIdentifier
                                                                        forIndexPath:indexPath];
    
    SampleFeedItem *item = [self pv_tableObjectAtRow:indexPath.row];
    
    [self al_configureCell:cell withFeedItem:item];
    
    NSString *iconUrlStr = item.iconUrlString;
    if (iconUrlStr) {
        NSURL *iconUrl = [NSURL URLWithString:iconUrlStr];
        [_imageLoader downloadImageForURL:iconUrl intoImageView:cell.feedIconImageView];
    }
    
    NSString *imageUrlStr = item.imageUrlString;
    if (imageUrlStr) {
        NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
        [_imageLoader downloadImageForURL:imageUrl intoImageView:cell.feedContentImageView];
    }
    
    return cell;
}

// 샘플 테이블의 광고셀을 반환합니다.
- (UITableViewCell *)al_tableView:(UITableView *)tableView adCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    
    UITableViewCell *cell = nil;
    NSString *cellIdentifier = ALSimpleFeedListAdCellIdentifier;
    
    // 헬퍼클래스에 해당 네이티브광고를 랜더링한 셀을 요청합니다.
    cell = (id)[_nativeAdTableManager adCellForAd:nativeAd
                                   cellIdentifier:cellIdentifier
                                     forIndexPath:indexPath];
    
    return cell;
}

- (void)al_configureCell:(SimpleFeedListTableViewCell *)cell withFeedItem:(SampleFeedItem *)item
{
    cell.feedTitleLabel.text = item.name;
    cell.feedSubitleLabel.text = [item timeStampDescription];
}

- (ALNativeAd *)pv_nativeAdObjectAtRow:(NSUInteger)row
{
    if (_tableItemList == nil || row >= _tableItemList.count) {
        return nil;
    }
    
    NSMutableDictionary *tableItemInfo = [_tableItemList objectAtIndex:row];
    
    BOOL isAds = [[tableItemInfo objectForKey:kMapKeyIsAd] boolValue];
    if (isAds == NO) {
        return nil;
    }
    
    ALNativeAd *nativeAd = [tableItemInfo objectForKey:kMapKeyItem];
    return nativeAd;
}

- (SampleFeedItem *)pv_tableObjectAtRow:(NSUInteger)row
{
    if (_tableItemList == nil || row >= _tableItemList.count) {
        return nil;
    }
    
    NSMutableDictionary *tableItemInfo = [_tableItemList objectAtIndex:row];
    
    BOOL isAds = [[tableItemInfo objectForKey:kMapKeyIsAd] boolValue];
    if (isAds == YES) {
        return nil;
    }
    
    SampleFeedItem *listItem = [tableItemInfo objectForKey:kMapKeyItem];
    return listItem;
}

#pragma mark - load feed list

- (void)loadFeedList
{
    [_tableItemList removeAllObjects];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"sample_list"
                                                         ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    
    SampleFeedItemDeserializer *deserializer = [SampleFeedItemDeserializer deserializer];
    NSArray *results = [deserializer sampleFeedItemArrayForData:data error:&error];
    
    for (SampleFeedItem *item in results) {
        
        NSMutableDictionary *tableItemInfo = [[NSMutableDictionary alloc] init];
        [tableItemInfo setObject:[NSNumber numberWithBool:NO] forKey:kMapKeyIsAd];
        [tableItemInfo setObject:item forKey:kMapKeyItem];
        [_tableItemList addObject:tableItemInfo];
    }
    
    [self.tableView reloadData];
}

- (void)loadNativeAds
{
    NSMutableArray *indexList = [[NSMutableArray alloc] initWithArray:@[@(3)]];
    self.adItemIndexList = indexList;
    
    //앱 업데이트시에는 발급받으신 키로 교체하세요.
    NSString *appKey = kTEST_KEY_ADLIB;
    
    ALNativeAdTableHelper *nativeAdTableHelper = [[ALNativeAdTableHelper alloc] initWithViewController:self
                                                                                             tableView:self.tableView
                                                                                              adlibKey:appKey
                                                                                              delegate:self];
    self.nativeAdTableManager = nativeAdTableHelper;
    
    //테스트 모드, 상용 모드를 설정합니다.
    self.nativeAdTableManager.isTestMode = YES;
    
    //네이티브 동영상 광고를 요청합니다.
    [_nativeAdTableManager requestNativeAdItemType:ALAdRequestItemTypeVideoAd];
}


#pragma mark - ALNativeAdRequestDelegate

//광고 수신 성공 델리게이트
- (void)ALNativeAdTableHelper:(ALNativeAdTableHelper *)helper didReceivedNativeAds:(NSArray *)adList
{
    if (_adItemIndexList.count > 0) {
        
        ALNativeAd *nativeAd = [adList firstObject];
        
        NSNumber *rowNumber = [_adItemIndexList firstObject];
        [_adItemIndexList removeObjectAtIndex:0];
        
        NSInteger row = [rowNumber integerValue];
        if (row >= _tableItemList.count) {
            row = _tableItemList.count;
        }
        
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:row inSection:0];
        
        NSMutableDictionary *tableItemInfo = [[NSMutableDictionary alloc] init];
        [tableItemInfo setObject:[NSNumber numberWithBool:YES] forKey:kMapKeyIsAd];
        [tableItemInfo setObject:nativeAd forKey:kMapKeyItem];
        
        [_tableItemList insertObject:tableItemInfo atIndex:row];
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

//광고 수신 실패 델리게이트
- (void)ALNativeAdTableHelper:(ALNativeAdTableHelper *)helper didFailedRequestWithError:(NSError *)error
{
    NSLog(@"nativeAdTableHelper Error : %@", error);
}

@end
