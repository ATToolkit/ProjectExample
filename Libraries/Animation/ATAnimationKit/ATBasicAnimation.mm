//  Created by Andrew Toulouse on 12/27/13.

#import "ATBasicAnimation.h"

#import <ATBase/ATAssert.h>
#import <ATBase/NSObject+Reflection.h>
#import <ATBase/NSValue+Helpers.h>

#include <CoreGraphics/CGAffineTransform.h>
#include <CoreGraphics/CGGeometry.h>

#include <QuartzCore/CATransform3D.h>

#import "ATAnimation.h"
#import "ATAnimation_Subclass.h"
#import "ATPropertyAnimation.h"
#import "ATPropertyAnimation_Internal.hpp"
#import "ATBasicAnimationStrategy.hpp"

@interface ATBasicAnimation ()

@property(nonatomic, assign) float percent;

@end

@implementation ATBasicAnimation

- (BOOL)shouldStopAtTime:(CFTimeInterval)time
{
  CFTimeInterval timeSinceStart = (time - self.beganTime);
  return timeSinceStart >= self.duration;
}

- (void)applyAnimationAtTime:(CFTimeInterval)time
{
  [super applyAnimationAtTime:time];

  const CFTimeInterval timeSinceStart = (time - self.beganTime);
  self.percent = timeSinceStart / _duration;
}

#pragma mark -

- (void)setPercent:(float)percent
{
  AT::Animation::BasicPropertyStrategy *strategy =
      static_cast<AT::Animation::BasicPropertyStrategy *>(self.propertyStrategy);

  if (strategy->getPercent() == percent) {
    return;
  }

  strategy->setPercent(percent);
  [self.object setValue:self.currentValue forKeyPath:self.keyPath];
}

- (float)percent
{
  AT::Animation::BasicPropertyStrategy *strategy =
      static_cast<AT::Animation::BasicPropertyStrategy *>(self.propertyStrategy);
  return strategy->getPercent();
}

#pragma mark - Property Strategy factory(barf) method

+ (AT::Animation::PropertyStrategy *)newPropertyStrategyForType:(NSString *)encodedType
{
  const char *type = [encodedType UTF8String];

  if (AT_ENCODING_IS_EQUAL(ATEncodings.floatEncoding, type)) {
    return new AT::Animation::FloatBasicPropertyStrategy;
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.doubleEncoding, type)) {
    return new AT::Animation::DoubleBasicPropertyStrategy;
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.pointEncoding, type)) {
    return new AT::Animation::CGPointBasicPropertyStrategy;
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.sizeEncoding, type)) {
    return new AT::Animation::CGSizeBasicPropertyStrategy;
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.rectEncoding, type)) {
    return new AT::Animation::CGRectBasicPropertyStrategy;
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.affineTransformEncoding, type)) {
    return new AT::Animation::CGAffineTransformBasicPropertyStrategy;
  } else if (AT_ENCODING_IS_EQUAL(ATEncodings.transform3DEncoding, type)) {
    return new AT::Animation::CATransform3DBasicPropertyStrategy;
  } else {
    ATFailAssert(@"Interpolation not supported");
    return NULL;
  }
}

@end
