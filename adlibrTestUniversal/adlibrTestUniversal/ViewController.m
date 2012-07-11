/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

#import "ViewController.h"
#import "AdlibManager.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 서버에서 설정한 버전정보를 가져옵니다.
    // 기존 클라이언트 버전을 확인하여 적절한 작업을 수행하세요.
    NSString* ver = [[AdlibManager sharedSingletonClass] getCurrentVersion];
    if( ver != nil)
    {
        double now = 1.0;
        if(now < [ver doubleValue])
        {
            UIAlertView *alert = [[UIAlertView alloc] init];
            [alert setTitle:@"버전확인"];
            [alert setMessage:@"새로운 버전이 업데이트 되었습니다.\n지금 업데이트 하시겠습니까?"];
            [alert setDelegate:nil];
            [alert addButtonWithTitle:@"Yes"];  // 앱스토어 이동 등의 액션은 별도 구현해주세요.
            [alert addButtonWithTitle:@"No"];
            [alert show];
            [alert release];            
        }
    }    
}

// 광고를 수신했다. 광고view 의 크기와 위치를 재설정한다.
- (void)layoutForAD
{
    CGPoint adPoint = CGPointMake(0, 0);
    CGRect rt = self.view.frame;
    
    // 광고 view의 크기
    CGSize sz = [[AdlibManager sharedSingletonClass] size];
    
    NSLog(@"layout : %@",NSStringFromCGSize(sz));
    
    BOOL bBannerBottom = YES;
    
    if(!bBannerBottom)
    {
        // 상단에 광고 위치
        rt = CGRectMake(0, sz.height, rt.size.width, self.view.bounds.size.height-sz.height);
    }
    else
    {
        // 하단에 광고 위치        
        rt = CGRectMake(0, 0, rt.size.width, self.view.bounds.size.height-sz.height);
        adPoint = CGPointMake(0, self.view.bounds.size.height-sz.height);
    }
    
    [[AdlibManager sharedSingletonClass] moveAdContainer:adPoint];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[AdlibManager sharedSingletonClass] attach:self withView:self.view withReceiver:@selector(layoutForAD)];
    
    // 또는 페이지 이름을 지정하여, 스케줄 설정에 이용할 수 있습니다.
    //[[AdlibManager sharedSingletonClass] attach:self withView:self.view withDelegate:self withPageName:@"pagename"] ;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


/*
 // delegate 로 연결한 경우
 - (void)gotAd
 {
 CGPoint adPoint = CGPointMake(0, 0);
 CGRect rt = tv.frame;
 
 // 광고 view의 크기
 CGSize sz = [[AdlibManager sharedSingletonClass] size];
 
 NSLog(@"layout : %@",NSStringFromCGSize(sz));
 
 if(!bBannerBottom)
 {
 // 상단에 광고 위치
 rt = CGRectMake(0, sz.height, rt.size.width, self.view.bounds.size.height-sz.height);
 tv.frame = rt;
 }
 else
 {
 // 하단에 광고 위치        
 rt = CGRectMake(0, 0, rt.size.width, self.view.bounds.size.height-sz.height);
 tv.frame = rt;
 adPoint = CGPointMake(0, self.view.bounds.size.height-sz.height);
 }
 
 [[AdlibManager sharedSingletonClass] moveAdContainer:adPoint];
 }
 */

-(void)viewWillDisappear:(BOOL)animated
{
    [[AdlibManager sharedSingletonClass] detach:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
