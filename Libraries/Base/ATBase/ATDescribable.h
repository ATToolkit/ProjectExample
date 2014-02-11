//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

@protocol ATDescribable <NSObject>

@optional
- (void)addRecursiveDescriptionToString:(NSMutableString *)string level:(NSUInteger)level;

@end

@interface NSObject () <ATDescribable>
@end