//
//  ALAdBackFillView.h
//  Adlib
//
//  Created by gskang on 2017. 1. 11..
//  Copyright © 2017년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAdBackFillView;

@protocol ALAdBackFillViewDelegate <NSObject>

@optional
- (void)alAdBackFillView:(ALAdBackFillView *)view shouldLinkClicked:(NSURL *)link;

@end


@interface ALAdBackFillView : UIView {
    
}

@property (nonatomic, weak) id<ALAdBackFillViewDelegate> delegate;

- (void)setBackgroundImage:(UIImage *)image;
- (void)loadBackFillUrl:(NSURL *)url;

@end
