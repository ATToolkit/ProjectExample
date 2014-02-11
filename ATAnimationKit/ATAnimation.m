//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "ATAnimation.h"
#import "ATAnimation_Internal.h"
#import "ATAnimation_Subclass.h"

#import <ATBase/ATAssert.h>

@implementation ATAnimation

- (instancetype)init
{
  if (self = [super init]) {
    _removedOnCompletion = YES;
  }
  return self;
}

#pragma mark - Internal methods

- (void)_animatorDidAddAnimation:(ATAnimator *)animator
{
  _shouldStart = YES;

  [self animatorDidAddAnimation:animator];
}

- (void)_startWithAnimator:(ATAnimator *)animator atTime:(CFTimeInterval)time
{
  if (_running) {
    ATFailAssert(@"Shouldn't be starting a started animation");
  }

  _beganTime = time;

  _shouldStart = NO;
  _running = YES;

  [self startAnimationAtTime:time];

  if ([_delegate respondsToSelector:@selector(animationDidStart:)]) {
    [_delegate animationDidStart:self];
  }
}

- (void)_applyWithAnimator:(ATAnimator *)animator atTime:(CFTimeInterval)time
{
  ATAssert(_running, @"Shouldn't be ticking while not running");
  if (_running) {
    if ([self shouldStopAtTime:time]) {
      // Bail from applying animation if we should be stopped
      return;
    }

    [self applyAnimationAtTime:time];
    _lastFrameTime = time;
  }
}

- (void)_stopWithAnimator:(ATAnimator *)animator finished:(BOOL)finished
{
  if (!_running) {
    ATFailAssert(@"Shouldn't be stopping a stopped animation");
  }

  _running = NO;

  if ([_delegate respondsToSelector:@selector(animationDidStop:finished:)]) {
    [_delegate animationDidStop:self finished:finished];
  }
}

#pragma mark - Subclass methods

- (BOOL)shouldStopAtTime:(CFTimeInterval)time
{
  AT_IMPLEMENTED_BY_SUBCLASS;
  return YES;
}

- (void)animatorDidAddAnimation:(ATAnimator *)animator
{
}

- (void)startAnimationAtTime:(CFTimeInterval)time
{
}

- (void)applyAnimationAtTime:(CFTimeInterval)time
{
}

@end
