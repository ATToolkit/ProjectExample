//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#import "NSSet+RecursiveDescription.h"

#import "ATDescribable.h"
#import "NSObject+RecursiveDescription.h"

@implementation NSSet (RecursiveDescription)

- (void)addRecursiveDescriptionToString:(NSMutableString *)string level:(NSUInteger)level
{
  DESCRIBE_SELF(string, self);

  for (NSObject *object in self) {
    DESCRIBE_RECURSIVE_OBJECT(string, level, @"[*]", object);
  }
}

@end
