//
//  ViewTypeController.m
//  AdlibNativeADSample
//
//  Created by gskang on 2014. 12. 22..
//  Copyright (c) 2014년 gskang. All rights reserved.
//

#import "ViewTypeController.h"
#import <MediaPlayer/MediaPlayer.h>

#import <Adlib/ADLibSDK.h>
#import "SampleKey.h"

#import "SampleFeedItem.h"


#define kMapKeyIsAd @"isAd"
#define kMapKeyItem @"item"

#define kHeightOfScrollView 172

#define kWidthOfContentView 300
#define kHeightOfContentView 172

#define kCountOfContents 4
#define kIndexOfAd 3

@interface ViewTypeController () <ALNativeAdRequestDelegate>

@property (nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *contentsList;
@property (nonatomic, strong) ALImageDownloader *imageLoader;

@property (nonatomic, strong) ALNativeAdRequest *request;
@property (nonatomic, strong) ALNativeAd *nativeAd;

@property (nonatomic, strong) ALNativeAdView *adView;

@end


@implementation ViewTypeController

/*
 *  네이티브 광고를 뷰 형태로 사용할 경우 적용 샘플 코드입니다.
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"ScrollView Type";
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    // AppDelegate에서 이미 설정 (동영상 광고를 포함해서 App 외부 출력과 Mix 설정의 코드로 필요 시 설정합니다.
    //    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
    //                                     withOptions:AVAudioSessionCategoryOptionMixWithOthers
    //                                           error:nil];
    
    [self initializeScrollView];
    
    [self loadFeedList];
}

- (void)dealloc
{
    [self destroyNativeAdView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSInteger countOfItem = kCountOfContents;
    _scrollView.contentSize = CGSizeMake(kWidthOfContentView * countOfItem,
                                         kHeightOfContentView);
}

- (void)initializeScrollView
{
    _scrollView.contentSize = CGSizeMake(kWidthOfContentView * kCountOfContents,
                                         kHeightOfContentView);
    
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    _imageLoader = [[ALImageDownloader alloc] init];
}

- (void)loadFeedList
{
    NSMutableArray *contentsList = [[NSMutableArray alloc] initWithCapacity:kCountOfContents];
    self.contentsList = contentsList;
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"sample_list"
                                                         ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    
    SampleFeedItemDeserializer *deserializer = [SampleFeedItemDeserializer deserializer];
    NSArray *results = [deserializer sampleFeedItemArrayForData:data error:&error];
    
    for (SampleFeedItem *item in results) {
        [_contentsList addObject:item];
    }

    for (int i = 0 ; i < kCountOfContents; i++) {
        
        if (i != kIndexOfAd) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + i*kWidthOfContentView,
                                                                                 0,
                                                                                 kWidthOfContentView,
                                                                                 kHeightOfContentView)];
            imgView.clipsToBounds = YES;
            
            [_scrollView addSubview:imgView];
            
            SampleFeedItem *item = [_contentsList objectAtIndex:i];
            NSString *imageUrlStr = item.imageUrlString;
            
            if (imageUrlStr) {
                NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
                [_imageLoader downloadImageForURL:imageUrl intoImageView:imgView];
            }
        }
    }
    
    [self loadVideoAd];
}


- (void)loadVideoAd
{
    [self destroyNativeAdView];
    
    //앱 업데이트시에는 발급받으신 키로 교체하세요.
    NSString *appKey = kTEST_KEY_ADLIB;
    
    _request = [[ALNativeAdRequest alloc] initAdRequestWithKey:appKey];
    _request.delegate = self;
    
    _request.isTestMode = YES;
    _request.requestItemType = ALAdRequestItemTypeVideoAd;
    
    [_request startAdRequest];
}

- (void)destroyNativeAdView
{
    if (_request) {
        _request.delegate = nil;
        [_request cancelAdRequest];
        self.request = nil;
    }
    
    if (_adView) {
        [_adView updateAutoPlayEnable:NO];
        [_adView removeFromSuperview];
        self.adView = nil;
    }
}

#pragma mark - ALNativeAdRequestDelegate

//광고 수신 성공 델리게이트
- (void)nativeAdRequest:(ALNativeAdRequest *)request didReceivedNativeAds:(NSArray *)nativeAdList
{
    if (nativeAdList.count > 0) {
        
        self.nativeAd = [nativeAdList firstObject];
        
        if (_adView) {
            [_adView updateAutoPlayEnable:NO];
            [_adView removeFromSuperview];
            self.adView = nil;
        }
        
        ALNativeAdView *adView = [[[NSBundle mainBundle] loadNibNamed:@"ALNativeViewSample"
                                                                owner:self
                                                              options:nil] lastObject];
        
        adView.frame = CGRectMake(kIndexOfAd * kWidthOfContentView,
                                  0,
                                  kWidthOfContentView,
                                  kHeightOfContentView);
        
        self.adView = adView;
        
        [_scrollView addSubview:adView];
        
        //클릭 처리를 위해 뷰컨트롤러 지정
        [adView assignPresentingViewController:self];
        
        //내부 컨텐츠 그리기 시도
        [adView layoutAdProperties:_nativeAd loadContent:YES];
        
    }
}

//광고 수신 실패 델리게이트
- (void)nativeAdRequest:(ALNativeAdRequest *)request didFailWithErrorCode:(ALAdRequestErrCode)code
{
    NSLog(@"error : %@", [ALNativeAdRequest msgForErrorCode:code]);
    
    //네이티브 광고가 없는 경우 샘플 피드 이미지 노출
    if (_contentsList.count > kIndexOfAd) {
        
        SampleFeedItem *item = [_contentsList objectAtIndex:kIndexOfAd];
        
        if (item) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + kIndexOfAd*kWidthOfContentView,
                                                                                 0,
                                                                                 kWidthOfContentView,
                                                                                 kHeightOfContentView)];
            imgView.clipsToBounds = YES;
            
            [_scrollView addSubview:imgView];
            
            
            
            NSString *imageUrlStr = item.imageUrlString;
            
            if (imageUrlStr) {
                NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
                [_imageLoader downloadImageForURL:imageUrl intoImageView:imgView];
            }
        }
    }
}

@end
