//
//  ALAdapterAdMixer.h
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 8. 18..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import <Adlib/ALMediation.h>

@interface ALAdapterAdMixer : ALMediation <ALMediationInterstitialProtocol, ALMediationBannerProtocol>

+ (void)initializeAdMixer;

@end
