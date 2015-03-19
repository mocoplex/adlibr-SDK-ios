//
//  BannerXibViewController.m
//  ADLib-sample-project
//
//  Created by gskang on 2015. 3. 3..
//  Copyright (c) 2015년 adlibr. All rights reserved.
//

#import "BannerXibViewController.h"
#import <Adlib/Adlib.h>

// Main.Storyboard BannerXibViewController에서
// adContainerView를 생성 오토레이아웃을 적용한 예제

@interface BannerXibViewController () <AdlibManagerDelegate>

@end


@implementation BannerXibViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MediationBanner Sample";
    self.view.backgroundColor = [UIColor colorWithRed:0.90 green:0.91 blue:0.91 alpha:1.0];
    
    _adContainerView.backgroundColor = [UIColor clearColor];
    _adContainerView.clipsToBounds = YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //StoryBoard 상에서 adContainerView에 오토레이아웃 속성 적용으로
    //추가 처리하지 않습니다.
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
