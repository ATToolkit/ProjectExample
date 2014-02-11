//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#ifndef ATVALUE_H_
#define ATVALUE_H_

#include <CoreGraphics/CGAffineTransform.h>
#include <CoreGraphics/CGGeometry.h>

#include <QuartzCore/CATransform3D.h>

union ATValue {
  float floatValue;
  double doubleValue;
  CGPoint pointValue;
  CGSize sizeValue;
  CGRect rectValue;
  CGAffineTransform affineTransformValue;
  CATransform3D transform3DValue;
};

#endif /* ATVALUE_H_ */
