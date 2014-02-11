//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "ATDisplayLink.h"

#import <ATBase/ATAssert.h>

@interface ATDisplayLink () {
  CVDisplayLinkRef _displayLink;

  dispatch_queue_t _startStopQueue;
  dispatch_queue_t _displayQueue;

  uint32_t _isDisplaying;

  __weak id _target;
  SEL _selector;
}

static CVReturn ATDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp *inNow,
                                      const CVTimeStamp *inOutputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut,
                                      void *displayLinkContext);

static void ATDisplayLinkDisplay(void *displayLinkContext);

@end

@implementation ATDisplayLink

+ (instancetype)displayLinkWithTarget:(id)target selector:(SEL)selector
{
  return [[self alloc] initWithTarget:target selector:selector];
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector
{
  if (self = [super init]) {
    CVReturn status = CVDisplayLinkCreateWithActiveCGDisplays(&_displayLink);
    ATAssert(status == kCVReturnSuccess, @"Display link creation not successful");

    _target = target;
    _selector = selector;

    _paused = YES;

    _startStopQueue = dispatch_queue_create("se.atoulou.ATDisplayLink.startStopQueue", DISPATCH_QUEUE_SERIAL);
    _displayQueue = dispatch_queue_create("se.atoulou.ATDisplayLink.displayQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(_displayQueue, dispatch_get_main_queue());

    CVDisplayLinkSetOutputCallback(_displayLink, ATDisplayLinkCallback, (__bridge void *)self);
  }
  return self;
}

- (void)dealloc
{
  CVDisplayLinkStop(_displayLink);
  CVDisplayLinkRelease(_displayLink);
}

- (void)setPaused:(BOOL)paused
{
  if (_paused != paused) {
    _paused = paused;
    if (paused) {
      dispatch_suspend(_startStopQueue);
    } else {
      dispatch_async(_startStopQueue, ^{
// Retain self while display link is running.
#ifndef __clang_analyzer__
        // Intentional; released later
        CFBridgingRetain(self);
#endif
        CVDisplayLinkStart(_displayLink);
      });
    }
  }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
static CVReturn ATDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp *inNow,
                                      const CVTimeStamp *inOutputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut,
                                      void *displayLinkContext)
{
  ATDisplayLink *self = (__bridge ATDisplayLink *)displayLinkContext;

  if (self->_paused) {
    CVDisplayLinkStop(self->_displayLink);
    dispatch_resume(self->_startStopQueue);
    CFBridgingRelease(displayLinkContext);
    // Atomically check !displaying. Will return true if displaying was false then set displaying to true.
  } else if (!OSAtomicTestAndSetBarrier(0, &self->_isDisplaying)) {
    CFTimeInterval timestamp = 1.0 / (inOutputTime->rateScalar * (double)inOutputTime->videoTimeScale /
                                      (double)inOutputTime->videoRefreshPeriod);

    self->_timestamp = timestamp;
    dispatch_async_f(self->_displayQueue, (void *)CFBridgingRetain(self), ATDisplayLinkDisplay);
  }

  return kCVReturnSuccess;
}
#pragma clang diagnostic pop

static void ATDisplayLinkDisplay(void *displayLinkContext)
{
  ATDisplayLink *self = CFBridgingRelease(displayLinkContext);
  if (!self->_paused) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self->_target performSelector:self->_selector withObject:self];
#pragma clang diagnostic pop
  }
  OSAtomicTestAndClearBarrier(0, &self->_isDisplaying);
}

@end
