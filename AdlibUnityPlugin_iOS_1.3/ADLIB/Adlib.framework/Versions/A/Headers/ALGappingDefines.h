//
//  ALGappingDefines.h
//  Adlib
//
//  Created by gskang on 2016. 1. 8..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ADLIB_GAPPING_ERROR_DOMAIN @"com.adlibr.gapping.error"

typedef NS_ENUM(NSInteger, ALGappingAdErrorCode){
    
    kGappingErrorEmptyAd = 10,
    
    kGappingErrorSessionFailed = 11,
    kGappingErrorAttachViewFailed = 12,
    kGappingErrorPakDownloadFailed = 13,
    kGappingErrorReadyForResouces = 14,
    
    kGappingErrorInvalidRequestType = 15,
    kGappingErrorInvalidRequestKey = 16,
    kGappingErrorInvalidResponse = 17,
    kGappingErrorInvalidRequest = 18,
};


@interface ALGappingDefines : NSObject

+ (NSString *)errorDescriptionForCode:(ALGappingAdErrorCode)code;

@end
