//
//  IMAdRequest.h
//  InMobi AdNetwork SDK
//
//  Copyright 2012 InMobi Technology Services Ltd. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

/**
 * User Gender.
 */
typedef enum {
	kIMGenderNone,
	kIMGenderMale,
	kIMGenderFemale,
} IMGenderType;

/**
 * User Ethnicity.
 */
typedef enum {
	kIMEthnicityNone,
	kIMEthnicityMixed,
	kIMEthnicityAsian,
	kIMEthnicityBlack,
	kIMEthnicityHispanic,
	kIMEthnicityNativeAmerican,
	kIMEthnicityWhite,
	kIMEthnicityOther,
} IMEthnicityType;

/**
 * User Education.
 */
typedef enum {
	kIMEducationNone,
	kIMEducationHighSchool,
	kIMEducationInCollege,
	kIMEducationBachelorsDegree,
	kIMEducationMastersDegree,
	kIMEducationDoctoralDegree,
	kIMEducationOther,
} IMEducationType;

/**
 * User ids may be provided to deliver more relevant ids.
 */
typedef enum {
    /**
     * User login id such as facebook, twitter, etc.
     */
    kIMLoginID,
    /**
     * This is useful for maintaining different sessions with same login id.
     */
    kIMSessionID,
} IMIDType;

/**
 IMAdRequest class specifies optional targetting parameters that may be
 specified for an ad request. These parameters will be useful to deliver more relevant ads.
 */
@interface IMAdRequest : NSObject {

}

/**
 * Returns an autoreleased IMAdRequest instance.
 */
+ (IMAdRequest *)request;

#pragma mark Testing
/**
 * Setting testMode to YES will return a test ad for this request.
 */
@property (nonatomic, assign) BOOL testMode;

#pragma mark Optional Parameters for targeted advertising during an Ad Request
/**
 * Gender of the user may be used to deliver more relevant ads.
 */
@property (nonatomic, assign) IMGenderType gender;
/**
 * Educational qualification of user may be used to deliver more relevant ads.
 */
@property (nonatomic, assign) IMEducationType education;
/**
 * Ethnicity of the user may be used to deliver more relevant ads.
 */
@property (nonatomic, assign) IMEthnicityType ethnicity;
/**
 * Date of birth of the user may be used to deliver more relevant ads.
 */
@property (nonatomic, retain) NSDate *dateOfBirth;
- (void)setDateOfBirthWithMonth:(NSUInteger)m day:(NSUInteger)d
                           year:(NSUInteger)y;
/**
 * Optional, if the user has specified income.
 * @note Income should be in USD.
 */
@property (nonatomic, assign) NSUInteger income;
/**
 * Age of the user may be used to deliver more relevant ads.
 */
@property (nonatomic, assign) NSUInteger age;
/**
 * Postal code of the user may be used to deliver more relevant ads.
 */
@property (nonatomic, copy) NSString *postalCode;
/**
 * Area code of the user may be used to deliver more relevant ads.
 */
@property (nonatomic, copy) NSString *areaCode;

#pragma mark Setting Contextual Information
/**
 * Use contextually relevant strings to deliver more relevant ads.
 * Example: @"offers sale shopping"
 */
@property (nonatomic, copy) NSString *keywords;
/**
 * Search string provided by the user. Example: @"Hotel Bangalore India"
 */
@property (nonatomic, copy) NSString *searchString;
/**
 * Use contextually relevant strings to deliver more relevant ads.
 * Example: @"cars bikes racing"
 */
@property (nonatomic, copy) NSString *interests;
/**
 * Provide additional values to be passed in the ad request as key-value pair.
 */
@property (nonatomic, retain) NSDictionary *paramsDictionary;

#pragma mark Setting User Location
/**
 * Use this to set the user's current location to deliver more relevant ads.
 * However do not use Core Location just for advertising, make sure it is used
 * for more beneficial reasons as well.  It is both a good idea and part of
 * Apple's guidelines.
 */
- (void)setLocationWithLatitude:(CGFloat)latitude
                      longitude:(CGFloat)longitude
                       accuracy:(CGFloat)accuracyInMeters;
/**
 * Provide user's city in the format "city-state-country" for
 * city-level targetting.
 */
- (void)setLocationWithCity:(NSString *)_city
                      state:(NSString *)_state
                    country:(NSString *)_country;

#pragma mark Setting User IDs
/**
 * Use this to set user ids such as facebook, twitter etc to deliver more
 * relevant ads.
 *
 * @param idType id type.
 * @param idValue id value.
 */
- (void)addIDType:(IMIDType)idType withValue:(NSString *)idValue;
/**
 * Use this to remove the user ids which was set before. This fails silently if
 * the id type was not set before.
 *
 * @param idType id type to remove.
 */
- (void)removeIDType:(IMIDType)idType;
/**
 * This returns the id value for given type. Returns nil, if it's not set.
 *
 * @param idType id type.
 * @return id value.
 */
- (NSString *)getIDType:(IMIDType)idType;

@end
