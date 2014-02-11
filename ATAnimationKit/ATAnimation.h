//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import <ATAnimationKit/ATEasingFunctions.h>

@protocol ATAnimationDelegate;

@interface ATAnimation : NSObject

@property(nonatomic, assign, getter=isRemovedOnCompletion) BOOL removedOnCompletion;

// TODO: document why the delegate is retained
@property(nonatomic, strong) id<ATAnimationDelegate> delegate;

@property(nonatomic, assign, readonly, getter=isRunning) BOOL running;

@end

@protocol ATAnimationDelegate <NSObject>

@optional
- (void)animationDidStart:(ATAnimation *)animation;
- (void)animationDidStop:(ATAnimation *)animation finished:(BOOL)finished;

@end
