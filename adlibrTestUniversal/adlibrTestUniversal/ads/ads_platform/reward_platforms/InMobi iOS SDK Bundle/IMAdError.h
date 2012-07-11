

#import <Foundation/Foundation.h>


/**
 * IMAdError.h
 * @description Defines the error codes passed when an InMobi ad request fails to load.
 * @author: InMobi
 * Copyright (c) 2012 InMobi Pte Limited. All rights reserved.
 */

@interface IMAdError : NSError

typedef enum {
    /**
     * The ad request is invalid. 
     * Typically, this is because the ad did not have the
     * ad unit ID or rootViewController set.
     */
    kIMADInvalidRequestError,
    
    /**
     * An ad request is already in progress.
     */
    kIMAdRequestInProgressError,
    
    /**
     * An ad click is in progress.
     */
    kIMAdClickInProgressError,
    
    /**
     * The ad request was successful, but no ad was returned.
     */
    kIMADNoFillError,
    
    /**
     * Network error!
     */
    kIMADNetworkError,
    
    /**
     * The ad server experienced a failure while processing the request.
     */
    kIMADInternalError,
    
} IMAdErrorCode;

@end
