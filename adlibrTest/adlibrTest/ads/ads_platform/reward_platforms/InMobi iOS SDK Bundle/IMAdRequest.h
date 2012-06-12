
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 * IMAdRequest.h
 * @description Specifies optional parameters for ad requests.
 * @author: InMobi
 * Copyright (c) 2012 InMobi Pte Limited. All rights reserved.
 */

@interface IMAdRequest : NSObject

/**
 * The Gender type
 */
typedef enum
{
    /**
     * Gender type none.
     */
	G_None,
    /**
     * Gender type male.
     */
	G_M,
    /**
     * Gender type female
     */
	G_F
} GenderType;

/**
 * The Ethnicity type.
 */
typedef enum
{
    /**
     * Ethnicity type none.
     */
	Eth_None,
    /**
     * Ethnicity type Mixed.
     */
	Eth_Mixed,
    /**
     * Ethnicity type Asian.
     */
	Eth_Asian,
    /**
     * Ethnicity type Black.
     */
	Eth_Black,
    /**
     * Ethnicity type Hispanic.
     */
	Eth_Hispanic,
    /**
     * Ethnicity type American.
     */
	Eth_NativeAmerican,
    /**
     * Ethnicity type White.
     */
	Eth_White,
    /**
     * Ethnicity type Others.
     */
	Eth_Other
} EthnicityType;

/**
 * The Education type.
 */
typedef enum
{
    /**
     * Education type None.
     */
	Edu_None, 
    /**
     * Education type High School.
     */
	Edu_HighSchool,
    /**
     * Education type In College.
     */
	Edu_InCollege,
    /**
     * Education type Bachelors Degree.
     */
	Edu_BachelorsDegree,
    /**
     * Education type Masters.
     */
	Edu_MastersDegree,
    /**
     * Education type PhD.
     */
	Edu_DoctoralDegree,
    /**
     * Education type Others.
     */
	Edu_Other
    
} EducationType;
/**
 * The IMIDType enum.
 */
typedef enum
{
    /**
     * The login value for IMIDType.
     */
    ID_LOGIN,
    /**
     * The session value for IMIDType.
     */
    ID_SESSION
    
} IMIDType;

/**
 * Device ID Type
 */
typedef enum 
{
    /**
     * Device ID type None
     */
    DeviceID_NONE   = 1 << 0,
    /**
     * Device ID type ODIN1
     */
    DeviceID_ODIN1  = 1 << 1
    
} DeviceIDMask;

/**
 * Returns an auto-released IMAdRequest instance.
 */
+ (id)request;

#pragma Optional properties to be specified for targeted advertising during an ad request.

/**
 * Postal code of the user may be used to deliver more relevant ads.
 */
@property( nonatomic,copy) NSString *postalCode; 
/**
 * Area code of the user may be used to deliver more relevant ads.
 */
@property( nonatomic,copy) NSString *areaCode;
/**
 * Date of birth of the user may be used to deliver more relevant ads.
 * @note - The date should be of the format dd-mm-yyyy.
 */
@property( nonatomic,copy) NSString *dateOfBirth; 
/**
 * Gender of the user may be used to deliver more relevant ads.
 * @note - Look for the IMAdRequest.h class to set the relevant values. 
 */
@property( nonatomic,assign) GenderType gender; 
/**
 * Use contextually relevant strings to deliver more relevant ads.
 * Example: @"offers sale shopping"
 */
@property( nonatomic,copy) NSString *keywords;
/**
 * Search string provided by the user. Example: @"Hotel Bangalore India"
 */
@property( nonatomic,copy) NSString *searchString;
/**
 * Optional, if the user has specified income.
 * @note - Income should be in USD.
 */
@property( nonatomic,assign) NSUInteger income; 
/**
 * Educational qualification of the user may be used to deliver more relevant ads.
 */
@property( nonatomic,assign) EducationType education;		
/**
 * Ethnicity of the user may be used to deliver more relevant ads.
 * @note - Look for the IMAdRequest.h class to set the relevant values.
 */
@property( nonatomic,assign) EthnicityType ethnicity;
/**
 * Age of the user may be used to deliver more relevant ads.
 * @note - Look for the IMAdRequest.h class to set the relevant values. 
 */
@property( nonatomic,assign) NSUInteger age;
/**
 * Use contextually relevant strings to deliver more relevant ads.
 * Example: @"cars bikes racing"
 */
@property( nonatomic,copy) NSString *interests;
/**
 * Provide additional values to be passed in the ad request as key-value pair.
 */
@property (nonatomic, retain) NSDictionary *paramsDictionary;
/**
 * Set testMode to YES for receiving test ads.
 * @note - Default value is NO.
 */
@property ( nonatomic , assign) BOOL testMode;
/**
 * Use this property to set the user's current location to deliver more relevant ads.
 * Disclaimer: Do not use Core Location just for advertising. Ensure that it is used
 * in your app for more constructive reasons as well. It is both a good idea and part of
 * Apple's guidelines.
 */
@property (nonatomic,retain) CLLocation *location;
/**
 * Provide user's city in the format "city-state-country" for
 * city-level targetting.
 */
- (void)setLocationWithCity:(NSString *)_city state:(NSString *)_state country:(NSString *)_country;
/**
 * The login ID value.
 */
@property (nonatomic, copy) NSString *loginID;
/**
 * The session ID value.
 */
@property (nonatomic, copy) NSString *sessionID;
/**
 * The Device ID Mask.
 */
@property (nonatomic, assign) DeviceIDMask deviceIDMask;

/**
 * Set the IMIDType with the given value.
 * @param idType - The IMIDType to set.
 * @param value - The value of IMIDType.
 */
- (void) addIDType:(IMIDType)idType withValue: (NSString *)value;

/**
 * @param idType - The IMIDType to remove.
 * This callback fails silently if no value is found.
 */
- (void)removeIDType:(IMIDType)idType;

/**
 * @param idType - The idType for which the value should be returned.
 * @return - The value corresponing to this idType. Else returns null.
 */
- (NSString *)getIDType:(IMIDType)idType;
/**
 * For internal purposes only.
 */
@property (nonatomic, copy) NSString *cityLocation;
@end
