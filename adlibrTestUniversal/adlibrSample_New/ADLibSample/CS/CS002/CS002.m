//
//  CS002.m
//  ADLibSample
//
//  Created by gskang on 2017. 3. 29..
//
//

#import "CS002.h"
#import <Adlib/ADLibBanner.h>

#import "SampleKey.h"

@interface CS002 () <ALDynamicBannerDelegate>

@property (nonatomic) IBOutlet UIView *adView;

@property (nonatomic, strong) ALDynamicBanner *banner;

@end


@implementation CS002

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadRequest];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self cancelRequest];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_banner needLayoutSubviews:_adView.bounds];
}

- (void)loadRequest
{
    ALDynamicBanner *banner = [[ALDynamicBanner alloc] initWithKey:kTEST_KEY_ADLIBHOUSE
                                                       contentSize:CGSizeMake(320, 480)
                                                          delegate:self];
    self.banner = banner;
    
    //애드립, 애드립하우스를 대시보드상의 설정된 스케쥴에 따라 요청하는 기능을
    //사용할 경우 해당 변수를 YES로 설정.
    self.banner.useAdlibSchedule = YES;
    
    [banner loadRequestInterstitial];
}

- (void)cancelRequest
{
    [self.banner cancelAdRequest];
}

- (void)alDynamicBannerDidReceivedAd:(ALDynamicBanner *)dynamicBanner
{
    [dynamicBanner attachToView:_adView];
}

- (void)alDynamicBanner:(ALDynamicBanner *)dynamicBanner
   didFailedAdWithState:(ALDynamicBannerState)state
{
    NSLog(@"ALDynamicBanner failed : %@", [ALDynamicBanner logForBannerState:state]);
}


@end
