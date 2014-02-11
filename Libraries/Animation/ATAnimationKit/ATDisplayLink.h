//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

@interface ATDisplayLink : NSObject

+ (ATDisplayLink *)displayLinkWithTarget:(id)target selector:(SEL)sel;

@property(nonatomic, readonly) CFTimeInterval timestamp;
@property(nonatomic, getter=isPaused) BOOL paused;

@end
