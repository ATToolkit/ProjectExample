//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import <ATBase/ATBaseDefines.h>

// TODO: ATCAssert

#define THREAD_AFFINITY_MISMATCH_IS_FATAL YES

#define _InternalAssert(condition, fatal, ...)                                                                         \
  [ATAssert _internalAssertWithCondition:(BOOL)(condition)                                                             \
                                 isFatal:(BOOL)(fatal)                                                                 \
                          prettyFunction:__PRETTY_FUNCTION__                                                           \
                                    file:__FILE__                                                                      \
                                    line:__LINE__                                                                      \
                                  format:__VA_ARGS__]

#define ATAssert(condition, ...) _InternalAssert(condition, NO, ##__VA_ARGS__)
#define ATFailAssert(...) _InternalAssert(NO, YES, ##__VA_ARGS__)
#define ATAssertMainThread()                                                                                           \
  _InternalAssert([NSThread isMainThread], THREAD_AFFINITY_MISMATCH_IS_FATAL,                                          \
                  @"Thread affinity error: called from non-main thread")
#define ATAssertNotMainThread()                                                                                        \
  _InternalAssert(![NSThread isMainThread], THREAD_AFFINITY_MISMATCH_IS_FATAL,                                         \
                  @"Thread affinity error: called from main thread")
#define ATAssertNil(object) ATAssert((object) == nil, @"Object is not nil")
#define ATAssertNotNil(object) ATAssert((object) != nil, @"Object is nil")

#define AT_IMPLEMENTED_BY_SUBCLASS ATFailAssert(@"Must be implemented by subclass")

@interface ATAssert : NSObject

+ (void)_internalAssertWithCondition:(BOOL)condition
                             isFatal:(BOOL)fatal
                      prettyFunction:(const char *)prettyFunc
                                file:(const char *)file
                                line:(int)line
                              format:(NSString *)format, ... __attribute__((format(__NSString__, 6, 7)));

@end
