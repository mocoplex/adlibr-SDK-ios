//
//  SongListTableViewController.m
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 15..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import "SongListTableViewController.h"
#import "SongListTableViewCell.h"
#import "SampleFeedItem.h"
#import "ALExampleMusicAdCell.h"

#import <Adlib/ADLibSDK.h>
#import "SampleKey.h"


static NSString * const SongListCellIndetifier = @"SongListTableViewCell";
static NSString * const AdCellNibIdentifier    = @"ALExampleMusicAdCell";

#define kTitle @"SongList Type"
#define kMapKeyIsAd @"isAd"
#define kMapKeyItem @"item"


@interface SongListTableViewController () <ALNativeAdTableHelperDelegate>

@property (nonatomic) IBOutlet UIBarButtonItem *loadMoreItem;

// 테이블 뷰 컨트롤러에서 사용할 리스트
@property (nonatomic, strong) NSMutableArray *tableItemList;

// 어플리케이션에서 이미지 URL 캐시 다운로드를 사용할 수 있도록 제공하는 클래스
// 개발사에서 사용하는 이미지 다운로드 방식으로 대체 사용을 권장합니다.
@property (nonatomic, strong) ALImageDownloader *imageLoader;

// 광고 클릭 이벤트 처리를 위해 ALNativeAdTableManager 객체를 사용
@property (nonatomic, strong) ALNativeAdTableHelper *nativeAdTableManager;

// Native 광고 객체의 인덱스 리스트
@property (nonatomic, strong) NSMutableArray *adItemIndexList;

@end


@implementation SongListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = kTitle;

    //어플리케이션에서 사용하는 이미지 다운로드 방식이 이미 존재한다면 사용하지 않아도된다.
    //샘플 프로젝트 코드를 위해 편의로 제공하는 클래스이며, ALNativeAd 클래스에서 내부적으로 사용하는 방식과 다를 수 있다.
    _imageLoader = [[ALImageDownloader alloc] init];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    if ([self.tableView respondsToSelector:@selector(setEstimatedRowHeight:)]) {
        [self.tableView setEstimatedRowHeight:80.0]; // "average" row height
    }
    
    //register ad_cell nib
    [self.tableView registerNib:[UINib nibWithNibName:AdCellNibIdentifier bundle:nil]
         forCellReuseIdentifier:AdCellNibIdentifier];

    NSMutableArray *tableItemList = [[NSMutableArray alloc] init];
    self.tableItemList = tableItemList;

    [self pv_loadTableItemList];
    [self pv_loadNativeAds];
}

- (void)dealloc
{
    [_nativeAdTableManager cancelReqeust];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)reload:(id)sender
{
    if (_tableItemList) {
        
        [_tableItemList removeAllObjects];

        self.title = @"reload ...";
        [self pv_loadTableItemList];
        [self pv_loadNativeAds];
        [self performSelector:@selector(pv_reloadTitle) withObject:nil afterDelay:1.];
    }
}

#pragma mark - <UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    if (nativeAd) {
        return 90.;
    }
    
    return 70.;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableItemList.count;
}

// 광고 뷰 셀 생성 및 소재 랜더링을 구현합니다.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALNativeAd *nativeAd = [self pv_nativeAdObjectAtRow:indexPath.row];
    if (nativeAd) {
        
        ALExampleMusicAdCell *cell = (id)[_nativeAdTableManager adCellForAd:nativeAd
                                                             cellIdentifier:AdCellNibIdentifier
                                                               forIndexPath:indexPath];
        return cell;
    }
    
    SongListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SongListCellIndetifier forIndexPath:indexPath];
    SongListItem *listItem = [self pv_tableObjectAtRow:indexPath.row];
    cell.titleLabel.text = listItem.title;
    cell.artistLabel.text = listItem.artist;
    cell.durationLabel.text = listItem.duration;
    
    NSURL *imageDownloadUrl = [NSURL URLWithString:listItem.thumbUrlString];
    [_imageLoader downloadImageForURL:imageDownloadUrl intoImageView:cell.thumbImageView];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

// 광고 뷰 셀이 화면에 노출되는 상황의 처리를 위해 필요
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_nativeAdTableManager willDisplayCell:cell forRowAtIndexPath:indexPath];
}

// 광고 뷰 셀이 화면에서 사라지는 상황의 처리를 위해 필요
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [_nativeAdTableManager didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
}

// 광고뷰 셀 선택 시 처리를 구현합니다.
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

#pragma mark - 

- (void)pv_loadTableItemList
{
    _loadMoreItem.enabled = NO;
    
    // 어플리케이션의 데이터 리스트를 불러 옵니다.
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"sample_song"
                                                         ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    NSJSONReadingOptions jsonParseOption = NSJSONReadingMutableContainers | NSJSONReadingMutableContainers;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:jsonParseOption
                                                               error:&error];
    NSArray *songListDictionary = [jsonData objectForKey:@"list"];
    
    NSNumber *idn = nil;
    NSString *title = nil;
    NSString *artist = nil;
    NSString *duration = nil;
    NSString *thumbUrl = nil;
    
    SongListItem *songItem = nil;
    
    for (NSDictionary *songData in songListDictionary) {
        idn      = [songData objectForKey:@"id"];
        title    = [songData objectForKey:@"title"];
        artist   = [songData objectForKey:@"artist"];
        duration = [songData objectForKey:@"duration"];
        thumbUrl = [songData objectForKey:@"thumb_url"];

        songItem = [[SongListItem alloc] init];
        songItem.songid = [idn integerValue];
        songItem.title = title;
        songItem.artist = artist;
        songItem.duration = duration;
        songItem.thumbUrlString = thumbUrl;
        
        NSMutableDictionary *tableItemInfo = [[NSMutableDictionary alloc] init];
        [tableItemInfo setObject:[NSNumber numberWithBool:NO] forKey:kMapKeyIsAd];
        [tableItemInfo setObject:songItem forKey:kMapKeyItem];
        [_tableItemList addObject:tableItemInfo];
    }

    [self.tableView reloadData];
    
    _loadMoreItem.enabled = YES;
}

- (void)pv_loadNativeAds
{
    NSMutableArray *indexList = [[NSMutableArray alloc] initWithArray:@[@(5)]];
    self.adItemIndexList = indexList;
    
    //앱 업데이트시에는 발급받으신 키로 교체하세요.
    NSString *appKey = kTEST_KEY_ADLIB;
    if (appKey == nil) {
        return;
    }
    
    ALNativeAdTableHelper *nativeAdTableHelper = [[ALNativeAdTableHelper alloc] initWithViewController:self
                                                                                             tableView:self.tableView
                                                                                              adlibKey:appKey
                                                                                              delegate:self];
    
    self.nativeAdTableManager = nativeAdTableHelper;
    
    self.nativeAdTableManager.isTestMode = YES;
    
    //async load native-AD list
    [_nativeAdTableManager requestNativeAdItemType:ALAdRequestItemTypeImageAd];
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

- (SongListItem *)pv_tableObjectAtRow:(NSUInteger)row
{
    if (_tableItemList == nil || row >= _tableItemList.count) {
        return nil;
    }
    
    NSMutableDictionary *tableItemInfo = [_tableItemList objectAtIndex:row];
    
    BOOL isAds = [[tableItemInfo objectForKey:kMapKeyIsAd] boolValue];
    if (isAds == YES) {
        return nil;
    }
    
    SongListItem *listItem = [tableItemInfo objectForKey:kMapKeyItem];
    return listItem;
}

- (void)pv_reloadTitle
{
    self.title = kTitle;
}


#pragma mark - ALNativeAdTableHelper delegate

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
