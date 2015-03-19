//
//  SubAdlibAdAdmixer.h
//  AdlibNativeADSample
//
//  Created by gskang on 2015. 3. 12..
//  Copyright (c) 2015년 gskang. All rights reserved.
//

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
