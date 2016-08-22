//
//  ALImageDownloader.h
//  AdlibNativeADSample
//
//  Created by mocoplex on 2014. 12. 15..
//  Copyright (c) 2014년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImageView;

@interface ALImageDownloader : NSObject

/**
 * Asynchronously loads the image referenced by imageURL into the provided image view.
 *
 * @param imageURL 이미지 다운로드 URL
 * @param imageView 다운로드 완료한 이미지를 추가할 뷰
 * @date 2014.12.15
 */
- (void)downloadImageForURL:(NSURL *)imageURL intoImageView:(UIImageView *)imageView;

@end
