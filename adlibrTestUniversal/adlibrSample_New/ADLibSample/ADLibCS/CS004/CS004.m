//
//  CS004.m
//  ADLibSample
//
//  Created by gskang on 2017. 4. 7..
//
//

#import "CS004.h"
#import "SampleKey.h"

#import <Adlib/ADLibBanner.h>
#import "SampleDynamicBannerController.h"


// 전면 광고에 사용할 앱 키
#define ADLIB_INTERSTITIAL_320x480_KEY  @"571496b87fa26a9cdaee7958" //320*480
#define kInterSize320x480 CGSizeMake(320, 480)

#define ADLIB_INTERSTITIAL_384x502_KEY  @"55e7ec830cf2085c33f3469e" //384x502
#define kInterSize384x502 CGSizeMake(384, 502)


@interface CS004 ()

@property (nonatomic, strong) ALDynamicBannerView *intersBannerView;
@property (nonatomic, weak) UIViewController *bannerModalViewController;

@end


@implementation CS004

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadAd:(id)sender
{
    bool isPort = YES;
    if (isPort) {
        
        [self loadPortAd];
        
    } else {
        
        [self loadLandAd];
    }
}

- (void)loadPortAd
{
    //실제 세로 모드 전면광고에서 사용할 키값과 소재의 사이즈를 수정해서 사용하세요.
    //320, 480으로 지정시 시스템상에 등록된 이미지는 2배수 기준 640, 960 크기의 이미지를 내려받을 수 있습니다.
    
    CGRect bound = CGRectMake(0, 0, kInterSize320x480.width, kInterSize320x480.height);
    
    ALDynamicBannerView *intersView = [[ALDynamicBannerView alloc] initWithFrame:bound];
    self.intersBannerView = intersView;
    
    __weak __typeof(self)weakSelf = self;
    [_intersBannerView setRequestAdStateHandler:^(ALDynamicBannerState state) {
        
        NSLog(@"_intersBannerView (Port) log state = %@", [ALDynamicBanner logForBannerState:state]);
        
        switch (state) {
            case ALDynamicBannerStateRequestStart:
                break;
                
            case ALDynamicBannerStateReceivedAd:
                [weakSelf al_presentModalViewController];
                break;
                
            case ALDynamicBannerStateResponseEmptyAd:
                break;
                
            default:
                //Error Case
                break;
        }
    }];
    
    //이미지 외의 영역의 백그라운드 색상 지정
    //해당 함수를 호출하지 않으면 해당 광고 집행시 설정된 색상값으로 채워진다.
    //[_intersBannerView setBannerBackgroundColor:[UIColor blackColor]];
    
    [_intersBannerView startBannerRequestWithAdlibKey:ADLIB_INTERSTITIAL_320x480_KEY
                                           bannerSize:kInterSize320x480];
}

- (void)loadLandAd
{
    //실제 가로 모드 전면광고에서 사용할 키값과 소재의 사이즈를 수정해서 사용하세요.
    
    CGRect bound = CGRectMake(0, 0, kInterSize384x502.width, kInterSize384x502.height);
    
    ALDynamicBannerView *intersView = [[ALDynamicBannerView alloc] initWithFrame:bound];
    self.intersBannerView = intersView;
    
    __weak __typeof(self)weakSelf = self;
    [_intersBannerView setRequestAdStateHandler:^(ALDynamicBannerState state) {
        
        NSLog(@"_intersBannerView (Port) log state = %@", [ALDynamicBanner logForBannerState:state]);
        
        switch (state) {
            case ALDynamicBannerStateRequestStart:
                break;
                
            case ALDynamicBannerStateReceivedAd:
                [weakSelf al_presentModalViewController];
                break;
                
            case ALDynamicBannerStateResponseEmptyAd:
                break;
                
            default:
                //Error Case
                break;
        }
    }];
    
    //이미지 외의 영역의 백그라운드 색상 지정
    //해당 함수를 호출하지 않으면 해당 광고에 설정된 색상값으로 채워진다.
    //[_intersBannerView setBannerBackgroundColor:[UIColor blackColor]];
    
    [_intersBannerView startBannerRequestWithAdlibKey:ADLIB_INTERSTITIAL_384x502_KEY
                                           bannerSize:kInterSize384x502];
}


// 전면광고 수신 후 모달뷰 컨트롤러 표시
- (void)al_presentModalViewController
{
    //내부의 구현은 수정해서 사용가능
    SampleDynamicBannerController *ctr = [[SampleDynamicBannerController alloc] initWithBannerView:self.intersBannerView];
    self.bannerModalViewController = ctr;
    
    [self presentViewController:ctr animated:YES completion:nil];
}

@end
