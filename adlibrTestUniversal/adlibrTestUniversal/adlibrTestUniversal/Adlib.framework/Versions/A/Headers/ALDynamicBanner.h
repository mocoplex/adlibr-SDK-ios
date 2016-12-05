//
//  ALDynamicBanner.h
//  Adlib
//
//  Created by gskang on 2016. 11. 23..
//  Copyright © 2016년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ALDynamicBannerView.h"

@class ALDynamicBanner;

@protocol ALDynamicBannerDelegate <NSObject>

@optional
- (void)alDynamicBannerDidReceivedAd:(ALDynamicBanner *)dynamicBanner;
- (void)alDynamicBanner:(ALDynamicBanner *)dynamicBanner didFailedAdWithState:(ALDynamicBannerState)state;

@end

@interface ALDynamicBanner : NSObject {
    
}

@property (nonatomic, weak) id<ALDynamicBannerDelegate> delegate;

@property (nonatomic) BOOL isTestMode; //default : NO
@property (nonatomic, strong, readonly) NSError *internalError;

/**
 *  애드립 키값으로 초기화합니다.
 *  애드립 설정 세션 연결은 내부적으로 처리됩니다.
 */
- (id)initWithKey:(NSString *)key contentSize:(CGSize)size;

- (BOOL)loadAdRequest;
- (void)cancelAdRequest;

- (void)presentAdWithParentViewController:(UIViewController *)ctr animated:(BOOL)animate;

@end
