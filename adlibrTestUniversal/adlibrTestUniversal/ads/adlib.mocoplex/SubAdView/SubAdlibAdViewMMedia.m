/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

/*
 * confirmed compatible with MillennialMedia SDK 5.1.0
 */

#import "SubAdlibAdViewMMedia.h"

// MILLENNIAL MEDIA의 APP 아이디를 설정합니다.
#define MMEDIA_ID @"MILLENNIALMEDIA_ID"

#define MILLENNIAL_IPHONE_AD_VIEW_FRAME CGRectMake(0, 0, 320, 50)
#define MILLENNIAL_IPAD_AD_VIEW_FRAME CGRectMake(0, 0, 728, 90)
#define MILLENNIAL_AD_VIEW_FRAME ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? MILLENNIAL_IPAD_AD_VIEW_FRAME : MILLENNIAL_IPHONE_AD_VIEW_FRAME)

@implementation SubAdlibAdViewMMedia

- (void)query:(UIViewController*)parent
{
    [super query:parent];
 
    // Returns an autoreleased MMAdView object
    ad = [[MMAdView alloc] initWithFrame:MILLENNIAL_AD_VIEW_FRAME
                                    apid:MMEDIA_ID
                      rootViewController:parent];
    
    // Ad banner to the view
    [self.view addSubview:ad];
    [self getAd];
}

- (CGSize)size
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    int w;
    if([self isPortrait])
    {
        w = screenWidth;
    }
    else
    {
        w = screenHeight;
    }
    
    if(iPad)    
        return CGSizeMake(w, 90);
    else
        return CGSizeMake(w, 50);
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

- (void)getAd {
    // Get a banner ad
    [ad getAd:^(BOOL success, NSError *error) {
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
