//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#include <TargetConditionals.h>

@interface NSValue (Helpers)

#if !TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR
+ (NSValue *)valueWithCGAffineTransform:(CGAffineTransform)transform;
+ (NSValue *)valueWithCGPoint:(CGPoint)point;
+ (NSValue *)valueWithCGRect:(CGRect)rect;
+ (NSValue *)valueWithCGSize:(CGSize)size;

- (CGAffineTransform)CGAffineTransformValue;
- (CGPoint)CGPointValue;
- (CGRect)CGRectValue;
- (CGSize)CGSizeValue;
#endif

@end
