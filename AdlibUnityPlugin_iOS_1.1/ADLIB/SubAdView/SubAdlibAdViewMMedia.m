/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with MillennialMedia SDK 5.3.0
 */

#import "SubAdlibAdViewMMedia.h"

/* 
 MillennialMedia v5.2.0 이상부터는
 AppDelegate의 didFinishLaunchingWithOptions 메소드에서
 [MMSDK initialize]; 
 를 반드시 호출해 주세요.
 */

// MILLENNIAL MEDIA의 APP 아이디를 설정합니다.
#define MMEDIA_ID @"MILLENNIALMEDIA_ID"

#define MILLENNIAL_IPHONE_AD_VIEW_FRAME CGRectMake(0, 0, 320, 50)

@implementation SubAdlibAdViewMMedia

- (int)getCenterPos
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    int w,w2=0;
    if([self isPortrait])
    {
        w = screenWidth;
    }
    else
    {
        w = screenHeight;
    }
    
    w2 = 320;
    
    return (w-w2)/2;
}

- (void)query:(UIViewController*)parent
{
    [super query:parent];
    
    // Returns an autoreleased MMAdView object
    ad = [[MMAdView alloc] initWithFrame:MILLENNIAL_IPHONE_AD_VIEW_FRAME
                                    apid:MMEDIA_ID
                      rootViewController:parent];
    
    // Ad banner to the view
    [self.view addSubview:ad];
    [self getAd];
}

- (CGSize)size
{
    return CGSizeMake(320, 50);
}

- (void)orientationChanged
{
    [super orientationChanged];
    
    ad.frame = CGRectMake([self getCenterPos], 0, 320, 50);
}

- (void)clearAdView
{
    [super clearAdView];
    
    if(ad != nil)
    {
        ad.rootViewController = nil;
        ad = nil;
    }
}

#pragma mark - Get Ad

- (void)getAd
{
    MMRequest *request = [MMRequest request];
    
    // Get a banner ad
    [ad getAdWithRequest:request onCompletion:^(BOOL success, NSError *error) {
        if (success) {
            // 화면에 광고를 보여줍니다.
            [self gotAd];
        }
        else {
            // 광고 수신에 실패하였습니다.
            [self failed];
        }
    }];
}

@end
