//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "ATPropertyAnimation.h"
#import "ATPropertyAnimation_Internal.hpp"

#import <ATBase/ATAssert.h>
#import <ATBase/ATBaseDefines.h>
#import <ATBase/NSObject+Reflection.h>
#import <ATBase/NSValue+Helpers.h>

#import "ATAnimation_Subclass.h"

const struct ATEncodings ATEncodings = { .floatEncoding = @encode(float),
                                         .doubleEncoding = @encode(double),
                                         .pointEncoding = @encode(CGPoint),
                                         .sizeEncoding = @encode(CGSize),
                                         .rectEncoding = @encode(CGRect),
                                         .affineTransformEncoding = @encode(CGAffineTransform),
                                         .transform3DEncoding = @encode(CATransform3D), };

@implementation ATPropertyAnimation {
  NSString *_encodedType;
}

+ (instancetype)animationWithObject:(id)object keyPath:(NSString *)keyPath
{
  ATPropertyAnimation *animation = [[self alloc] initWithObject:object keyPath:keyPath];
  return animation;
}

- (instancetype)initWithObject:(id)object keyPath:(NSString *)keyPath
{
  if (self = [super init]) {
    _object = object;
    _keyPath = [keyPath copy];

    _encodedType = [_object encodedTypeForKeyPath:_keyPath];
    _propertyStrategy = [[self class] newPropertyStrategyForType:_encodedType];
  }
  return self;
}

#pragma mark -

- (void)setFromValue:(id)fromValue
{
  const char *type = [self.encodedType UTF8String];
  if (AT_ENCODING_IS_EQUAL(ATEncodings.floatEncoding, type)) {
    ATValue value = { .floatValue = [(NSNumber *)fromValue floatValue] };
    _propertyStrategy->setFromValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.doubleEncoding, type)) {
    ATValue value = { .doubleValue = [(NSNumber *)fromValue doubleValue] };
    _propertyStrategy->setFromValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.pointEncoding, type)) {
    ATValue value = { .pointValue = [(NSValue *)fromValue CGPointValue] };
    _propertyStrategy->setFromValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.sizeEncoding, type)) {
    ATValue value = { .sizeValue = [(NSValue *)fromValue CGSizeValue] };
    _propertyStrategy->setFromValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.rectEncoding, type)) {
    ATValue value = { .rectValue = [(NSValue *)fromValue CGRectValue] };
    _propertyStrategy->setFromValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.affineTransformEncoding, type)) {
    ATValue value = { .affineTransformValue = [(NSValue *)fromValue CGAffineTransformValue] };
    _propertyStrategy->setFromValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.transform3DEncoding, type)) {
    ATValue value = { .transform3DValue = [(NSValue *)fromValue CATransform3DValue] };
    _propertyStrategy->setFromValue(value);
  } else {
    ATFailAssert(@"Not supported");
  }
}

- (id)fromValue
{
  const char *type = [self.encodedType UTF8String];
  if (AT_ENCODING_IS_EQUAL(ATEncodings.floatEncoding, type)) {
    ATValue value = _propertyStrategy->getFromValue();
    return [NSNumber numberWithFloat:value.floatValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.doubleEncoding, type)) {
    ATValue value = _propertyStrategy->getFromValue();
    return [NSNumber numberWithDouble:value.doubleValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.pointEncoding, type)) {
    ATValue value = _propertyStrategy->getFromValue();
    return [NSValue valueWithCGPoint:value.pointValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.sizeEncoding, type)) {
    ATValue value = _propertyStrategy->getFromValue();
    return [NSValue valueWithCGSize:value.sizeValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.rectEncoding, type)) {
    ATValue value = _propertyStrategy->getFromValue();
    return [NSValue valueWithCGRect:value.rectValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.affineTransformEncoding, type)) {
    ATValue value = _propertyStrategy->getFromValue();
    return [NSValue valueWithCGAffineTransform:value.affineTransformValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.transform3DEncoding, type)) {
    ATValue value = _propertyStrategy->getFromValue();
    return [NSValue valueWithCATransform3D:value.transform3DValue];
  } else {
    ATFailAssert(@"Not supported");
    return nil;
  }
}

