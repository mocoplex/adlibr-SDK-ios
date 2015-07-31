//
//  MediationBannerViewController.m
//  AdlibNativeADSample
//
//  Created by mocoplex on 2015. 1. 27..
//  Copyright (c) 2015년 mocoplex. All rights reserved.
//

#import "MediationBannerViewController.h"
#import <Adlib/Adlib.h>

@interface MediationBannerViewController () <AdlibManagerDelegate>

@property (nonatomic, strong) UIView *adContainerView;

@end

@implementation MediationBannerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"MediationBanner Sample";
    self.view.backgroundColor = [UIColor colorWithRed:0.90 green:0.91 blue:0.91 alpha:1.0];
    
    //1. 광고 컨테이너뷰 생성 및 뷰에서의 위치 설정
    [self loadBannerContainerView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //배너뷰의 기본 크기는 CGSizeMake(320, 50)로 정의되어 있으며 가로의 경우 디바이스 가로 넓이 값으로
    //조정 가능 해당 크기를 지원하는 플랫폼 광고의 경우 조정되어 노출됩니다.
    CGFloat bannerViewHeight = kAdlibDefaultBannerSize.height;
    CGFloat originY = self.view.bounds.size.height - bannerViewHeight;
    _adContainerView.frame = CGRectMake(0,
                                        originY,
                                        self.view.frame.size.width,
                                        _adContainerView.bounds.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AdlibManager *manager = [AdlibManager sharedSingletonClass];
    
    //미디에이션 배너 뷰를 해당 뷰 컨트롤러의 컨테이너뷰에 추가합니다.
    [manager attachWithViewController:self
                      atContainerView:_adContainerView];
    
    //애드립 delegate를 지정합니다. (추가정보를 받고 싶을 경우 연결합니다.)
    manager.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    AdlibManager *manager = [AdlibManager sharedSingletonClass];
    
    //미디에이션 배너 뷰를 컨테이너 뷰에서 제거합니다.
    [manager detach:self];
    manager.delegate = nil;
}

- (void)dealloc
{
    ;
}

- (void)loadBannerContainerView
{
    CGFloat bannerViewHeight = kAdlibDefaultBannerSize.height;
    CGFloat originY = self.view.bounds.size.height - bannerViewHeight;
    
    _adContainerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                originY,
                                                                self.view.frame.size.width,
                                                                bannerViewHeight)];
    _adContainerView.backgroundColor = [UIColor clearColor];
    _adContainerView.clipsToBounds = YES;
    
    [self.view addSubview:_adContainerView];
}

// 전면광고 호출 버튼
// 미디에이션에 등록된 플랫폼들에 대해 전면광고 요청을 수행합니다.
// 설정된 스케쥴 순서에 따라 요청되며 실제 전면 공고 호출은
// SubAdlibAdView Class에서 처리됩니다.
- (IBAction)loadInterstitialAd:(UIButton *)button
{
    AdlibManager *manager = [AdlibManager sharedSingletonClass];
    [manager loadInterstitialAd:self withDelegate:self];
}

#pragma mark -

//특정 플랫폼 띠배너 수신 성공시 알림
-(void)didReceiveAdlibAd:(NSString*)from
{
    NSString *msg = [NSString stringWithFormat:@"%@ : Ad 수신 성공",from];
    NSLog(@"%@", msg);
    _debugLabel.text = msg;
}

//특정 플랫폼 띠배너 수신 실패시 알림
-(void)didFailToReceiveAdlibAd:(NSString*)from
{
    NSString *msg = [NSString stringWithFormat:@"%@ : Ad 수신 실패",from];
    NSLog(@"%@", msg);
    _debugLabel.text = msg;
}

//특정 플랫폼 전면광고 수신 성공 시 알림
-(void)didReceiveAdlibInterstitialAd:(NSString*)from
{
    NSLog(@"%@ Interstitial Ad 수신 성공!!",from);
}

//특정 플랫폼 전면광고 관련 수신 실패 시 알림
-(void)didFailToReceiveAdlibInterstitialAd:(NSString*)from
{
    NSLog(@"%@ Interstitial Ad 수신 실패..", from);
}

//특정 플랫폼 전면광고 닫힘 알림
-(void)didCloseAdlibInterstitialAd:(NSString*)from
{
    NSLog(@"%@ Interstitial Ad 닫힘..", from);
}

//등록된 모든 플랫폼의 전면광고 요청 실패시의 알림
-(void)didFailToReceiveAllInterstitialAd
{
    NSLog(@"%@", @"설정된 모든 Interstitial Ad 수신 실패");
}

@end
