//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#import "NSObject+RecursiveDescription.h"

#import "ATDescribable.h"

static const NSUInteger indentWidth = 2;

@implementation NSObject (RecursiveDescription)

- (NSString *)recursiveDescription
{
  return [self describeLevel:0];
}

- (NSString *)describeLevel:(NSUInteger)level withKey:(NSString *)key
{
  NSString *tab =
      [[@"" stringByPaddingToLength:indentWidth - 1 withString:@" " startingAtIndex:0] stringByAppendingString:@"|"];
  NSString *indent = [@"" stringByPaddingToLength:indentWidth * level withString:tab startingAtIndex:0];

  NSMutableString *string = [[NSMutableString alloc] initWithString:indent];
  if (key) {
    // Currently, showing collection count only supports collections that implement fast enumeration, and assumes that
    // -count is sane and returns NSUInteger.
    if ([self conformsToProtocol:@protocol(NSFastEnumeration)]) {
      [string appendFormat:@"%@{count=%lu} = ", key, [(id)self count]];
    } else {
      [string appendFormat:@"%@ = ", key];
    }
  }

  if ([self respondsToSelector:@selector(addRecursiveDescriptionToString:level:)]) {
    [self addRecursiveDescriptionToString:string level:level];
  } else {
    [string appendString:[self description]];
  }

  [string appendString:@"\n"];
  return [string copy];
}

- (NSString *)describeLevel:(NSUInteger)level
{
  return [self describeLevel:level withKey:nil];
}

@end
