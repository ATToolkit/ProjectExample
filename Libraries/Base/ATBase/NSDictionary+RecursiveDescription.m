//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#import "NSDictionary+RecursiveDescription.h"

#import "ATDescribable.h"
#import "NSObject+RecursiveDescription.h"

@implementation NSDictionary (RecursiveDescription)

- (void)addRecursiveDescriptionToString:(NSMutableString *)string level:(NSUInteger)level
{
  DESCRIBE_SELF(string, self);

  for (NSObject *key in self) {
    NSString *name = [[NSString alloc] initWithFormat:@"[%@]", [key description]];
    DESCRIBE_RECURSIVE_OBJECT(string, level, name, self[key]);
  }
}

@end
