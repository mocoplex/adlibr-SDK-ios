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

static NSString * const SimpleFeedListCellIndetifier        = @"SimpleFeedListTableViewCell";
static NSString * const SimpleFeedListImageAdCellIdentifier = @"ALExampleFeedImageAdCell";
static NSString * const SimpleFeedListVideoAdCellIdentifier = @"ALExampleFeedVideoAdCell";

@interface SimpleFeedListTableViewController () <ALNativeAdTableHelperDelegate>

@property (nonatomic, strong) SimpleFeedListTableViewCell *tableViewCell;
@property (nonatomic, strong) ALExampleSimpleFeedAdCell   *imageAdCell;
@property (nonatomic, strong) ALNativeAdTableViewCell     *videoAdCell;

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
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    if ([self.tableView respondsToSelector:@selector(setEstimatedRowHeight:)]) {
        [self.tableView setEstimatedRowHeight:300.]; // "average" row height
    }
    
    //register cell nib
    [self.tableView registerNib:[UINib nibWithNibName:SimpleFeedListCellIndetifier bundle:nil]
         forCellReuseIdentifier:SimpleFeedListCellIndetifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:SimpleFeedListImageAdCellIdentifier bundle:nil]
         forCellReuseIdentifier:SimpleFeedListImageAdCellIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:SimpleFeedListVideoAdCellIdentifier bundle:nil]
         forCellReuseIdentifier:SimpleFeedListVideoAdCellIdentifier];
    
    //load application feed list
    [self loadFeedList];
    
    //setup table manager
    [self loadNativeAds];
}

- (void)dealloc
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    if (nativeAd) {
        return [self al_tableView:tableView expectedAdCellHeightForRowAtIndexPath:indexPath];
    }
    
    CGFloat height = [self al_tableView:tableView expectedHeightForRowAtIndexPath:indexPath];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    if (nativeAd) {
        return [self al_tableView:tableView expectedAdCellHeightForRowAtIndexPath:indexPath];
    }
    
    CGFloat height = [self al_tableView:tableView expectedHeightForRowAtIndexPath:indexPath];
    return height;
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
    SimpleFeedListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleFeedListCellIndetifier
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

- (UITableViewCell *)al_tableView:(UITableView *)tableView adCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    
    UITableViewCell *cell = nil;
    NSString *cellIdentifier = nil;
    
    if (nativeAd.isVideoAd) {
        cellIdentifier = SimpleFeedListVideoAdCellIdentifier;
    } else {
        cellIdentifier = SimpleFeedListImageAdCellIdentifier;
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    if (nativeAd) {
        [_nativeAdTableManager didSelectAdCellForAd:nativeAd tableViewController:self];
    }
}

- (CGFloat)al_tableView:(UITableView *)tableView expectedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    SampleFeedItem *item = [self pv_tableObjectAtRow:indexPath.row];
    if (item == nil) {
        return cellHeight;
    }
    
    NSInteger tableViewWidth = tableView.frame.size.width;
    NSInteger contentHeight = [item contentHeightForWidth:tableViewWidth];
    
    if (contentHeight== 0) {
        
        self.tableViewCell = [tableView dequeueReusableCellWithIdentifier:SimpleFeedListCellIndetifier];
        
        [self al_configureCell:self.tableViewCell withFeedItem:item];
        [self.tableViewCell layoutIfNeeded];
        
        cellHeight = [self.tableViewCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        CGFloat expectedImageViewHeight = [item expectedContentImageHeightForWidth:tableViewWidth];
        
        cellHeight += expectedImageViewHeight;
        [item setContentHeight:cellHeight ForWidth:tableViewWidth];
        
    } else {
        cellHeight = contentHeight;
    }
    
    return cellHeight;
}

- (CGFloat)al_tableView:(UITableView *)tableView expectedAdCellHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    
    CGFloat contentViewWidth = tableView.bounds.size.width;
    CGFloat contentHeight = [_nativeAdTableManager nativeAdCellExpectedHeightForContentWidth:contentViewWidth atIndexPath:indexPath];
    
    if (contentHeight== 0) {
        
        CGFloat expectedImageViewHeight = 0;
        
        if (nativeAd.isVideoAd == NO) { //이미지 광고 가변 높이 계산
            
            self.imageAdCell = [tableView dequeueReusableCellWithIdentifier:SimpleFeedListImageAdCellIdentifier];
            
            CGFloat prevLabelHeight = self.imageAdCell.adDescriptionLabel.bounds.size.height;
            
            [self.nativeAdTableManager preconfigureCell:self.imageAdCell forAd:nativeAd];
            [self.imageAdCell layoutIfNeeded];
            
            //라벨 높이 변화 계산
            CGFloat labelHeight = self.imageAdCell.adDescriptionLabel.bounds.size.height;
            CGFloat deltaHeight = labelHeight - prevLabelHeight;
            
            //이미지 로딩 전 상태로 이미지뷰의 높이는 0으로 잡힘
            cellHeight = [self.imageAdCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            expectedImageViewHeight = [nativeAd fixedMainContentHeightForWidth:contentViewWidth];
            expectedImageViewHeight += deltaHeight;
            
            //이미지 뷰의 높이를 추가해서 셀의 높이를 계산
            cellHeight += expectedImageViewHeight;
            [_nativeAdTableManager setExpectedAdCellHeight:cellHeight forWidth:contentViewWidth atRowAtIndexPath:indexPath];
            
        } else {
            
            self.videoAdCell = [tableView dequeueReusableCellWithIdentifier:SimpleFeedListVideoAdCellIdentifier];
            
            //이미지 영역은 고정 높이로 하단 상세 설명 라벨의 높이만을 계산하여 저장한다.
            CGFloat prevLabelHeight = self.videoAdCell.adDescriptionLabel.bounds.size.height;
            
            [self.nativeAdTableManager preconfigureCell:self.videoAdCell forAd:nativeAd];
            [self.videoAdCell layoutIfNeeded];
            
            CGFloat labelHeight = self.videoAdCell.adDescriptionLabel.bounds.size.height;
            CGFloat deltaHeight = labelHeight - prevLabelHeight;
            
            cellHeight = self.videoAdCell.frame.size.height;
            cellHeight += deltaHeight;
 
            [_nativeAdTableManager setExpectedAdCellHeight:cellHeight forWidth:contentViewWidth atRowAtIndexPath:indexPath];
        }
        
    } else {
        cellHeight = contentHeight;
    }

    return cellHeight;
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
    NSMutableArray *indexList = [[NSMutableArray alloc] initWithArray:@[@(3), @(5), @(8), @(13)]];
    self.adItemIndexList = indexList;
    
    NSString *appKey = [ADLibSession adlibAppKey];
    ALNativeAdTableHelper *nativeAdTableHelper = [[ALNativeAdTableHelper alloc] initWithTableView:self.tableView
                                                                                      nativeAdKey:appKey
                                                                                         delegate:self];
    self.nativeAdTableManager = nativeAdTableHelper;
    
    //async load native-AD list
    [_nativeAdTableManager requestNativeAdItemType:ALAdRequestItemTypeAll
                                      maximumCount:10
                                   timeoutInterval:30.];
}

#pragma mark - ALNativeAdTableHelper delegate

- (void)ALNativeAdTableHelper:(ALNativeAdTableHelper *)helper didReceivedNativeAd:(ALNativeAd *)nativeAd
{
    if (_adItemIndexList.count > 0) {
        
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
