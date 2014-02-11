//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#import "NSArray+RecursiveDescription.h"

#import "ATDescribable.h"
#import "NSObject+RecursiveDescription.h"

@implementation NSArray (RecursiveDescription)

- (void)addRecursiveDescriptionToString:(NSMutableString *)string level:(NSUInteger)level
{
  DESCRIBE_SELF(string, self);

  unsigned int index = 0;
  for (NSObject *object in self) {
    NSString *name = [[NSString alloc] initWithFormat:@"[%u]", index];
    DESCRIBE_RECURSIVE_OBJECT(string, level, name, object);
    index++;
  }
}

@end
