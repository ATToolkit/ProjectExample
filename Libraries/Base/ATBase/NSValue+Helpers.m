//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "NSValue+Helpers.h"

@implementation NSValue (Helpers)

#if !TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR

+ (NSValue *)valueWithCGAffineTransform:(CGAffineTransform)transform
{
  return [NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)];
}

+ (NSValue *)valueWithCGPoint:(CGPoint)point
{
  return [NSValue valueWithBytes:&point objCType:@encode(CGPoint)];
}

+ (NSValue *)valueWithCGRect:(CGRect)rect
{
  return [NSValue valueWithBytes:&rect objCType:@encode(CGRect)];
}

+ (NSValue *)valueWithCGSize:(CGSize)size
{
  return [NSValue valueWithBytes:&size objCType:@encode(CGSize)];
}

- (CGAffineTransform)CGAffineTransformValue
{
  CGAffineTransform transform;
  [self getValue:&transform];
  return transform;
}

- (CGPoint)CGPointValue
{
  CGPoint point;
  [self getValue:&point];
  return point;
}

- (CGRect)CGRectValue
{
  CGRect rect;
  [self getValue:&rect];
  return rect;
}

- (CGSize)CGSizeValue
{
  CGSize size;
  [self getValue:&size];
  return size;
}

#endif

@end
