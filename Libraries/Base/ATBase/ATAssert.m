//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#import "ATAssert.h"

#import <ATBase/ATLog.h>

@implementation ATAssert

+ (void)_internalAssertWithCondition:(BOOL)condition
                             isFatal:(BOOL)fatal
                      prettyFunction:(const char *)prettyFunction
                                file:(const char *)file
                                line:(int)line
                              format:(NSString *)format, ...
{
  if (!condition) {
    NSString *logMessage = nil;
    if (format) {
      va_list args;
      va_start(args, format);
      logMessage = [[NSString alloc] initWithFormat:format arguments:args];
      va_end(args);
    }

    if (logMessage) {
      ATLogError(@"Assertion at %s:%d: %@", prettyFunction, line, logMessage);
    } else {
      ATLogError(@"Assertion at %s:%d", prettyFunction, line);
    }

    if (fatal) {
      abort();
    } else {
      raise(SIGTRAP);
    }
  }
}

@end
