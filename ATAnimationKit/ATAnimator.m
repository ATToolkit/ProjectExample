//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "ATAnimator.h"

#import <ATBase/ATLog.h>
#import <ATBase/ATAssert.h>

#import <QuartzCore/CATransaction.h>

#import "ATAnimation.h"
#import "ATAnimation_Internal.h"
#import "ATAnimation_Subclass.h"

#import "ATDisplayLink.h"

@implementation ATAnimator {
  ATDisplayLink *_displayLink;
  NSMutableDictionary *_animations;
  NSMutableDictionary *_animationsToAdd;
  NSMutableSet *_animationKeysToForceRemove;
  CFTimeInterval _timeOrigin;
}

+ (instancetype)sharedAnimator
{
  static dispatch_once_t onceToken;
  static ATAnimator *animator;
  dispatch_once(&onceToken, ^{ animator = [[ATAnimator alloc] init]; });
  return animator;
}

- (instancetype)init
{
  if (self = [super init]) {
    _displayLink = [ATDisplayLink displayLinkWithTarget:self selector:@selector(displayLinkDidNotify:)];

    _animations = [NSMutableDictionary dictionary];
    _animationsToAdd = [NSMutableDictionary dictionary];
    _animationKeysToForceRemove = [NSMutableSet set];
    _timeOrigin = 0;
  }
  return self;
}

- (void)displayLinkDidNotify:(ATDisplayLink *)displayLink
{
  _timeOrigin += displayLink.timestamp;
  [self applyAnimationsAtTime:_timeOrigin];
}

- (void)start
{
  ATAssertMainThread();
  _displayLink.paused = NO;
}

- (void)stop
{
  ATAssertMainThread();
  _displayLink.paused = YES;
}

- (CFTimeInterval)applyAnimationsAtTime:(CFTimeInterval)time
{
  BOOL disableActions = [CATransaction disableActions];
  [CATransaction setDisableActions:YES];

  // TODO: add and remove animations in the order they were sent
  // Add queued animations
  for (NSString *animationKey in _animationsToAdd) {
    ATAnimation *animation = _animationsToAdd[animationKey];
    _animations[animationKey] = animation;
    [animation _animatorDidAddAnimation:self];
  }
  [_animationsToAdd removeAllObjects];

  // Remove normally stopped animations, except if they should start
  NSMutableArray *animationsToRemove = [NSMutableArray array];
  for (NSString *animationKey in _animations) {
    ATAnimation *animation = _animations[animationKey];
    if (animation.running && [animation shouldStopAtTime:time]) {
      [animation _stopWithAnimator:self finished:YES];
    }
    if (!animation.running && !animation.shouldStart && animation.removedOnCompletion) {
      [animationsToRemove addObject:animationKey];
    }
  }
  [_animations removeObjectsForKeys:animationsToRemove];

  // Remove forcibly stopped animations
  for (NSString *animationKey in _animationKeysToForceRemove) {
    ATAnimation *animation = _animations[animationKey];
    if (!animation) { // Already removed
      continue;
    }

    [animation _stopWithAnimator:self finished:NO];
    [_animations removeObjectForKey:animationKey];
  }
  [_animationKeysToForceRemove removeAllObjects];

  // Start animations
  for (NSString *animationKey in _animations) {
    ATAnimation *animation = _animations[animationKey];
    if (animation.shouldStart) {
      [animation _startWithAnimator:self atTime:time];
    }
  }

  // Tick animations
  for (NSString *animationKey in _animations) {
    ATAnimation *animation = _animations[animationKey];
    if (animation.running) {
      [animation _applyWithAnimator:self atTime:time];
    }
  }

  [CATransaction setDisableActions:disableActions];
  return 0;
}

- (void)addAnimation:(ATAnimation *)animation forKey:(NSString *)key
{
  ATAssertMainThread();
  if (_animations[key]) {
    ATLogWarn(@"Warning! Animation with key %@ already existed!", key);
  }
  _animationsToAdd[key] = animation;
}

- (ATAnimation *)animationForKey:(NSString *)key
{
  ATAssertMainThread();
  ATAnimation *animation = _animations[key];
  if (animation) {
    return animation;
  }
  return _animationsToAdd[key];
}

- (void)removeAnimationForKey:(NSString *)key
{
  ATAssertMainThread();
  if (_animationsToAdd[key]) {
    [_animationsToAdd removeObjectForKey:key];
  } else {
    [_animationKeysToForceRemove addObject:key];
  }
}

@end
