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
#import <Adlib/ADLibSDK.h>

#define kMapKeyIsAd @"isAd"
#define kMapKeyItem @"item"

#define ADLIB_APP_KEY @"550787410cf2833915d71f3b"      // 발급받은 앱키를 적용

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
    
    _tableItemList = [[NSMutableArray alloc] init];
    
    //어플리케이션에서 사용하는 이미지 다운로드 방식이 이미 존재한다면 사용하지 않아도된다.
    //샘플 프로젝트 코드를 위해 편의로 제공하는 클래스이며, ALNativeAd 클래스에서 내부적으로 사용하는 방식과 다를 수 있다.
    _imageLoader = [[ALImageDownloader alloc] init];
    
    //register cell nib
    [self.tableView registerNib:[UINib nibWithNibName:SimpleFeedListItemCellIdentifier bundle:nil]
         forCellReuseIdentifier:SimpleFeedListItemCellIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:ALSimpleFeedListAdCellIdentifier bundle:nil]
         forCellReuseIdentifier:ALSimpleFeedListAdCellIdentifier];
    
    //load application feed list
    [self loadFeedList];
    
    //setup table manager
    [self loadNativeAds];
}

- (void)dealloc
{
    [_nativeAdTableManager cancelReqeust];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    if (nativeAd) {
        [_nativeAdTableManager didSelectAdCellForAd:nativeAd
                                        atIndexPath:indexPath
                           presentingViewController:self];
    }
}

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
    
    ALNativeAdTableHelper *nativeAdTableHelper = [[ALNativeAdTableHelper alloc] initWithViewController:self
                                                                                             tableView:self.tableView
                                                                                              adlibKey:ADLIB_APP_KEY
                                                                                              delegate:self];
    self.nativeAdTableManager = nativeAdTableHelper;
    self.nativeAdTableManager.isTestMode = YES;
    
    //async load native-AD list
    [_nativeAdTableManager requestNativeAdItemType:ALAdRequestItemTypeVideoAd];
}


#pragma mark -

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

- (void)ALNativeAdTableHelper:(ALNativeAdTableHelper *)helper didFailedRequestWithError:(NSError *)error
{
    NSLog(@"nativeAdTableHelper Error : %@", error);
}

@end
