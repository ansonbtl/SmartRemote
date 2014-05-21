//
//  UIImage+loader.h
//  housepro
//
//  Created by Botang Li on 12-03-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (loader)

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;
- (id)initWithBundleFile:(NSString *)filename type:(NSString *)filetype;
- (UIImage *)grayscale;

- (UIImage *)scaleImageToSize:(CGSize)newSize withScale:(float)scale withBorder:(float)border;
- (UIImage *)scaleImageToSize:(CGSize)newSize withScale:(float)scale;
- (UIImage *)scaleAndCropToSize:(CGSize)newSize withScale:(float)scale;
- (UIImage *)roundedImageWithSize:(CGSize)newSize withScale:(float)scale;

+ (UIImage *)roundedCornerImageWithSize:(CGSize)newSize withColor:(UIColor *)color withRadius:(float)radius withScale:(float)scale;

- (UIImage *)circleImage;

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor withEffectAlpha:(float)alpha;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor withEffectAlpha:(float)alpha withBlurRadius:(int)radius;

- (UIImage *)decodedImage;

@end
