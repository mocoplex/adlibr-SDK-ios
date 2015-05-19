//
//  SubAdlibAdAdmixer.h
//  AdlibNativeADSample
//
//  Created by gskang on 2015. 3. 12..
//  Copyright (c) 2015년 gskang. All rights reserved.
//

/*
 * confirmed compatible with admixer SDK 1.3.1
 */

#import <Foundation/Foundation.h>
#import <Adlib/Adlib.h>
#import "AdMixerInfo.h"
#import "AdMixerInterstitial.h"
#import "AdMixerView.h"

@interface SubAdlibAdAdmixer : SubAdlibAdViewCore {
    BOOL _iPad;
}

@property (nonatomic, strong) AdMixerView *adView;

@end
