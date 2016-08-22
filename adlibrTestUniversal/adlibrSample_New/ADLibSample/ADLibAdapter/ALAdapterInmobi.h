//
//  ALAdapterInmobi.h
//  AdlibNativeADSample
//
//  Created by gskang on 2016. 8. 18..
//  Copyright © 2016년 gskang. All rights reserved.
//

#import <Adlib/ALMediation.h>

@interface ALAdapterInmobi : ALMediation <ALMediationInterstitialProtocol, ALMediationBannerProtocol>

+ (void)initializeInmobiSDK:(NSString *)initKey;

@end
