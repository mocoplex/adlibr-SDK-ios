//
//  GappingType.h
//  Adlib
//
//  Created by Ryan Kim on 2016. 3. 7..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GAPPING_LOADING_RVALUE){
    GAPPING_LOADING_RVALUE_SUCCESS              = 0,
    GAPPING_LOADING_RVALUE_FILEPATH_ERROR       = 1,
    GAPPING_LOADING_RVALUE_CONTENTS_LOAD_ERROR  = 2,
    GAPPING_LOADING_RVALUE_ENGINE_MISS_MATCH    = 3,
    GAPPING_LOADING_RVALUE_GLES_SUPPORT_ERROR   = 4,
};

typedef NS_ENUM(NSInteger, GAPPING_EVENT_RVALUE){
    GAPPING_EVENT_RVALUE_INTERNAL = 100,
    GAPPING_EVENT_RVALUE_ACTION   = 200,
    GAPPING_EVENT_RVALUE_EVENT    = 300,
    GAPPING_EVENT_SENSOR_EVENT    = 500,
};

typedef NS_ENUM(NSInteger, GAPPING_EVENT_MSG){
    
    GAPPING_EVENT_MSG_LOAD_START            = 1,
    GAPPING_EVENT_MSG_LOAD_FINISH           = 2,
    GAPPING_EVENT_MSG_PLAY_START            = 3,
    GAPPING_EVENT_MSG_PLAY_FINISH           = 4,
    GAPPING_EVENT_MSG_PLAY_RELOAD           = 5,
    
    GAPPING_EVENT_MSG_TERMINATE_ENGINE      = 6,
    GAPPING_EVENT_MSG_TERMINATE_CONTENTS    = 7,
    GAPPING_EVENT_MSG_FINISH                = 8,
    GAPPING_EVENT_MSG_ENGINE_ERR3           = 9,
    
    GAPPING_EVENT_MSG_TIEXPAND_ST           = 10,
    GAPPING_EVENT_MSG_TIEXPAND_END          = 11,
};
typedef NS_ENUM(NSInteger, GAPPING_EVENT_SENSOR_STATUS){
    
    GAPPING_EVENT_GYRO_START            = 1,
    GAPPING_EVENT_GYRO_FINISH           = 2,
    GAPPING_EVENT_MICROPHONE_START            = 3,
    GAPPING_EVENT_MICROPHONE_FINISH           = 4,
    
    GAPPING_EVENT_GYRO_ERROR           = 5,
    GAPPING_EVENT_MICROPHONE_ERROR      = 6,
    
    GAPPING_EVENT_VR_START    = 7,
    GAPPING_EVENT_VR_FINISH                = 8,
    
    GAPPING_EVENT_VR_ERROR           = 9,
};
typedef NS_ENUM(NSInteger, GAPPING_DESTROY_MSG){
    
    GAPPING_DESTROY_MSG_CLOSE_BTN = 0,
    GAPPING_DESTROY_MSG_CLEAR_VIEW = 1,
    GAPPING_DESTROY_MSG_IDLE = 4,
};

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
    GappingADType_LOADING,
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
