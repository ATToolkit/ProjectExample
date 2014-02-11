//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#include "ATArithmetic.h"

#pragma mark - AT_MINUS

float minus_float(float a, float b)
{
  return a - b;
}

double minus_double(double a, double b)
{
  return a - b;
}

CGPoint minus_CGPoint(CGPoint a, CGPoint b)
{
  return CGPointMake(a.x - b.x, a.y - b.y);
}

CGSize minus_CGSize(CGSize a, CGSize b)
{
  return CGSizeMake(a.width - b.width, a.height - b.height);
}

CGRect minus_CGRect(CGRect a, CGRect b)
{
  return (CGRect) { minus_CGPoint(a.origin, b.origin), minus_CGSize(a.size, b.size) };
}

CGAffineTransform minus_CGAffineTransform(CGAffineTransform a, CGAffineTransform b)
{
  return CGAffineTransformIdentity;
}

CATransform3D minus_CATransform3D(CATransform3D a, CATransform3D b)
{
  return CATransform3DIdentity;
}

#pragma mark - AT_MULTIPLY

float multiply_float(float a, CGFloat b)
{
  return a * b;
}

double multiply_double(double a, CGFloat b)
{
  return a * b;
}

CGPoint multiply_CGPoint(CGPoint a, CGFloat b)
{
  return CGPointMake(a.x * b, a.y * b);
}

CGSize multiply_CGSize(CGSize a, CGFloat b)
{
  return CGSizeMake(a.width * b, a.height * b);
}

CGRect multiply_CGRect(CGRect a, CGFloat b)
{
  return (CGRect) { multiply_CGPoint(a.origin, b), multiply_CGSize(a.size, b) };
}

CGAffineTransform multiply_CGAffineTransform(CGAffineTransform a, CGFloat b)
{
  return CGAffineTransformIdentity;
}

CATransform3D multiply_CATransform3D(CATransform3D a, CGFloat b)
{
  return CATransform3DIdentity;
}