- (void)setToValue:(id)toValue
{
  const char *type = [self.encodedType UTF8String];
  if (AT_ENCODING_IS_EQUAL(ATEncodings.floatEncoding, type)) {
    ATValue value = { .floatValue = [(NSNumber *)toValue floatValue] };
    _propertyStrategy->setToValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.doubleEncoding, type)) {
    ATValue value = { .doubleValue = [(NSNumber *)toValue doubleValue] };
    _propertyStrategy->setToValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.pointEncoding, type)) {
    ATValue value = { .pointValue = [(NSValue *)toValue CGPointValue] };
    _propertyStrategy->setToValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.sizeEncoding, type)) {
    ATValue value = { .sizeValue = [(NSValue *)toValue CGSizeValue] };
    _propertyStrategy->setToValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.rectEncoding, type)) {
    ATValue value = { .rectValue = [(NSValue *)toValue CGRectValue] };
    _propertyStrategy->setToValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.affineTransformEncoding, type)) {
    ATValue value = { .affineTransformValue = [(NSValue *)toValue CGAffineTransformValue] };
    _propertyStrategy->setToValue(value);
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.transform3DEncoding, type)) {
    ATValue value = { .transform3DValue = [(NSValue *)toValue CATransform3DValue] };
    _propertyStrategy->setToValue(value);
  } else {
    ATFailAssert(@"Not supported");
  }
}

- (id)toValue
{
  const char *type = [self.encodedType UTF8String];
  if (AT_ENCODING_IS_EQUAL(ATEncodings.floatEncoding, type)) {
    ATValue value = _propertyStrategy->getToValue();
    return [NSNumber numberWithFloat:value.floatValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.doubleEncoding, type)) {
    ATValue value = _propertyStrategy->getToValue();
    return [NSNumber numberWithDouble:value.doubleValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.pointEncoding, type)) {
    ATValue value = _propertyStrategy->getToValue();
    return [NSValue valueWithCGPoint:value.pointValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.sizeEncoding, type)) {
    ATValue value = _propertyStrategy->getToValue();
    return [NSValue valueWithCGSize:value.sizeValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.rectEncoding, type)) {
    ATValue value = _propertyStrategy->getToValue();
    return [NSValue valueWithCGRect:value.rectValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.affineTransformEncoding, type)) {
    ATValue value = _propertyStrategy->getToValue();
    return [NSValue valueWithCGAffineTransform:value.affineTransformValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.transform3DEncoding, type)) {
    ATValue value = _propertyStrategy->getToValue();
    return [NSValue valueWithCATransform3D:value.transform3DValue];
  } else {
    ATFailAssert(@"Not supported");
    return nil;
  }
}

- (id)currentValue
{
  const char *type = [self.encodedType UTF8String];
  if (AT_ENCODING_IS_EQUAL(ATEncodings.floatEncoding, type)) {
    ATValue value = _propertyStrategy->getCurrentValue();
    return [NSNumber numberWithFloat:value.floatValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.doubleEncoding, type)) {
    ATValue value = _propertyStrategy->getCurrentValue();
    return [NSNumber numberWithDouble:value.doubleValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.pointEncoding, type)) {
    ATValue value = _propertyStrategy->getCurrentValue();
    return [NSValue valueWithCGPoint:value.pointValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.sizeEncoding, type)) {
    ATValue value = _propertyStrategy->getCurrentValue();
    return [NSValue valueWithCGSize:value.sizeValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.rectEncoding, type)) {
    ATValue value = _propertyStrategy->getCurrentValue();
    return [NSValue valueWithCGRect:value.rectValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.affineTransformEncoding, type)) {
    ATValue value = _propertyStrategy->getCurrentValue();
    return [NSValue valueWithCGAffineTransform:value.affineTransformValue];
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.transform3DEncoding, type)) {
    ATValue value = _propertyStrategy->getCurrentValue();
    return [NSValue valueWithCATransform3D:value.transform3DValue];
  } else {
    ATFailAssert(@"Not supported");
    return nil;
  }
}

#pragma mark - Subclass methods

- (void)animatorDidAddAnimation:(ATAnimator *)animator
{
  [super animatorDidAddAnimation:animator];
}

- (void)startAnimationAtTime:(CFTimeInterval)time
{
  [super startAnimationAtTime:time];
  [self setFromValue:[_object valueForKeyPath:_keyPath]];
}

+ (AT::Animation::PropertyStrategy *)newPropertyStrategyForType:(NSString *)type
{
  AT_IMPLEMENTED_BY_SUBCLASS;
  return NULL;
}

@end