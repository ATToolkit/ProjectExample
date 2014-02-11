//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "ATPropertyAnimation.h"

#import "ATPropertyAnimationStrategy.hpp"

using AT::Animation::PropertyStrategy;

@interface ATPropertyAnimation ()

@property(nonatomic, assign) PropertyStrategy *propertyStrategy;

@property(nonatomic, copy, readonly) NSString *encodedType;

@end
