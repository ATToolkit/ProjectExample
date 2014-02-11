//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import <ATAnimationKit/ATAnimation.h>

#define AT_ENCODING_IS_EQUAL(a, b) (0 == strcmp(a, b))

struct ATEncodings {
  const char *floatEncoding;
  const char *doubleEncoding;
  const char *pointEncoding;
  const char *sizeEncoding;
  const char *rectEncoding;
  const char *affineTransformEncoding;
  const char *transform3DEncoding;
};

extern const struct ATEncodings ATEncodings;

@interface ATPropertyAnimation : ATAnimation

// TODO: explain why this is retained
@property(nonatomic, strong, readonly) id object;
@property(nonatomic, copy, readonly) NSString *keyPath;

@property(nonatomic, copy) id fromValue;
@property(nonatomic, copy) id toValue;
@property(nonatomic, copy, readonly) id currentValue;

+ (instancetype)animationWithObject:(id)object keyPath:(NSString *)keyPath;

@end
