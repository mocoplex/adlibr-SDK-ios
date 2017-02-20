//
//  CollectionViewController.m
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 11. 28..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import "CollectionViewController.h"
#import <Adlib/ADLibSDK.h>

#import "SampleFeedItem.h"
#import "SampleCollectionViewCell.h"

#define kAdlibKey @"55666ab10cf2e4077da15c26" //@"550a53fa0cf2833915d72dae"

#define kMapKeyIsAd @"isNativeAd"
#define kMapKeyItem @"item"


@interface CollectionViewController () <ALNativeAdCollectionHelperDelegate>

@property (nonatomic, strong) NSMutableArray *tableItemList;

// 어플리케이션에서 이미지 URL 캐시 다운로드를 사용할 수 있도록 제공하는 클래스, 개발사에서 사용하는 이미지 다운로드 방식으로 대체 가능합니다.
@property (nonatomic, strong) ALImageDownloader *imageLoader;

// 애드립 네이티브 광고 요청 객체
@property (nonatomic, strong) ALNativeAdCollectionHelper *nativeAdHelper;

@property (nonatomic, strong) NSMutableArray *adItemIndexList;

@end


@implementation CollectionViewController

static NSString * const reuseIdentifier = @"sampleCell";
static NSString * const adSampleCellReuseIdentifier = @"ALSampleAdCollectionViewCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _imageLoader = [[ALImageDownloader alloc] init];
    _tableItemList = [[NSMutableArray alloc] init];
    
    [self.collectionView registerNib:[UINib nibWithNibName:adSampleCellReuseIdentifier bundle:nil]
          forCellWithReuseIdentifier:adSampleCellReuseIdentifier];
    
    
    [self pv_loadTableItemList];
}

- (void)dealloc
{
    [self.nativeAdHelper cancelReqeust];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tableItemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    UICollectionViewCell *cell = nil;
    // Configure the cell
    
    NSMutableDictionary *listItem = [_tableItemList objectAtIndex:indexPath.row];
    BOOL isAd = [[listItem objectForKey:kMapKeyIsAd] boolValue];
    
    if (isAd) {
        
        ALNativeAd *nativeAd = [listItem objectForKey:kMapKeyItem];
        
        //Imp, Clk 처리 등록
        [nativeAd registerViewForInteraction:cell];
        
        cell = (id)[_nativeAdHelper adCellForAd:nativeAd
                                 cellIdentifier:adSampleCellReuseIdentifier
                                   forIndexPath:indexPath];
        
    } else {
        SampleCollectionViewCell *sampleCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                         forIndexPath:indexPath];
        
        SampleFeedItem *item = [listItem objectForKey:kMapKeyItem];
        NSURL *imageDownloadUrl = [NSURL URLWithString:item.imageUrlString];
        [_imageLoader downloadImageForURL:imageDownloadUrl intoImageView:sampleCell.imageView];
    
        cell = sampleCell;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *listItem = [_tableItemList objectAtIndex:indexPath.row];
    BOOL isAd = [[listItem objectForKey:kMapKeyIsAd] boolValue];
    
    if (isAd) {
        ALNativeAd *item = [listItem objectForKey:kMapKeyItem];
        NSURL *clkURL = item.clickURL;
        [[UIApplication sharedApplication] openURL:clkURL];
    } else {
        SampleFeedItem *item = [listItem objectForKey:kMapKeyItem];
        NSURL *url = [NSURL URLWithString:item.urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.nativeAdHelper willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.nativeAdHelper didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
}

#pragma mark -

- (void)pv_loadTableItemList
{
    if (_tableItemList) {
        [_tableItemList removeAllObjects];
    }
    
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
    
    [self.collectionView reloadData];
    
    [self pv_loadNativeAd];
}

- (void)pv_loadNativeAd
{
    NSMutableArray *indexList = [[NSMutableArray alloc] initWithArray:@[@(3)]];
    self.adItemIndexList = indexList;
    
    BOOL isTestMode = YES;
    
    ALNativeAdCollectionHelper *nativeAdHelper = [[ALNativeAdCollectionHelper alloc] initWithViewController:self
                                                                                                  collectionView:self.collectionView
                                                                                                        adlibKey:kAdlibKey
                                                                                                        delegate:self];
    self.nativeAdHelper = nativeAdHelper;
    self.nativeAdHelper.isTestMode = isTestMode;
    
    //async load native-AD list
    [_nativeAdHelper requestNativeAdItemType:ALAdRequestItemTypeImageAd];
}

#pragma mark -

- (void)ALNativeAdCollectionHelper:(ALNativeAdCollectionHelper *)helper didReceivedNativeAds:(NSArray *)adList
{
    if (adList.count > 0 && _adItemIndexList.count > 0) {
        
        ALNativeAd *nativeAd = nil;
        @try {
            if (adList.count == 1) {
                nativeAd = [adList firstObject];
            } else {
                u_int32_t x = arc4random() % (adList.count); // 0 부터 n-1 랜덤 숫자
                nativeAd = [adList objectAtIndex:x];
                
            }
        } @catch (NSException *exception) {
            nativeAd = [adList firstObject];
        }
        
        NSNumber *idx = [_adItemIndexList firstObject];
        NSInteger rowIdx = [idx integerValue];
        [_adItemIndexList removeObjectAtIndex:0];
        
        NSMutableDictionary *tableItemInfo = [[NSMutableDictionary alloc] init];
        [tableItemInfo setObject:[NSNumber numberWithBool:YES] forKey:kMapKeyIsAd];
        [tableItemInfo setObject:nativeAd forKey:kMapKeyItem];
        [_tableItemList insertObject:tableItemInfo atIndex:rowIdx];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIdx inSection:0];
        NSArray *indexPaths = @[indexPath];
        [self.collectionView insertItemsAtIndexPaths:indexPaths];
    }
}

- (void)ALNativeAdCollectionHelper:(ALNativeAdCollectionHelper *)helper didFailedRequestWithError:(NSError *)error
{
    
}

@end
