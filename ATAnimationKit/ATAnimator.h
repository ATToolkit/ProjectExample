//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

@class ATAnimation;

@interface ATAnimator : NSObject

+ (instancetype)sharedAnimator;

- (void)start;
- (void)stop;

- (void)addAnimation:(ATAnimation *)anim forKey:(NSString *)key;
- (ATAnimation *)animationForKey:(NSString *)key;
- (void)removeAnimationForKey:(NSString *)key;

@end
