//
//  ALGappingPopAdView.h
//  Adlib
//
//  Created by gskang on 2015. 11. 16..
//  Copyright © 2015년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALIconAdAlign){
    
    ALIconAdAlignLEFT = 0, //default
    ALIconAdAlignRIGHT,
};

@class ALIconAdLoader;

@protocol ALIconAdLoaderDelegate <NSObject>

- (void)ALIconAdLoaderDidReceivedAd:(ALIconAdLoader *)iconAdLoader;
- (void)ALIconAdLoader:(ALIconAdLoader *)iconAdLoader didFailedError:(NSError *)error;

@end


@interface ALIconAdLoader : NSObject {
    
}

@property (nonatomic) ALIconAdAlign iconAlign; //default : ALIconAdAlignLEFT

//테스트 광고 여부 설정 (기본값 NO)
@property (nonatomic) BOOL isTestMode;

//광고 요청
- (BOOL)loadAdWithKey:(NSString *)key delegate:(id<ALIconAdLoaderDelegate>)delegate;

//광고 뷰 적재
- (BOOL)attachAdViewToMainWindow; // 권장
- (BOOL)attachAdViewToView:(UIView *)containerView; //옵션

//광고 뷰 제거
- (void)detachAdView;

//뷰컨트롤러 화면 회전 시 광고 컨텐츠 영역 조정 요청
- (void)reloadContentForParentViewRotate;

@end
