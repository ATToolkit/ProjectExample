//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "NSArray+Helpers.h"

@implementation NSArray (Helpers)

- (NSArray *)subarrayWithoutFirstObject
{
  if (!self.count) {
    return self;
  } else if (self.count == 1) {
    return @[];
  } else {
    return [self subarrayWithRange:NSMakeRange(1, self.count - 1)];
  }
}

@end
