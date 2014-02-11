//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "ATAnimation.h"

#import "ATAnimator.h"

@interface ATAnimation () {
  BOOL _shouldStart;
}

@property(nonatomic, assign, readonly) BOOL shouldStart;

@property(nonatomic, assign, readwrite, getter=isRunning) BOOL running;

- (void)_animatorDidAddAnimation:(ATAnimator *)animator;

- (void)_startWithAnimator:(ATAnimator *)animator atTime:(CFTimeInterval)time;
- (void)_applyWithAnimator:(ATAnimator *)animator atTime:(CFTimeInterval)time;
- (void)_stopWithAnimator:(ATAnimator *)animator finished:(BOOL)finished;
@end
