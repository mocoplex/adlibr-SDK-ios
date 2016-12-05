//
//  SampleFeedItem.m
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 10..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import "SampleFeedItem.h"

@interface SampleFeedItem ()

@property (nonatomic, strong) NSMutableDictionary *heightDictionary;

@end

@implementation SampleFeedItem

- (id)init
{
    self = [super init];
    if (self) {
        _heightDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSTimeInterval)timeIntervalSince1970
{
    NSString *timeStr = self.timeStamp;
    NSTimeInterval time = [timeStr doubleValue] / 1000;
    return time;
}

- (NSString *)timeStampDescription
{
    NSTimeInterval time = [self timeIntervalSince1970];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"kr"];
    return [date descriptionWithLocale:locale];
}

- (NSInteger)contentHeightForWidth:(NSInteger)viewWidth
{
    NSNumber *key = [NSNumber numberWithInteger:viewWidth];
    NSNumber *value = [_heightDictionary objectForKey:key];
    if (value == nil) {
        return 0;
    }
    
    CGFloat height = [value integerValue];
    return height;
}

- (NSInteger)expectedContentImageHeightForWidth:(NSInteger)viewWidth
{
    NSInteger width  = self.width;
    NSInteger height = self.height;
    
    if (width == 0 || height == 0) {
        return 0;
    }
    
    NSInteger expectedHeight = viewWidth * height / width;
    return expectedHeight;
}

- (void)setContentHeight:(NSInteger)height ForWidth:(NSInteger)viewWidth
{
    NSNumber *key = [NSNumber numberWithInteger:viewWidth];
    NSNumber *value = [NSNumber numberWithInteger:height];
    [_heightDictionary setObject:value forKey:key];
}

@end

@implementation SampleFeedItemDeserializer

+ (instancetype)deserializer
{
    return [[[self class] alloc] init];
}

- (NSArray *)sampleFeedItemArrayForData:(NSData *)data error:(NSError * __autoreleasing *)error
{
    if (!data || [data length] == 0) {
        if (error) {
            *error = [NSError errorWithDomain:@"adlib.sample.errordomain.emptydata"
                                         code:-1
                                     userInfo:nil];
        }
        return nil;
    }
    
    NSError *deserializationError = nil;
    NSJSONReadingOptions jsonParseOption = NSJSONReadingMutableContainers | NSJSONReadingMutableContainers;
    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:jsonParseOption
                                                                       error:&deserializationError];
    if (deserializationError) {
        *error = [NSError errorWithDomain:@"adlib.sample.errordomain.deserialize"
                                     code:-1
                                 userInfo:nil];
        return nil;
    }
    
    NSArray *feedList = [resultDictionary objectForKey:@"feed"];
    if (feedList == nil || feedList.count < 1) {
        *error = [NSError errorWithDomain:@"adlib.sample.errordomain.emptylist"
                                     code:-1
                                 userInfo:nil];
    }
    
    NSMutableArray *rList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *feedDictionary in feedList) {

        NSNumber *idNumber = [feedDictionary objectForKey:@"id"];
        NSString *name  = [feedDictionary objectForKey:@"name"];
        NSString *imageUrl = [feedDictionary objectForKey:@"image"];
        NSString *status = [feedDictionary objectForKey:@"status"];
        NSString *profilePicUrl = [feedDictionary objectForKey:@"profilePic"];
        NSString *timeStamp = [feedDictionary objectForKey:@"timeStamp"];
        NSString *urlStr = [feedDictionary objectForKey:@"url"];
        NSNumber *widthNumber = [feedDictionary objectForKey:@"width"];
        NSNumber *heightNumber = [feedDictionary objectForKey:@"height"];
        
        SampleFeedItem *item = [[SampleFeedItem alloc] init];
        item.feedId = ((id)idNumber == [NSNull null]) ? -1 : [idNumber integerValue];
        item.name = ((id)name == [NSNull null]) ? nil : name;
        item.imageUrlString = ((id)imageUrl == [NSNull null]) ? nil : imageUrl;
        item.status = ((id)status == [NSNull null]) ? nil : status;
        item.iconUrlString  = ((id)profilePicUrl == [NSNull null]) ? nil : profilePicUrl;
        item.timeStamp = ((id)timeStamp == [NSNull null]) ? nil : timeStamp;
        item.urlString = ((id)urlStr == [NSNull null]) ? nil : urlStr;
        item.width = ((id)widthNumber == [NSNull null]) ? 0 : [widthNumber integerValue];
        item.height = ((id)heightNumber == [NSNull null]) ? 0 : [heightNumber integerValue];
        
        [rList addObject:item];
    }
    
    return rList;
}

@end


@implementation SongListItem

@end

