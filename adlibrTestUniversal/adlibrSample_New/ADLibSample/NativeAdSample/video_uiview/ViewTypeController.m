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

#import "SampleFeedItem.h"

#define ADLIB_NATIVEAD_KEY @"550a53fa0cf2833915d72dae"

#define kMapKeyIsAd @"isAd"
#define kMapKeyItem @"item"

#define kHeightOfScrollView 172

#define kWidthOfContentView 300
#define kHeightOfContentView 172

#define kCountOfContents 8
#define kIndexOfAd 2

@interface ViewTypeController () <ALNativeAdRequestDelegate>

@property (nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *contentsList;
@property (nonatomic, strong) ALImageDownloader *imageLoader;

@property (nonatomic, strong) ALNativeAdRequest *request;
@property (nonatomic, strong) ALNativeAd *nativeAd;

@end


@implementation ViewTypeController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"ScrollView Type";
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    [self initializeScrollView];
    
    [self loadFeedList];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSInteger countOfItem = kCountOfContents;
    _scrollView.contentSize = CGSizeMake(kWidthOfContentView * countOfItem,
                                         kHeightOfContentView);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
    if (_request) {
        _request.delegate = nil;
        [_request cancelAdRequest];
        self.request = nil;
    }
    
    _request = [[ALNativeAdRequest alloc] initAdRequestWithKey:ADLIB_NATIVEAD_KEY];
    _request.delegate = self;
    
    _request.isTestMode = YES;
    _request.requestItemType = ALAdRequestItemTypeVideoAd;
    
    [_request startAdRequest];
}

- (void)nativeAdRequest:(ALNativeAdRequest *)request didReceivedNativeAds:(NSArray *)nativeAdList
{
    if (nativeAdList.count > 0) {
        
        self.nativeAd = [nativeAdList firstObject];
        
        ALNativeAdView *adView = [[[NSBundle mainBundle] loadNibNamed:@"ALNativeViewSample" owner:self options:nil] lastObject];
        adView.frame = CGRectMake(kIndexOfAd * kWidthOfContentView,
                                  0,
                                  kWidthOfContentView,
                                  kHeightOfContentView);
        
        [_scrollView addSubview:adView];
        
        //클릭 처리를 위해 뷰컨트롤러 지정
        [adView assignPresentingViewController:self];
        
        //내부 컨텐츠 그리기 시도
        [adView layoutAdProperties:_nativeAd loadContent:YES];
        
        //화면상에서 인/아웃 시 재생 자동 처리
        [adView updateAutoPlayEnable:YES];
    }
}

- (void)nativeAdRequest:(ALNativeAdRequest *)request didFailWithErrorCode:(ALAdRequestErrCode)code
{
    NSLog(@"error : %@", [ALNativeAdRequest msgForErrorCode:code]);
}

@end
