//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#define DESCRIBE_SELF(string, object) [string appendFormat:@"<%@: %p>\n", NSStringFromClass([object class]), object]
#define DESCRIBE_RECURSIVE_OBJECT(string, level, name, object)                                                         \
  [string appendString:[object describeLevel:level + 1 withKey:name]]

@interface NSObject (RecursiveDescription)

- (NSString *)recursiveDescription;
- (NSString *)describeLevel:(NSUInteger)level;
- (NSString *)describeLevel:(NSUInteger)level withKey:(NSString *)key;
@end
