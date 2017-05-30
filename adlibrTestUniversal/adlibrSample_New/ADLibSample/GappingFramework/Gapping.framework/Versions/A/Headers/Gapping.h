//
//  Gapping.h
//  Adlib
//
//  Created by Ryan Kim on 2016. 4. 27..
//

#import <Foundation/Foundation.h>
#import "GappingDefines.h"

typedef NS_ENUM(NSInteger, GAPPING_EVENT_MSG){
    
    GAPPING_EVENT_MSG_LOAD_START            = 1,  //컨텐츠 로딩 시작
    GAPPING_EVENT_MSG_LOAD_FINISH           = 2,  //컨텐츠 로딩 완료
    GAPPING_EVENT_MSG_PLAY_START            = 3,  //컨텐츠 재생 시작
    GAPPING_EVENT_MSG_PLAY_FINISH           = 4,  //컨텐츠 재생 종료
    GAPPING_EVENT_MSG_PLAY_RELOAD           = 5,  //컨텐츠 재실행
    
    GAPPING_EVENT_MSG_TERMINATE_ENGINE      = 6,  //Not found zip file(engine)
    GAPPING_EVENT_MSG_TERMINATE_CONTENTS    = 7,  //Invalid contents
    GAPPING_EVENT_MSG_FINISH                = 8,  //컨탠츠 삭제
    GAPPING_EVENT_MSG_ENGINE_ERR3           = 9,  //Failed to load engine
    
    GAPPING_EVENT_MSG_TIEXPAND_ST           = 10, //컨텐츠 확장 시작
    GAPPING_EVENT_MSG_TIEXPAND_END          = 11, //컨텐츠 확장 완료
    
};

typedef NS_ENUM(NSInteger, GAPPING_LOADING_RVALUE){
    GAPPING_LOADING_RVALUE_SUCCESS              = 0,
    GAPPING_LOADING_RVALUE_FILEPATH_ERROR       = 1,
    GAPPING_LOADING_RVALUE_CONTENTS_LOAD_ERROR  = 2,
    GAPPING_LOADING_RVALUE_ENGINE_MISS_MATCH    = 3,
    GAPPING_LOADING_RVALUE_GLES_SUPPORT_ERROR   = 4,
};

typedef NS_ENUM(NSInteger, GAPPING_EVENT_RVALUE){
    GAPPING_EVENT_RVALUE_INTERNAL = 100, //컨텐츠 내부 이벤트
    GAPPING_EVENT_RVALUE_ACTION   = 200, //컨텐츠 내부 액션
    GAPPING_EVENT_RVALUE_EVENT    = 300, //컨텐츠에서 외부로 전달하는 액션
    GAPPING_EVENT_SENSOR_EVENT    = 500, //센서 이벤트
};

typedef NS_ENUM(NSInteger, GAPPING_EVENT_SENSOR_STATUS){
    
    GAPPING_EVENT_GYRO_START            = 1,
    GAPPING_EVENT_GYRO_FINISH           = 2,
    GAPPING_EVENT_MICROPHONE_START      = 3,
    GAPPING_EVENT_MICROPHONE_FINISH     = 4,
    GAPPING_EVENT_GYRO_ERROR            = 5,
    GAPPING_EVENT_MICROPHONE_ERROR      = 6,
    GAPPING_EVENT_VR_START              = 7,
    GAPPING_EVENT_VR_FINISH             = 8,
    GAPPING_EVENT_VR_ERROR              = 9,
};

typedef NS_ENUM(NSInteger, GAPPING_DESTROY_MSG){
    
    GAPPING_DESTROY_MSG_CLOSE_BTN = 0,
    GAPPING_DESTROY_MSG_CLEAR_VIEW = 1,
    GAPPING_DESTROY_MSG_IDLE = 4,
};


@interface Gapping : NSObject

+ (NSString *)getFloatingAdAlignToString:(GappingFloatingADAlign)align;
+ (GappingFloatingADAlign)getFloatingAdAlign:(NSString *)align;

+ (NSString *)getBannerAlignToString:(GappingBannerADAlign)align;
+ (GappingBannerADAlign)getBannerAlign:(NSString *)align;

+ (NSString *)getVRAlignToString:(GappingVRADAlign)align;
+ (GappingVRADAlign)getVRAlign:(NSString *)align;

@end

