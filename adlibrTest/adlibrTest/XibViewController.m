/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

#import "XibViewController.h"
#import "AdlibManager.h"

@implementation XibViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - for Adlib

// 광고를 수신했다. 광고view 의 크기와 위치를 재설정한다.
- (void)whenGotAd
{
    CGPoint adPoint = CGPointMake(0, 0);
    [[AdlibManager sharedSingletonClass] moveAdContainer:adPoint];

    // 광고 view의 크기
    CGSize sz = [[AdlibManager sharedSingletonClass] size];
    CGRect rt = self.view.bounds;
    rt.origin.y = sz.height;
    rt.size.height -= sz.height;
    
    www.frame = rt;    
}
-(void)viewWillAppear:(BOOL)animated
{
    // 광고뷰를 연결합니다. 페이지 이름을 설정하면 세부적인 설정으로 페이지마다 노출 정책을 다르게 설정할 수 있습니다.
    // http://adlib.mocoplex.com/media.aspx
    // 페이지별 설정 메뉴에서 상세 정책을 지정, 적용할 수 있습니다.
    [[AdlibManager sharedSingletonClass] attach:self withView:self.view withReceiver:@selector(whenGotAd) withPageName:@"xxxx"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[AdlibManager sharedSingletonClass] detach:self];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [www loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
