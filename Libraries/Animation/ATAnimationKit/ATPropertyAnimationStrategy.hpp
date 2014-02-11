//  Copyright (c) 2013 Andrew Toulouse. All rights reserved.

#ifndef ATPROPERTYANIMATIONSTRATEGY_H_
#define ATPROPERTYANIMATIONSTRATEGY_H_

#include "ATValue.h"

namespace AT {
namespace Animation {

#pragma mark - Property Strategy Base

class PropertyStrategy {
protected:
  ATValue _fromValue;
  ATValue _toValue;
  ATValue _currentValue;

public:
  void setFromValue(ATValue fromValue);
  ATValue getFromValue();

  void setToValue(ATValue toValue);
  ATValue getToValue();

  ATValue getCurrentValue();
};

template <class Derived, typename T> class PropertyStrategyTemplate {
};
}
}
#endif /* ATPROPERTYANIMATIONSTRATEGY_H_ */
