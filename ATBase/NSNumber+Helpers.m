//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#import "NSNumber+Helpers.h"

@implementation NSNumber (Helpers)

+ (NSValue *)valueWithCGFloat:(CGFloat)flt
{
#if CGFLOAT_IS_DOUBLE
  return [NSNumber numberWithDouble:flt];
#else
  return [NSNumber numberWithFloat:flt];
#endif
}

- (CGFloat)CGFloatValue
{
#if CGFLOAT_IS_DOUBLE
  return [self doubleValue];
#else
  return [self floatValue];
#endif
}

@end
