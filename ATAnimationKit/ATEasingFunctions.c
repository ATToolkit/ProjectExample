//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#include "ATEasingFunctions.h"

#define X0(curve) startPoint.x
#define X1(curve) curve.controlPoint0.x
#define X2(curve) curve.controlPoint1.x
#define X3(curve) endPoint.x

#define Y0(curve) startPoint.y
#define Y1(curve) curve.controlPoint0.y
#define Y2(curve) curve.controlPoint1.y
#define Y3(curve) endPoint.y

const ATBezierCurve linear = { { 1, 1 }, { 0, 0 } };
const ATBezierCurve easeInSine = { { 0.47, 0 }, { 0.745, 0.715 } };
const ATBezierCurve easeOutSine = { { 0.39, 0.575 }, { 0.565, 1 } };
const ATBezierCurve easeInOutSine = { { 0.445, 0.05 }, { 0.55, 0.95 } };
const ATBezierCurve easeInQuad = { { 0.55, 0.085 }, { 0.68, 0.53 } };
const ATBezierCurve easeOutQuad = { { 0.25, 0.46 }, { 0.45, 0.94 } };
const ATBezierCurve easeInOutQuad = { { 0.455, 0.03 }, { 0.515, 0.955 } };
const ATBezierCurve easeInCubic = { { 0.55, 0.055 }, { 0.675, 0.19 } };
const ATBezierCurve easeOutCubic = { { 0.215, 0.61 }, { 0.355, 1 } };
const ATBezierCurve easeInOutCubic = { { 0.645, 0.045 }, { 0.355, 1 } };
const ATBezierCurve easeInQuart = { { 0.895, 0.03 }, { 0.685, 0.22 } };
const ATBezierCurve easeOutQuart = { { 0.165, 0.84 }, { 0.44, 1 } };
const ATBezierCurve easeInOutQuart = { { 0.77, 0 }, { 0.175, 1 } };
const ATBezierCurve easeInQuint = { { 0.755, 0.05 }, { 0.855, 0.06 } };
const ATBezierCurve easeOutQuint = { { 0.23, 1 }, { 0.32, 1 } };
const ATBezierCurve easeInOutQuint = { { 0.86, 0 }, { 0.07, 1 } };
const ATBezierCurve easeInExpo = { { 0.95, 0.05 }, { 0.795, 0.035 } };
const ATBezierCurve easeOutExpo = { { 0.19, 1 }, { 0.22, 1 } };
const ATBezierCurve easeInOutExpo = { { 1, 0 }, { 0, 1 } };
const ATBezierCurve easeInCirc = { { 0.6, 0.04 }, { 0.98, 0.335 } };
const ATBezierCurve easeOutCirc = { { 0.075, 0.82 }, { 0.165, 1 } };
const ATBezierCurve easeInOutCirc = { { 0.785, 0.135 }, { 0.15, 0.86 } };
const ATBezierCurve easeInBack = { { 0.6, -0.28 }, { 0.735, 0.045 } };
const ATBezierCurve easeOutBack = { { 0.175, 0.885 }, { 0.32, 1.275 } };
const ATBezierCurve easeInOutBack = { { 0.68, -0.55 }, { 0.265, 1.55 } };

static const CGPoint startPoint = { 0, 0 };
static const CGPoint endPoint = { 1, 1 };

AT_INLINE CGFloat m_t(ATBezierCurve curve, CGFloat t)
{
  const CGFloat A = X3(curve) - 3 * X2(curve) + 3 * X1(curve) - X0(curve);
  const CGFloat B = 3 * X2(curve) - 6 * X1(curve) + 3 * X0(curve);
  const CGFloat C = 3 * X1(curve) - 3 * X0(curve);

  return 1.0 / (((A * 3.0) * t + B * 2.0) * t + C);
}

AT_INLINE CGFloat x_t(ATBezierCurve curve, CGFloat t)
{
  const CGFloat A = X3(curve) - 3 * X2(curve) + 3 * X1(curve) - X0(curve);
  const CGFloat B = 3 * X2(curve) - 6 * X1(curve) + 3 * X0(curve);
  const CGFloat C = 3 * X1(curve) - 3 * X0(curve);
  const CGFloat D = X0(curve);

  // At^3 + Bt^2 + Ct + D
  return ((A * t + B) * t + C) * t + D;
}

AT_INLINE CGFloat y_t(ATBezierCurve curve, CGFloat t)
{
  const CGFloat E = Y3(curve) - 3 * Y2(curve) + 3 * Y1(curve) - Y0(curve);
  const CGFloat F = 3 * Y2(curve) - 6 * Y1(curve) + 3 * Y0(curve);
  const CGFloat G = 3 * Y1(curve) - 3 * Y0(curve);
  const CGFloat H = Y0(curve);

  // Et^3 + Ft^2 + Gt + H
  return ((E * t + F) * t + G) * t + H;
}

AT_INLINE CGFloat clampToUnit(CGFloat value)
{
  if (value < 0)
    return 0;
  if (value > 1)
    return 1;
  return value;
}

CGFloat cubicBezier(ATBezierCurve curve, CGFloat x)
{
  CGFloat currentT = x;

  for (int i = 0; i < CURVE_REFINEMENT_ITERATIONS; i++) {
    CGFloat currentX = x_t(curve, currentT);
    CGFloat currentM = m_t(curve, currentT);
    currentT -= (currentX - x) * currentM;
    currentT = clampToUnit(currentT);
  }

  return y_t(curve, currentT);
}
