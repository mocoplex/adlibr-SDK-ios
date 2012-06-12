/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

#import "ViewController.h"
#import "AdlibManager.h"
#import "XibViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - for tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",[indexPath row]];
    
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController* v = [[ViewController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
    [v release];
}

static int nViewController = 0;

#pragma mark - View lifecycle

- (void)loadViewControllerWithNib:(id)sender
{
    XibViewController* xib = [[XibViewController alloc] initWithNibName:@"XibViewController" bundle:nil];
    [self.navigationController pushViewController:xib animated:YES];
    [xib release];    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"nib" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(loadViewControllerWithNib:)];      
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv];
    tv.dataSource = self;
    tv.delegate = self;
    
    nController = nViewController;    
    
    // 크기 자동조절을 위한 flag 를 설정한다.
    [tv setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    // 광고의 크기 자동조절을 위한 flag 를 설정한다.
    if(nController %2 == 0)
    {
        bBannerBottom = NO;
        
        // 상단에 광고가 위치하는 경우        
        [[AdlibManager sharedSingletonClass] setAutoresizingMask:UIViewAutoresizingFlexibleWidth];        
    }
    else
    {   
        bBannerBottom = YES;
        
        // 하단에 광고가 위치하는 경우
        [[AdlibManager sharedSingletonClass] setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];        
    }
    
    self.title = [NSString stringWithFormat:@"#%d viewcontroller",nViewController++];    
}

// 광고를 수신했다. 광고view 의 크기와 위치를 재설정한다.
- (void)layoutForAD
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

-(void)viewWillAppear:(BOOL)animated
{
    [[AdlibManager sharedSingletonClass] attach:self withView:self.view withReceiver:@selector(layoutForAD)];
    
    /*
    // delegate 사용
    [[AdlibManager sharedSingletonClass] attach:self withView:self.view withDelegate:self];
    // delegate 로 연결한 경우 gotAd가 호출됩니다.
    */
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

- (void)viewDidUnload
{
    [tv release];
    
    [super viewDidUnload];
}

- (void)dealloc
{
    [super dealloc];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
@end
