//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#import "ATAppDelegate.h"

#import <ATBase/ATLog.h>
#import <ATBase/DDLog.h>
#import <ATBase/DDASLLogger.h>
#import <ATBase/DDTTYLogger.h>
#import <ATBase/NSValue+Helpers.h>

#import <ATAnimationKit/ATAnimationKit.h>

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSUInteger, ATCorner) { ATCornerTopLeft, ATCornerTopRight, ATCornerBottomRight, ATCornerBottomLeft, };

@interface ATAppDelegate () <ATAnimationDelegate>

@end

@implementation ATAppDelegate {
  CALayer *_cornerLoopLayer;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  [DDLog addLogger:[DDASLLogger sharedInstance]];
  [DDLog addLogger:[DDTTYLogger sharedInstance]];

  [[ATAnimator sharedAnimator] start];

  NSView *contentView = self.window.contentView;
  contentView.wantsLayer = YES;

  _cornerLoopLayer = [CALayer layer];
  _cornerLoopLayer.frame = CGRectMake(0, 0, 30, 30);
  _cornerLoopLayer.backgroundColor = [NSColor blueColor].CGColor;
  [contentView.layer addSublayer:_cornerLoopLayer];

  // Animate
  ATBasicAnimation *animation = [self animationToCorner:ATCornerTopLeft];
  [[ATAnimator sharedAnimator] addAnimation:animation forKey:@"toTopLeft"];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
  [[ATAnimator sharedAnimator] stop];
}

- (void)animationDidStart:(ATAnimation *)animation
{
  ATLogDebug(@"Started: %@", animation);
}

- (void)animationDidStop:(ATAnimation *)animation finished:(BOOL)finished
{
  ATLogDebug(@"Stopped: %@ finished: %d", animation, finished);

  if (!finished) {
    return;
  }

  if (animation == [[ATAnimator sharedAnimator] animationForKey:@"toTopLeft"]) {
    ATBasicAnimation *animation = [self animationToCorner:ATCornerTopRight];
    [[ATAnimator sharedAnimator] addAnimation:animation forKey:@"toTopRight"];
  } else if (animation == [[ATAnimator sharedAnimator] animationForKey:@"toTopRight"]) {
    ATBasicAnimation *animation = [self animationToCorner:ATCornerBottomRight];
    [[ATAnimator sharedAnimator] addAnimation:animation forKey:@"toBottomRight"];
  } else if (animation == [[ATAnimator sharedAnimator] animationForKey:@"toBottomRight"]) {
    ATBasicAnimation *animation = [self animationToCorner:ATCornerBottomLeft];
    [[ATAnimator sharedAnimator] addAnimation:animation forKey:@"toBottomLeft"];
  } else if (animation == [[ATAnimator sharedAnimator] animationForKey:@"toBottomLeft"]) {
    ATBasicAnimation *animation = [self animationToCorner:ATCornerTopLeft];
    [[ATAnimator sharedAnimator] addAnimation:animation forKey:@"toTopLeft"];
  }
}

- (ATBasicAnimation *)animationToCorner:(ATCorner)corner
{
  CGRect rect = ((NSView *)self.window.contentView).layer.bounds;
  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);

  ATBasicAnimation *animation = [ATBasicAnimation animationWithObject:_cornerLoopLayer keyPath:@"frame"];

  CGRect toRect;
  switch (corner) {
  case ATCornerTopLeft:
    toRect = CGRectMake(0, height - 60, 60, 60);
    break;
  case ATCornerTopRight:
    toRect = CGRectMake(width - 90, height - 90, 90, 90);
    break;
  case ATCornerBottomRight:
    toRect = CGRectMake(width - 120, 0, 120, 120);
    break;
  case ATCornerBottomLeft:
    toRect = CGRectMake(0, 0, 30, 30);
    break;
  }

  animation.toValue = [NSValue valueWithCGRect:toRect];
  animation.duration = 2;
  animation.delegate = self;
  return animation;
}

@end
