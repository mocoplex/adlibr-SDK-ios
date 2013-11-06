/*
 * adlibr - Library for mobile AD mediation.
 * http://adlibr.com
 * Copyright (c) 2012-2013 Mocoplex, Inc.  All rights reserved.
 * Licensed under the BSD open source license.
 */

#import "SubAdlibAdViewCore.h"

#define ADLIB_ALIGN_LEFT	1
#define ADLIB_ALIGN_CENTER	2
#define ADLIB_ALIGN_RIGHT	3

@protocol AdlibManagerDelegate <NSObject>

//광고 수신 성공시 호출되는 메소드.
- (void)gotAd;
//전면광고 수신 성공시 호출되는 메소드.
- (void)didReceiveAdlibInterstitialAd:(NSString*)from;
//전면광고 수신 실패시 호출되는 메소드.
- (void)didFailToReceiveAdlibInterstitialAd:(NSString*)from;
//전면광고 닫힌 직후 호출되는 메소드.
- (void)didCloseAdlibInterstitialAd:(NSString*)from;

@end

@class AdlibContainer;
@interface AdlibManager : NSObject

+ (AdlibManager *)sharedSingletonClass;

-(void)initAdlib:(NSString*)key;
-(void)setConfigWithAge:(NSString*)age withGender:(NSString*)gender;
-(void)setConfigWithLat:(NSString*)lat withLon:(NSString*)lon;

-(NSString*)getCurrentVersion;

-(void)attach:(UIViewController*)parent withView:(UIView*)view withReceiver:(SEL)sel withPageName:(NSString*)name;
-(void)attach:(UIViewController*)parent withView:(UIView*)view withReceiver:(SEL)sel;

-(void)attach:(UIViewController*)parent withView:(UIView*)view withDelegate:(id<AdlibManagerDelegate>)del  withPageName:(NSString*)name;
-(void)attach:(UIViewController*)parent withView:(UIView*)view withDelegate:(id<AdlibManagerDelegate>)del;

-(void)attach:(UIViewController*)parent withView:(UIView*)view withReceiver:(SEL)sel withPageName:(NSString*)name defaultSize:(CGSize)size defaultAlign:(int)align;
-(void)attach:(UIViewController*)parent withView:(UIView*)view withReceiver:(SEL)sel defaultSize:(CGSize)size defaultAlign:(int)align;

-(void)attach:(UIViewController*)parent withView:(UIView*)view withDelegate:(id<AdlibManagerDelegate>)del withPageName:(NSString*)name defaultSize:(CGSize)size defaultAlign:(int)align;
-(void)attach:(UIViewController*)parent withView:(UIView*)view withDelegate:(id<AdlibManagerDelegate>)del defaultSize:(CGSize)size defaultAlign:(int)align;

-(void)loadInterstitialAd:(UIViewController*)parent withDelegate:(id<AdlibManagerDelegate>)del;

-(void)detach:(UIViewController*)parent;
-(void)moveAdContainer:(CGPoint)pt;
-(CGSize)size;

-(void)setAutoresizingMask:(UIViewAutoresizing)mask;

-(void)setPlatform:(NSString*)name withClass:(Class)className;
-(void)setLogging:(BOOL)logging;

@end