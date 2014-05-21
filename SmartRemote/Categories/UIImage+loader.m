//
//  UIImage+loader.m
//  housepro
//
//  Created by Botang Li on 12-03-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImage+loader.h"
@import Accelerate;

typedef enum {
    ALPHA = 0,
    BLUE = 1,
    GREEN = 2,
    RED = 3
} PIXELS;

@implementation UIImage (loader)

- (id)initWithBundleFile:(NSString *)filename type:(NSString *)filetype {
NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:filetype];

if (path) {
    self = [self initWithContentsOfResolutionIndependentFile:path];
}
else {
    self = [self init];
}

return self;
}

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path {
    if ([UIScreen instancesRespondToSelector:@selector(scale)] && (int)[[UIScreen mainScreen] scale] == 2.0 ) {
        NSString *path2x = [[path stringByDeletingLastPathComponent] 
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.%@", 
                                                            [[path lastPathComponent] stringByDeletingPathExtension], 
                                                            [path pathExtension]]];
		
        if ( [[NSFileManager defaultManager] fileExistsAtPath:path2x] ) {
            return [self initWithContentsOfFile:path2x];
        }
    }
	
    return [self initWithContentsOfFile:path];
}

- (UIImage *)grayscale {
    CGSize size = [self size];
    int width = size.width;
    int height = size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(image);
    
    return resultUIImage;
}

- (UIImage *)scaleImageToSize:(CGSize)newSize withScale:(float)scale withBorder:(float)border {
	// get proper new size based on image radio
	if (self.size.width < newSize.width && self.size.height < newSize.height)
		return self;
	
	if (self.size.width < newSize.width && self.size.height < newSize.height)
		newSize = self.size;
	
	if (self.size.width > self.size.height)
		newSize.height = (self.size.height/self.size.width) * newSize.width;
	else
		newSize.width = (self.size.width/self.size.height) * newSize.height;
	
	// add border and shadow
	CGSize canvasSize;
	canvasSize.width = newSize.width + border*2;
	canvasSize.height = newSize.height + border*2;
	CGRect rect = CGRectMake(border, border, newSize.width, newSize.height);
	
	UIGraphicsBeginImageContextWithOptions(canvasSize, NO, scale);
	CGContextRef gc = UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(gc, kCGInterpolationHigh);
	
	[self drawInRect:rect];
	
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)scaleImageToSize:(CGSize)newSize withScale:(float)scale {
	// get proper new size based on image radio
	if (self.size.width * self.scale <= newSize.width && self.size.height * self.scale <= newSize.height)
		return self;
	
	if (self.size.width < newSize.width && self.size.height < newSize.height)
		newSize = self.size;
	
	if (self.size.width > self.size.height)
		newSize.height = (self.size.height/self.size.width) * newSize.width;
	else
		newSize.width = (self.size.width/self.size.height) * newSize.height;
	
	// add border and shadow
	CGSize canvasSize;
	canvasSize.width = newSize.width;
	canvasSize.height = newSize.height;
	CGRect rect = CGRectMake(0, 0, newSize.width, newSize.height);
	
	UIGraphicsBeginImageContextWithOptions(canvasSize, NO, scale);
	CGContextRef gc = UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(gc, kCGInterpolationHigh);
	
	[self drawInRect:rect];
	
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

- (UIImage *)scaleAndCropToSize:(CGSize)newSize withScale:(float)scale {
    CGSize size = self.size;
    
    CGSize targetSize;
    float ratio = size.width / size.height;
    if (size.width > size.height)
        targetSize = CGSizeMake(newSize.height * ratio, newSize.height);
    else
        targetSize = CGSizeMake(newSize.width, newSize.width / ratio);
    
    float max = MAX(targetSize.width, targetSize.height);
    UIImage *newImage = [self scaleImageToSize:CGSizeMake(max, max) withScale:scale];
    
    CGRect rect = CGRectMake((newSize.width - targetSize.width)/2.0, (newSize.height - targetSize.height)/2.0, targetSize.width, targetSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
	CGContextRef gc = UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(gc, kCGInterpolationHigh);
	
	[newImage drawInRect:rect];
	
	UIImage* theImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    return theImage;
}

- (UIImage *)roundedImageWithSize:(CGSize)newSize withScale:(float)scale {
    UIImage *newImage = [self scaleImageToSize:newSize withScale:scale];
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectZero;
    rect.size = newSize;
    [UIImage drawRoundedRect:rect withContext:context radius:10.0];
    
    CGContextClip(context);
    
    [newImage drawInRect:rect];
    
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return roundedImage;
}

+ (UIImage *)roundedCornerImageWithSize:(CGSize)newSize withColor:(UIColor *)color withRadius:(float)radius withScale:(float)scale {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGRect rect = CGRectZero;
    rect.size = newSize;
    
    [self drawRoundedRect:rect withContext:context radius:radius];
    CGContextClip(context);
    
    CGContextFillRect(context, rect);
    
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return roundedImage;
}

+ (void)drawRoundedRect:(CGRect)rect withContext:(CGContextRef)context radius:(float)radius {
    CGFloat minx = CGRectGetMinX(rect);
    CGFloat midx = CGRectGetMidX(rect);
    CGFloat maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect);
    CGFloat midy = CGRectGetMidY(rect);
    CGFloat maxy = CGRectGetMaxY(rect);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    CGContextClosePath(context);
}

- (UIImage *)circleImage {
    float w = self.size.width;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, w), NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, w/2.0, w/2.0, w/2.0, 0, 2*M_PI, 0);
    CGContextAddPath(ctx, path);
    CGContextClip(ctx);
    
    CGPathRelease(path);
    
    [self drawAtPoint:CGPointMake(0, 0)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)decodedImage {
    CGImageRef imageRef = self.CGImage;
    // System only supports RGB, set explicitly and prevent context error
    // if the downloaded image is not the supported format
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef), 8,
                                                 // width * 4 will be enough because are in ARGB format, don't read from the image
                                                 CGImageGetWidth(imageRef) * 4,
                                                 colorSpace,
                                                 // kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little
                                                 // makes system don't need to do extra conversion when displayed.
                                                 kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    CGColorSpaceRelease(colorSpace);
    
    if ( ! context) {
        return nil;
    }
    
    CGRect rect = (CGRect){CGPointZero, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef)};
    CGContextDrawImage(context, rect, imageRef);
    
    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    
    UIImage *decompressedImage = [[UIImage alloc] initWithCGImage:decompressedImageRef];
    
    CGImageRelease(decompressedImageRef);
    
    return decompressedImage;
}

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor withEffectAlpha:(float)alpha {
    CGFloat EffectColorAlpha = 0.6;
    EffectColorAlpha = alpha;
    UIColor *effectColor = tintColor;
    int componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self applyBlurWithRadius:7 tintColor:effectColor saturationDeltaFactor:1.0 maskImage:nil];
}

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor withEffectAlpha:(float)alpha withBlurRadius:(int)radius {
    CGFloat EffectColorAlpha = 0.6;
    EffectColorAlpha = alpha;
    UIColor *effectColor = tintColor;
    int componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self applyBlurWithRadius:radius tintColor:effectColor saturationDeltaFactor:1.0 maskImage:nil];
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
