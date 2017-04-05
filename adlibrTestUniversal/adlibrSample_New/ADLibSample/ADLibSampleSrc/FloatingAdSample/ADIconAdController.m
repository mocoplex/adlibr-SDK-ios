//
//  ADIconAdController.m
//  adlibrTestUniversal
//
//  Created by gskang on 2016. 1. 21..
//  Copyright © 2016년 adlibr. All rights reserved.
//

#import "ADIconAdController.h"
#import <Adlib/ADLibSDK.h>

#import "SampleKey.h"


@interface ADIconAdController () <ALIconAdLoaderDelegate>

@property (nonatomic, strong) ALIconAdLoader *iconAdLoader;

@end


@implementation ADIconAdController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"Icon Ad";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSURL *url = [NSURL URLWithString:@"https://google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadBanner];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self clearAllAd];
}

- (void)clearAllAd
{
    [self.iconAdLoader detachAdView];
    self.iconAdLoader = nil;
}

- (void)dealloc
{
    [self clearAllAd];
}

- (void)loadBanner
{
    [self clearAllAd];
    
    ALIconAdLoader *loader = [[ALIconAdLoader alloc] init];
    self.iconAdLoader = loader;
    //self.iconAdLoader.iconAlign = ALIconAdAlignRIGHT;
    
#warning TEST MODE 설정 확인
    self.iconAdLoader.isTestMode = YES;
    
    //앱 업데이트시에는 발급받으신 키로 교체하세요.
    NSString *appKey = kTEST_KEY_ADLIB;
    
    [self.iconAdLoader loadAdWithKey:appKey delegate:self];
}

#pragma mark - ALIconAdLoaderDelegate

// 광고 수신 성공 델리게이트
- (void)ALIconAdLoaderDidReceivedAd:(ALIconAdLoader *)iconAdLoader
{
    //어플리케이션 key window에 노출처리
    [iconAdLoader attachAdViewToMainWindow];
    
    //지정한 뷰위에 노출처리
    //[iconAdLoader attachAdViewToView:self.view];
}

// 광고 수신 실패 델리게이트
- (void)ALIconAdLoader:(ALIconAdLoader *)iconAdLoader didFailedError:(NSError *)error
{
    NSLog(@"ALIconAdLoader request error : %@", error);
}

#pragma mark - UIViewController delegate : rotate event

//iOS 8.0 이상
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         [self.iconAdLoader reloadContentForParentViewRotate];
     }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

//iOS 8.0 미만
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.iconAdLoader reloadContentForParentViewRotate];
}

@end
