//
//  GappingType.h
//  Adlib
//
//  Created by Ryan Kim on 2016. 3. 7..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GappingIconADAlign){
    
    GappingIconAdAlignLEFT = 0, //default
    GappingIconAdAlignRIGHT,
};
typedef NS_ENUM(NSInteger, GappingBannerADAlign){
    
    GappingBannerADAlignTop = 0, //default
    GappingBannerADAlignCenter,
    GappingBannerADAlignBottom,
};
typedef NS_ENUM(NSInteger, GappingADType){
    GappingADType_NONE = 0,
    GappingADType_ICON,
    GappingADType_BANNER,
    GappingADType_INTERSTITIAL,
    GappingADType_INTRO,
    GappingADType_SECTION,
    GappingADType_VIRTUAL,
    GappingADType_LIVE,
};

typedef NS_ENUM(NSInteger, GappingVRADAlign){
    GappingVRADAlignDefault = 0,
    GappingVRADAlignTopLeft = 1,
    GappingVRADAlignTopCenter,
    GappingVRADAlignTopRight,
    GappingVRADAlignMiddleLeft,
    GappingVRADAlignMiddleCenter,
    GappingVRADAlignMiddleRight,
    GappingVRADAlignBottomLeft,
    GappingVRADAlignBottomCenter,
    GappingVRADAlignBottomRight,
};

@interface GappingDefines : NSObject

+(NSString *)getIconAlignToString:(GappingIconADAlign)align;
+(GappingIconADAlign)getIconAlign:(NSString *)align;

+(NSString *)getBannerAlignToString:(GappingBannerADAlign)align;
+(GappingBannerADAlign)getBannerAlign:(NSString *)align;

+(NSString *)getVRAlignToString:(GappingVRADAlign)align;
+(GappingVRADAlign)getVRAlign:(NSString *)align;
@end
