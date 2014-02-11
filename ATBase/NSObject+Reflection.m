//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "NSObject+Reflection.h"

#import <objc/runtime.h>

#import <ATBase/ATAssert.h>
#import <ATBase/ATBaseDefines.h>
#import <ATBase/NSArray+Helpers.h>

#import <CoreGraphics/CGAffineTransform.h>
#import <CoreGraphics/CGGeometry.h>

#import <QuartzCore/CATransform3D.h>

NSString *const kKeyPathRotationX = @"rotation.x";
NSString *const kKeyPathRotationY = @"rotation.y";
NSString *const kKeyPathRotationZ = @"rotation.z";
NSString *const kKeyPathRotation = @"rotation";
NSString *const kKeyPathScaleX = @"scale.x";
NSString *const kKeyPathScaleY = @"scale.y";
NSString *const kKeyPathScaleZ = @"scale.z";
NSString *const kKeyPathScale = @"scale";
NSString *const kKeyPathTranslationX = @"translation.x";
NSString *const kKeyPathTranslationY = @"translation.y";
NSString *const kKeyPathTranslationZ = @"translation.z";
NSString *const kKeyPathTranslation = @"translation";

NSString *_encodedTypeForClassAndKeyPathElements(Class dass, NSArray *keyPathElements);
SEL _setterForClassAndKeyPathElements(Class dass, NSArray *keyPathElements);

AT_INLINE NSString *_encodedTypeAttributeForProperty(objc_property_t property);
AT_INLINE SEL _setterForProperty(objc_property_t property);

@implementation NSObject (Reflection)

+ (NSString *)encodedTypeForKeyPath:(NSString *)keyPath
{
  NSArray *keyPathElements = [keyPath componentsSeparatedByString:@"."];
  return _encodedTypeForClassAndKeyPathElements(self, keyPathElements);
}

- (NSString *)encodedTypeForKeyPath:(NSString *)keyPath
{
  return [[self class] encodedTypeForKeyPath:keyPath];
}

+ (SEL)setterForKeyPath:(NSString *)keyPath
{
  NSArray *keyPathElements = [keyPath componentsSeparatedByString:@"."];
  return _setterForClassAndKeyPathElements(self, keyPathElements);
}

- (SEL)setterForKeyPath:(NSString *)keyPath
{
  return [[self class] setterForKeyPath:keyPath];
}

@end

NSString *_encodedTypeForClassAndKeyPathElements(Class dass, NSArray *keyPathElements)
{
  ATAssert(keyPathElements.count, @"Empty key paths not allowed");
  NSString *firstKey = [keyPathElements firstObject];
  NSArray *cdrKeys = [keyPathElements subarrayWithoutFirstObject];

  objc_property_t property = class_getProperty(dass, [firstKey UTF8String]);
  NSString *typeAttribute = _encodedTypeAttributeForProperty(property);
  const char *type = [[typeAttribute substringFromIndex:1] UTF8String];

  // Base case: this key is the last
  if (!cdrKeys.count) {
    return [NSString stringWithUTF8String:type];
  }

  // Error case: peeking into 'id' types.
  // TODO: support protocols?
  if (0 == strcmp(type, @encode(id))) {
    ATFailAssert(@"Introspection into 'id' properties is not supported");
    return NULL;
  }

  // Recursive case: peeking into classes
  if ([typeAttribute hasPrefix:@"T@"]) {
    // Exclude the (T@") at the beginning and (") at the end
    NSString *className = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length] - 4)];
    Class propertyClass = NSClassFromString(className);
    return _encodedTypeForClassAndKeyPathElements(propertyClass, cdrKeys);
  }

  // TODO: Special cases: key paths into non-objects
  if (0 == strcmp(type, @encode(CATransform3D))) {
    ATFailAssert(@"Not yet supported");
  } else if (0 == strcmp(type, @encode(CGAffineTransform))) {
    ATFailAssert(@"Not yet supported");
  } else if (0 == strcmp(type, @encode(CGPoint))) {
    ATFailAssert(@"Not yet supported");
  } else if (0 == strcmp(type, @encode(CGRect))) {
    ATFailAssert(@"Not yet supported");
  } else if (0 == strcmp(type, @encode(CGSize))) {
    ATFailAssert(@"Not yet supported");
  } else {
    ATFailAssert(@"Key paths are not yet supported for non-floating-point numbers or non-objects (excluding structs "
                  "which are subject to KVC extensions)");
  }
  return NULL;
}

SEL _setterForClassAndKeyPathElements(Class dass, NSArray *keyPathElements)
{
  ATAssert(keyPathElements.count, @"Empty key paths not allowed");
  NSString *firstKey = [keyPathElements firstObject];
  NSArray *cdrKeys = [keyPathElements subarrayWithoutFirstObject];

  objc_property_t property = class_getProperty(dass, [firstKey UTF8String]);
  NSString *typeAttribute = _encodedTypeAttributeForProperty(property);
  const char *type = [[typeAttribute substringFromIndex:1] UTF8String];

  // Base case: this key is the last
  if (!cdrKeys.count) {
    return _setterForProperty(property);
  }

  // Error case: peeking into 'id' types.
  // TODO: support protocols?
  if (0 == strcmp(type, @encode(id))) {
    ATFailAssert(@"Introspection into 'id' properties is not supported");
    return NULL;
  }

  // Recursive case: peeking into classes
  if ([typeAttribute hasPrefix:@"T@"]) {
    // Exclude the (T@") at the beginning and (") at the end
    NSString *className = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length] - 4)];
    Class propertyClass = NSClassFromString(className);
    return _setterForClassAndKeyPathElements(propertyClass, cdrKeys);
  }

  // TODO: Special cases: key paths into non-objects
  if (0 == strcmp(type, @encode(CATransform3D))) {
    ATFailAssert(@"Not yet supported");
  } else if (0 == strcmp(type, @encode(CGAffineTransform))) {
    ATFailAssert(@"Not yet supported");
  } else if (0 == strcmp(type, @encode(CGPoint))) {
    ATFailAssert(@"Not yet supported");
  } else if (0 == strcmp(type, @encode(CGRect))) {
    ATFailAssert(@"Not yet supported");
  } else if (0 == strcmp(type, @encode(CGSize))) {
    ATFailAssert(@"Not yet supported");
  } else {
    ATFailAssert(@"Key paths are not yet supported for non-floating-point numbers or non-objects (excluding structs "
                  "which are subject to KVC extensions)");
  }
  return NULL;
}

NSString *_encodedTypeAttributeForProperty(objc_property_t property)
{
  const char *attributesCString = property_getAttributes(property);
  NSString *attributesString = [NSString stringWithUTF8String:attributesCString];
  NSArray *attributes = [attributesString componentsSeparatedByString:@","];
  return [attributes objectAtIndex:0];
}

SEL _setterForProperty(objc_property_t property)
{
  const char *propertyName = property_getName(property);

  NSString *setterNameString;
  char *setterNameOverride = property_copyAttributeValue(property, "S");
  if (!setterNameOverride) {
    setterNameString =
        [[@"set" stringByAppendingString:[[[NSString alloc] initWithUTF8String:propertyName] capitalizedString]]
            stringByAppendingString:@":"];
  } else {
    setterNameString = [[[NSString alloc] initWithUTF8String:setterNameOverride] stringByAppendingString:@":"];
  }
  free(setterNameOverride);

  const char *setterName = [setterNameString UTF8String];
  return sel_getUid(setterName);
}