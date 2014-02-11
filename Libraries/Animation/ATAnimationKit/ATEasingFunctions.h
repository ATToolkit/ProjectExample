//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#ifndef ATEASINGFUNCTIONS_H_
#define ATEASINGFUNCTIONS_H_

#include <ATBase/ATBaseDefines.h>

#include <CoreGraphics/CoreGraphics.h>

#define CURVE_REFINEMENT_ITERATIONS 5

struct ATBezierCurve {
  const CGPoint controlPoint0;
  const CGPoint controlPoint1;
};
typedef struct ATBezierCurve ATBezierCurve;

AT_EXTERN const ATBezierCurve linear;
AT_EXTERN const ATBezierCurve easeInSine;
AT_EXTERN const ATBezierCurve easeOutSine;
AT_EXTERN const ATBezierCurve easeInOutSine;
AT_EXTERN const ATBezierCurve easeInQuad;
AT_EXTERN const ATBezierCurve easeOutQuad;
AT_EXTERN const ATBezierCurve easeInOutQuad;
AT_EXTERN const ATBezierCurve easeInCubic;
AT_EXTERN const ATBezierCurve easeOutCubic;
AT_EXTERN const ATBezierCurve easeInOutCubic;
AT_EXTERN const ATBezierCurve easeInQuart;
AT_EXTERN const ATBezierCurve easeOutQuart;
AT_EXTERN const ATBezierCurve easeInOutQuart;
AT_EXTERN const ATBezierCurve easeInQuint;
AT_EXTERN const ATBezierCurve easeOutQuint;
AT_EXTERN const ATBezierCurve easeInOutQuint;
AT_EXTERN const ATBezierCurve easeInExpo;
AT_EXTERN const ATBezierCurve easeOutExpo;
AT_EXTERN const ATBezierCurve easeInOutExpo;
AT_EXTERN const ATBezierCurve easeInCirc;
AT_EXTERN const ATBezierCurve easeOutCirc;
AT_EXTERN const ATBezierCurve easeInOutCirc;
AT_EXTERN const ATBezierCurve easeInBack;
AT_EXTERN const ATBezierCurve easeOutBack;
AT_EXTERN const ATBezierCurve easeInOutBack;

AT_EXTERN CGFloat cubicBezier(ATBezierCurve curve, CGFloat x);

#endif /* ATEASINGFUNCTIONS_H_ */
