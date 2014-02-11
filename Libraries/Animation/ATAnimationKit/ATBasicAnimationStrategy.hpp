//  Copyright (c) 2014 Andrew Toulouse. All rights reserved.

#ifndef ATBASICANIMATIONSTRATEGY_H_
#define ATBASICANIMATIONSTRATEGY_H_

#include <CoreGraphics/CGAffineTransform.h>
#include <CoreGraphics/CGGeometry.h>

#include <QuartzCore/CATransform3D.h>

#include "ATPropertyAnimationStrategy.hpp"
#include "ATValue.h"

#pragma mark - Basic Property Strategy

namespace AT {
namespace Animation {
class BasicPropertyStrategy : public PropertyStrategy {
public:
  virtual void setPercent(float percent) {};
  virtual float getPercent()
  {
    return 0;
  };
};

template <class Derived, typename T>
class BasicPropertyStrategyTemplate : public BasicPropertyStrategy, public PropertyStrategyTemplate<Derived, T> {
protected:
  float _percent;
  ATValue interpolate(ATValue fromValue, ATValue toValue, float percent);

public:
  void setPercent(float percent)
  {
    if (_percent == percent) {
      return;
    }
    _percent = percent;

    this->_currentValue = static_cast<Derived *>(this)->interpolate(this->_fromValue, this->_toValue, this->_percent);
  }

  float getPercent()
  {
    return _percent;
  }
};

#pragma mark - Basic Property Strategy Implementations

class FloatBasicPropertyStrategy : public BasicPropertyStrategyTemplate<FloatBasicPropertyStrategy, float> {
  friend class BasicPropertyStrategyTemplate<FloatBasicPropertyStrategy, float>;
  ATValue interpolate(ATValue fromValue, ATValue toValue, float percent);
};

class DoubleBasicPropertyStrategy : public BasicPropertyStrategyTemplate<DoubleBasicPropertyStrategy, double> {
  friend class BasicPropertyStrategyTemplate<DoubleBasicPropertyStrategy, double>;
  ATValue interpolate(ATValue fromValue, ATValue toValue, float percent);
};

class CGPointBasicPropertyStrategy : public BasicPropertyStrategyTemplate<CGPointBasicPropertyStrategy, CGPoint> {
  friend class BasicPropertyStrategyTemplate<CGPointBasicPropertyStrategy, CGPoint>;
  ATValue interpolate(ATValue fromValue, ATValue toValue, float percent);
};

class CGSizeBasicPropertyStrategy : public BasicPropertyStrategyTemplate<CGSizeBasicPropertyStrategy, CGSize> {
  friend class BasicPropertyStrategyTemplate<CGSizeBasicPropertyStrategy, CGSize>;
  ATValue interpolate(ATValue fromValue, ATValue toValue, float percent);
};

class CGRectBasicPropertyStrategy : public BasicPropertyStrategyTemplate<CGRectBasicPropertyStrategy, CGRect> {
  friend class BasicPropertyStrategyTemplate<CGRectBasicPropertyStrategy, CGRect>;
  ATValue interpolate(ATValue fromValue, ATValue toValue, float percent);
};

class CGAffineTransformBasicPropertyStrategy
    : public BasicPropertyStrategyTemplate<CGAffineTransformBasicPropertyStrategy, CGAffineTransform> {
  friend class BasicPropertyStrategyTemplate<CGAffineTransformBasicPropertyStrategy, CGAffineTransform>;
  ATValue interpolate(ATValue fromValue, ATValue toValue, float percent);
};

class CATransform3DBasicPropertyStrategy
    : public BasicPropertyStrategyTemplate<CATransform3DBasicPropertyStrategy, CATransform3D> {
  friend class BasicPropertyStrategyTemplate<CATransform3DBasicPropertyStrategy, CATransform3D>;
  ATValue interpolate(ATValue fromValue, ATValue toValue, float percent);
};
}
}

#endif /* ATBASICANIMATIONSTRATEGY_H_ */
