//
//  AdlibRewardLink.h
//  adlibrTestUniversal
//
//  Created by Hana Kim on 13. 6. 28..
//
//

#import <UIKit/UIKit.h>

@interface AdlibRewardLink : NSObject

+ (AdlibRewardLink *)sharedSingletonClass;

- (void)attachRewardLink:(UIViewController*)parent withView:(UIView*)view;
- (void)addRewardLinkIcon:(NSString*)rid atPoint:(CGPoint)point;
- (void)detachRewardLink:(UIViewController*)parent;
- (void)showRewardLink:(NSString*)rid;

@end
