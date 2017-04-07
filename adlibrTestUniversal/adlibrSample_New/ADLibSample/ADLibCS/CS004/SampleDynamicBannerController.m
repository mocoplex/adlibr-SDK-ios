//
//  ALDynamicBannerController.m
//  Adlib
//
//  Created by gskang on 2015. 10. 28..
//  Copyright © 2015년 mocoplex. All rights reserved.
//

#import "SampleDynamicBannerController.h"

@interface SampleDynamicBannerController ()

@property (nonatomic, strong) ALDynamicBannerView *bannerView;

@property (nonatomic, strong) UIButton *closeButton;

@end


@implementation SampleDynamicBannerController

- (instancetype)initWithBannerView:(ALDynamicBannerView *)bannerView
{
    self = [super init];
    
    if (self) {
        
        self.view.backgroundColor = [UIColor blackColor];
        self.bannerView = bannerView;
        
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            [self setAutomaticallyAdjustsScrollViewInsets:NO];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(al_applicationWillResignActive:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)al_applicationWillResignActive:(NSNotification *)noti
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self al_layoutAdView];
    
    if (_bannerView) {
        [self.view addSubview:self.bannerView];
        [self.view bringSubviewToFront:self.bannerView];
    }
    
    [self.view addSubview:self.closeButton];
    [self.view bringSubviewToFront:self.closeButton];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_bannerView removeFromSuperview];
    self.bannerView = nil;
    
    [self.closeButton removeFromSuperview];
    self.closeButton = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self al_layoutAdView];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        
        UIViewAutoresizing mask = UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleBottomMargin;
        
        CGFloat buttonSize = 42.f;
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];
        _closeButton.autoresizingMask = mask;
        
        [_closeButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
        [_closeButton setTitle:@"X" forState:UIControlStateNormal];
        
        _closeButton.hidden = NO;
        
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self
                         action:@selector(al_closeButtonPressed)
               forControlEvents:UIControlEventTouchUpInside];
        
        _closeButton.clipsToBounds = YES;
        
        UIImage *closeBtnImage = nil;
        NSString *filename = @"adlib_default_btn_close.png";
        NSString *filepath = nil;
        
        NSString *pathBundle = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Adlib.bundle"];
        NSBundle *libBundle = [NSBundle bundleWithPath:pathBundle];
        
        if( libBundle && filename ){
            filepath = [[libBundle resourcePath] stringByAppendingPathComponent:filename];
            if (filepath) {
                closeBtnImage = [UIImage imageWithContentsOfFile:filepath];
            }
        }
        
        if (closeBtnImage) {
            [_closeButton setImage:closeBtnImage forState:UIControlStateNormal];
            [_closeButton setTitle:nil forState:UIControlStateNormal];
        }
        
    }
    
    return _closeButton;
}

- (void)al_layoutAdView
{
    self.view.backgroundColor = _bannerView.backgroundColor;
    
    CGFloat topMargin = 0;
    CGFloat marginHeight = 20;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        topMargin = marginHeight;
    } else {
        topMargin = 0;
    }
    
    self.bannerView.frame = CGRectMake(0,
                                       topMargin,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height - topMargin*2);
    
    
    
    self.bannerView.layer.frame = CGRectMake(0,
                                             topMargin,
                                             self.view.layer.bounds.size.width,
                                             self.view.layer.bounds.size.height - topMargin*2);
    
    CGFloat originX = self.view.bounds.size.width - self.closeButton.bounds.size.width - topMargin;
    self.closeButton.frame = CGRectMake(originX,
                                        topMargin,
                                        self.closeButton.bounds.size.width,
                                        self.closeButton.bounds.size.height);
}

- (void)al_closeButtonPressed
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
