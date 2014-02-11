//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#ifndef ATARITHMETIC_H_
#define ATARITHMETIC_H_

#include <ATBase/ATBaseDefines.h>

#include <CoreGraphics/CGAffineTransform.h>
#include <CoreGraphics/CGGeometry.h>

#include <QuartzCore/CATransform3D.h>

#define AT_MINUS(a, b)                                                                                                 \
  _Generic((a), float                                                                                                  \
           : minus_float, double                                                                                       \
           : minus_double, CGPoint                                                                                     \
           : minus_CGPoint, CGSize                                                                                     \
           : minus_CGSize, CGRect                                                                                      \
           : minus_CGRect, CGAffineTransform                                                                           \
           : minus_CGAffineTransform, CATransform3D                                                                    \
           : minus_CATransform3D)(a, b)

float minus_float(float a, float b);
double minus_double(double a, double b);
CGPoint minus_CGPoint(CGPoint a, CGPoint b);
CGSize minus_CGSize(CGSize a, CGSize b);
CGRect minus_CGRect(CGRect a, CGRect b);
CGAffineTransform minus_CGAffineTransform(CGAffineTransform a, CGAffineTransform b);
CATransform3D minus_CATransform3D(CATransform3D a, CATransform3D b);

#define AT_MULTIPLY(a, b)                                                                                              \
  _Generic((a), float                                                                                                  \
           : multiply_float, double                                                                                    \
           : multiply_double, CGPoint                                                                                  \
           : multiply_CGPoint, CGSize                                                                                  \
           : multiply_CGSize, CGRect                                                                                   \
           : multiply_CGRect, CGAffineTransform                                                                        \
           : multiply_CGAffineTransform, CATransform3D                                                                 \
           : multiply_CATransform3D)(a, b)

float multiply_float(float a, CGFloat b);
double multiply_double(double a, CGFloat b);
CGPoint multiply_CGPoint(CGPoint a, CGFloat b);
CGSize multiply_CGSize(CGSize a, CGFloat b);
CGRect multiply_CGRect(CGRect a, CGFloat b);
CGAffineTransform multiply_CGAffineTransform(CGAffineTransform a, CGFloat b);
CATransform3D multiply_CATransform3D(CATransform3D a, CGFloat b);

#endif /* ATARITHMETIC_H_ */