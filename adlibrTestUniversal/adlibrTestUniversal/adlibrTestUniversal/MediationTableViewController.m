//
//  MediationTableViewController.m
//  AdlibNativeADSample
//
//  Created by gskang on 2015. 2. 12..
//  Copyright (c) 2015년 gskang. All rights reserved.
//

#import "MediationTableViewController.h"
#import <Adlib/Adlib.h>

@interface MediationTableViewController () <AdlibManagerDelegate>

@property (nonatomic, strong) IBOutlet UIView *adContainerView;

@end


@implementation MediationTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    _adContainerView.clipsToBounds = YES;
    _adContainerView.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[AdlibManager sharedSingletonClass] attach:self
                                       withView:self.adContainerView
                                   withDelegate:self
                                   defaultAlign:ADLIB_BANNER_ALIGN_CENTER];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[AdlibManager sharedSingletonClass] detach:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

#pragma mark -

//전면광고 관련 delegate:optional
-(void)didReceiveAdlibInterstitialAd:(NSString*)from
{
    NSLog(@"%@ Interstitial Ad 수신 성공!!",from);
}

-(void)didFailToReceiveAdlibInterstitialAd:(NSString*)from
{
    NSLog(@"%@ Interstitial Ad 수신 실패..", from);
}

-(void)didCloseAdlibInterstitialAd:(NSString*)from
{
    NSLog(@"%@ Interstitial Ad 닫힘..", from);
}

-(void)didFailToReceiveAllInterstitialAd
{
    NSLog(@"%@", @"설정된 모든 Interstitial Ad 수신 실패");
}

-(void)didReceiveAdlibAd:(NSString*)from
{
    NSString *msg = [NSString stringWithFormat:@"%@ : Ad 수신 성공",from];
    NSLog(@"%@", msg);
}

-(void)didFailToReceiveAdlibAd:(NSString*)from
{
    NSString *msg = [NSString stringWithFormat:@"%@ : Ad 수신 실패",from];
    NSLog(@"%@", msg);
}

@end
