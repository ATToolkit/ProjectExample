//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "ATAnimation.h"

@class ATAnimator;

@interface ATAnimation ()

@property(nonatomic, assign) CFTimeInterval beganTime;
@property(nonatomic, assign) CFTimeInterval lastFrameTime;

- (void)animatorDidAddAnimation:(ATAnimator *)animator;

- (BOOL)shouldStopAtTime:(CFTimeInterval)time;

- (void)startAnimationAtTime:(CFTimeInterval)time;

- (void)applyAnimationAtTime:(CFTimeInterval)time;

@end
