//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#include "ATPropertyAnimationStrategy.hpp"

using namespace AT::Animation;

void PropertyStrategy::setFromValue(ATValue fromValue)
{
  _fromValue = fromValue;
}

ATValue PropertyStrategy::getFromValue()
{
  return _fromValue;
}

void PropertyStrategy::setToValue(ATValue toValue)
{
  _toValue = toValue;
}

ATValue PropertyStrategy::getToValue()
{
  return _toValue;
}

ATValue PropertyStrategy::getCurrentValue()
{
  return _currentValue;
}