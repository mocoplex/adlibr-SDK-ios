//
//  GappingDirectLoader.h
//  Adlib
//
//  Created by Ryan Kim on 2016. 3. 10..
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GappingDefines.h"

@protocol GappingDirectLoaderDelegate <NSObject>

@optional
- (void)onTrigger:(int)result message:(NSString *)message;

@end


@interface GappingDirectLoader : NSObject

//LoadGapping Method 를 호출하기전 사용자 지정 view를 설정한다. view를 설정하지 않으면 main window에 view를 삽입한다.
- (void)attachViewAt:(UIView *)container;

//3D 컨텐츠를 직접 사용하고자 하는 경우
- (void)loadGapping:(NSString *)path enableSoundButton:(BOOL)enableSound enableReplayButton:(BOOL)enableReplay enableCloseButton:(BOOL)enableClose;

- (void)loadGapping:(NSString *)path withIconPosition:(GappingFloatingADAlign)align;

- (void)loadGapping:(NSString *)path
   withIconPosition:(GappingFloatingADAlign)align
contentMarginOffset:(CGPoint)offset
       contentRatio:(CGFloat)ratio;

- (void)loadGapping:(NSString *)path withIconPosition:(GappingFloatingADAlign)align withDataURL:(NSString *)url;


- (void)loadGapping:(NSString *)path withBannerPosition:(GappingBannerADAlign)align;
- (void)loadGapping:(NSString *)path withVRPosition:(GappingVRADAlign)align;

- (void)reloadContentForParentViewRotate;
- (void)destroy;

+ (void) onPause;
+ (void) onResume;

@property (nonatomic, weak) id<GappingDirectLoaderDelegate> delegate;

@end
