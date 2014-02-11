//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#include "ATBasicAnimationStrategy.hpp"

using namespace AT::Animation;

ATValue FloatBasicPropertyStrategy::interpolate(ATValue fromValue, ATValue toValue, float percent)
{
  ATValue result;
  result.floatValue = fromValue.floatValue + (toValue.floatValue - fromValue.floatValue) * percent;
  return result;
}

ATValue DoubleBasicPropertyStrategy::interpolate(ATValue fromValue, ATValue toValue, float percent)
{
  ATValue result;
  result.doubleValue = fromValue.doubleValue + (toValue.doubleValue - fromValue.doubleValue) * (double)percent;
  return result;
}

ATValue CGPointBasicPropertyStrategy::interpolate(ATValue fromValue, ATValue toValue, float percent)
{
  ATValue result;
  const CGFloat x = fromValue.pointValue.x + (toValue.pointValue.x - fromValue.pointValue.x) * percent;
  const CGFloat y = fromValue.pointValue.y + (toValue.pointValue.y - fromValue.pointValue.y) * percent;
  result.pointValue = CGPointMake(x, y);
  return result;
}

ATValue CGSizeBasicPropertyStrategy::interpolate(ATValue fromValue, ATValue toValue, float percent)
{
  ATValue result;
  const CGFloat width = fromValue.sizeValue.width + (toValue.sizeValue.width - fromValue.sizeValue.width) * percent;
  const CGFloat height = fromValue.sizeValue.height + (toValue.sizeValue.height - fromValue.sizeValue.height) * percent;
  result.sizeValue = CGSizeMake(width, height);
  return result;
}

ATValue CGRectBasicPropertyStrategy::interpolate(ATValue fromValue, ATValue toValue, float percent)
{
  ATValue result;
  const CGFloat x =
      fromValue.rectValue.origin.x + (toValue.rectValue.origin.x - fromValue.rectValue.origin.x) * percent;
  const CGFloat y =
      fromValue.rectValue.origin.y + (toValue.rectValue.origin.y - fromValue.rectValue.origin.y) * percent;
  const CGFloat width =
      fromValue.rectValue.size.width + (toValue.rectValue.size.width - fromValue.rectValue.size.width) * percent;
  const CGFloat height =
      fromValue.rectValue.size.height + (toValue.rectValue.size.height - fromValue.rectValue.size.height) * percent;
  result.rectValue = CGRectMake(x, y, width, height);
  return result;
}

ATValue CGAffineTransformBasicPropertyStrategy::interpolate(ATValue fromValue, ATValue toValue, float percent)
{
  return toValue;
}

ATValue CATransform3DBasicPropertyStrategy::interpolate(ATValue fromValue, ATValue toValue, float percent)
{
  return toValue;
}
